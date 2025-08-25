#!/usr/bin/env bash

# Global Variable Setting
source /vagrant/scripts/00.global_variable.sh

# 받은 파일을 다시 받지 않도록
if [ ! -f ~/rke2-artifacts/install.sh ]; then
# Air gap install
mkdir -p ~/rke2-artifacts && cd ~/rke2-artifacts

# 2. RKE2 바이너리 및 이미지 파일 다운로드
curl -OLs https://github.com/rancher/rke2/releases/download/v1.32.7%2Brke2r1/rke2-images.linux-arm64.tar.zst
curl -OLs https://github.com/rancher/rke2/releases/download/v1.32.7%2Brke2r1/rke2.linux-arm64.tar.gz
curl -OLs https://github.com/rancher/rke2/releases/download/v1.32.7%2Brke2r1/sha256sum-arm64.txt
curl -sfL https://get.rke2.io --output install.sh
fi

# etcd 스냅샷 디렉토리 생성 및 권한설정
sudo mkdir -p /var/lib/rancher/rke2/snapshots
#sudo chown -R rke2:rke2 /var/lib/rancher/rke2/snapshots

# config.yaml 생성
sudo mkdir -p /etc/rancher/rke2/

if [ $(hostname) != master01 ]; then
  RKE2_NODE_TOKEN=$(cat /vagrant/node-token)
fi

cat << EOF | sudo tee /etc/rancher/rke2/config.yaml
profile: "cis"
write-kubeconfig-mode: "0644"
cni: "cilium"
node-ip: "$NODE_IP"
bind-address: "$NODE_IP"
advertise-address: "$NODE_IP"
tls-san:
  - "$CLUSTER_ENDPOINT"
  - "master01.cluster.local"
  - "master02.cluster.local"
  - "master03.cluster.local"
  - "$MASTER01"
  - "$MASTER02"
  - "$MASTER03"
kube-apiserver-arg:
  - "--default-not-ready-toleration-seconds=30"
  - "--default-unreachable-toleration-seconds=30"
  - "--audit-log-path=/var/log/kubernetes/audit/audit.log"
  - "--audit-policy-file=/etc/rancher/rke2/audit-policy.yaml"
  - "--audit-log-maxage=30"       # 로그 보관 기간 (일 단위)
  - "--audit-log-maxbackup=10"    # 백업 파일 최대 개수
  - "--audit-log-maxsize=100"     # 로그 파일 최대 크기 (MB 단위)
kube-controller-manager-arg:
  - "--node-monitor-period=4s"
kubelet-arg:
  - "--node-status-update-frequency=4s"
  - "--max-pods=100"
  - "--seccomp-default=true"
disable: rke2-ingress-nginx
disable-cloud-controller: true
protect-kernel-defaults: true
# Cilium이 kube-proxy 대체
disable-kube-proxy: true
node-label:
  - "role=control-plane"
  - "env=production"
debug: true
node-taint:
  - "CriticalAddonsOnly=true:NoExecute"
token: $RKE2_NODE_TOKEN
#server: https://$MASTER01:9345

# etcd 스냅샷 옵션 추가
etcd-arg:
  - "listen-peer-urls=https://${NODE_IP}:2380"
  - "listen-client-urls=https://${NODE_IP}:2379,https://127.0.0.1:2379"
  - "advertise-client-urls=https://${NODE_IP}:2379"
  - "initial-advertise-peer-urls=https://${NODE_IP}:2380"
  - "peer-cert-file=/var/lib/rancher/rke2/server/tls/etcd/peer-server-client.crt"
  - "peer-key-file=/var/lib/rancher/rke2/server/tls/etcd/peer-server-client.key"
  - "peer-trusted-ca-file=/var/lib/rancher/rke2/server/tls/etcd/server-ca.crt"
  - "quota-backend-bytes=4294967296"
etcd-snapshot-schedule-cron: "0 */6 * * *"  # 6시간마다 스냅샷 생성
etcd-snapshot-retention: 10                 # 최대 10개 스냅샷 유지
etcd-snapshot-dir: "/var/lib/rancher/rke2/snapshots"  # 저장 경로 지정
EOF

# Cilium 설치 활성화
sudo mkdir -p /var/lib/rancher/rke2/server/manifests/
cat << EOF | sudo tee /var/lib/rancher/rke2/server/manifests/rke2-cilium-config.yaml
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: rke2-cilium
  namespace: kube-system
spec:
  valuesContent: |-
    # kube-proxy 대체
    kubeProxyReplacement: true
    k8sServiceHost: "localhost"
    k8sServicePort: "6443"
    # IPAM 모드 설정
    ipam:
      mode: kubernetes
    # 직접 노드 라우팅 활성화 / 고급 네트워킹 (옵션)
    #autoDirectNodeRoutes: true # 주석 해제 시 L2 네트워크 필요

    # Istio 호환성 설정
    socketLB:
      # Istio 사이드카와 포트 충돌 방지
      hostNamespaceOnly: true

    bpf:
      masquerade: false         # Istio health check 충돌 방지

    # CNI 설정
    cni:
      # 다른 CNI와 공존 허용
      exclusive: false

    # 관측성
    hubble:
      enabled: true
      relay:
        enabled: true
      ui:
        enabled: true
      metrics:
        enabled:
          - dns:query;ignoreAAAA
          - drop
          - tcp
          - flow
          - port-distribution
          - icmp
          - http
EOF

if [ ! -f /etc/rancher/rke2/audit-policy.yaml ]; then
cat << EOF | sudo tee -a /etc/rancher/rke2/audit-policy.yaml
apiVersion: audit.k8s.io/v1
kind: Policy
metadata:
  creationTimestamp: null
rules:
  # 1. 민감한 데이터 요청은 Metadata 수준으로만 기록 (보안 강화)
  - level: Metadata
    resources:
      - group: ""
        resources: ["secrets", "configmaps"]
    omitStages:
      - "RequestReceived"

  # 2. Pod 변경 사항은 RequestResponse 수준으로 기록 (세부 모니터링)
  - level: RequestResponse
    resources:
      - group: ""
        resources: ["pods"]

  # 3. Pod 로그 및 상태 요청은 Metadata 수준으로 기록 (필요 최소 정보만 기록)
  - level: Metadata
    resources:
      - group: ""
        resources: ["pods/log", "pods/status"]

  # 4. 기본적으로 모든 요청은 Metadata 수준으로 기록 (기본 설정)
  - level: Metadata
EOF
fi

if [ $(hostname) != master01 ]; then
sudo sed -i 's/#server/server/g' /etc/rancher/rke2/config.yaml
fi

INSTALL_RKE2_TYPE="server" \
INSTALL_RKE2_VERSION="v1.32.7+rke2r1" \
INSTALL_RKE2_ARTIFACT_PATH=~/rke2-artifacts \
sudo sh -x ~/rke2-artifacts/install.sh

# 서비스 등록
sudo systemctl enable rke2-server.service --now

# node token 확인
if [ $(hostname) == master01 ]; then
  sudo cat /var/lib/rancher/rke2/server/node-token | sudo tee /vagrant/node-token
  if [ ! -f /usr/local/bin/kubectl ]; then
    # rke2 설치 후 조회
    export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
    sudo ln -s /var/lib/rancher/rke2/bin/kubectl /usr/local/bin/kubectl
    echo "export PATH=$PATH:/var/lib/rancher/rke2/bin" >> ~/.bashrc
  fi

  mkdir -p $HOME/.kube
  sudo cp /etc/rancher/rke2/rke2.yaml ~/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  kubectl get nodes

fi


