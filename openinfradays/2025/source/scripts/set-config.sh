#!/usr/bin/env bash

CLUSTER_ENDPOINT=192.168.33.11
# 마스터 노드에서 직접 인증 정보 확인
CONFIG=$(vagrant ssh master1 -c "sudo cat /etc/rancher/rke2/rke2.yaml")

# 1. 인증서 파일 생성
echo "$CONFIG" | awk '/certificate-authority-data:/ {print $2}' | base64 -d > ca.crt
echo "$CONFIG" | awk '/client-certificate-data:/ {print $2}' | base64 -d > client.crt
echo "$CONFIG" | awk '/client-key-data:/ {print $2}' | base64 -d > client.key

# 2. 클러스터 설정
kubectl config set-cluster rke2-cluster \
  --server="https://${CLUSTER_ENDPOINT}:6443" \
  --certificate-authority=./ca.crt \
  --embed-certs=true

# 3. 사용자 설정
kubectl config set-credentials vagrant-user \
  --client-certificate=./client.crt \
  --client-key=./client.key \
  --embed-certs=true

# 4. 컨텍스트 설정
kubectl config set-context rke2-context \
  --cluster=rke2-cluster \
  --user=vagrant-user

# 4. 컨텍스트 설정
kubectl config set-context rke2-context \
  --cluster=rke2-cluster \
  --user=vagrant-user

# 5. 컨텍스트 활성화
kubectl config use-context rke2-context

# 현재 컨텍스트가 올바르게 설정되었는지 확인
kubectl config current-context

# 필요시 컨텍스트 변경
kubectl config use-context vagrant

# 인증서 파일 삭제
rm ca.crt client.crt client.key

# DNS 캐시 초기화 (macOS)
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# 확인
echo "=== Current Context ==="
kubectl config current-context
echo "=== Nodes 확인 ==="
kubectl get nodes