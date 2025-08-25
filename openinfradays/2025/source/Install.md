## 0.  Istio 1.27.0
- VM 내에서 실행
```shell
# 설치
./install_istio_ambient.sh install

# 상태 확인
./install_istio_ambient.sh status

# 네임스페이스 Ambient 활성화
./install_istio_ambient.sh enable-ns team-a

# Waypoint 생성
./install_istio_ambient.sh waypoint team-a team-a-waypoint

# 제거(전체 purge)
./install_istio_ambient.sh uninstall

# 특정 리비전만 제거
./install_istio_ambient.sh uninstall --revision 1-27-0
./install_istio_ambient.sh uninstall --set revision=1-27-0
```

## 1. metallb 0.15.2
```shell
# create namespace
kubectl create ns metallb-system

# pod security setting
kubectl label --overwrite ns metallb-system \
  pod-security.kubernetes.io/enforce=privileged \
  pod-security.kubernetes.io/audit=privileged \
  pod-security.kubernetes.io/warn=privileged

# helm repo
helm repo add metallb https://metallb.github.io/metallb
helm repo update metallb

# helm install
helm upgrade --install metallb metallb/metallb --version 0.15.2 -f ./scripts/helm/metallb-0.15.2.yaml -n metallb-system --wait

# expose ip setting
kubectl apply -f ./scripts/helm/metallb/IPAddressPool.yaml
kubectl apply -f ./scripts/helm/metallb/L2Advertisement.yaml
```

## 2. NFS-Server 4.0.2
```shell
# helm repo
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner
helm repo update nfs-subdir-external-provisioner

# helm install
helm upgrade --install nfs-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --version 4.0.18 -f ./scripts/helm/nfs-subdir-external-provisioner-4.0.2.yaml -n kube-system 

```

## 3. Istio Gateway 1.27.0
```shell
# helm repo
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update istio

# - at '': additional properties '_internal_defaults_do_not_set' not allowed 오류 이슈
# helm install
helm upgrade --install istio-ingress istio/gateway --version 1.27.0 -f ./scripts/helm/istio-gateway-1.27.0.yaml -n istio-system --wait --skip-schema-validation

# hubble expose
kubectl apply -f ./network/hubble-expose.yaml
```

## 4. Kiali 2.14.0
```shell
# helm repo
helm repo add kiali https://kiali.org/helm-charts
helm repo update kiali

# helm install
helm upgrade --install kiali-server kiali/kiali-server --version 2.14.0 -f ./scripts/helm/kiali-server-2.14.0.yaml -n istio-system --wait

# kiali expose
kubectl apply -f ./network/kiali-expose.yaml
```

## 5. Prometheus 3.5.0
```shell
# create namespace
kubectl create ns node-metrics

# pod security setting
kubectl label --overwrite ns node-metrics \
 pod-security.kubernetes.io/enforce=privileged \
 pod-security.kubernetes.io/audit=privileged \
 pod-security.kubernetes.io/warn=privileged

# helm repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update prometheus-community

# helm install
helm upgrade --install prometheus prometheus-community/prometheus --version 27.31.0 -n monitoring --create-namespace -f ./scripts/helm/prometheus-3.5.0.yaml

# expose ip setting
kubectl apply -f ./network/prometheus-network-policy.yaml
```

## 6. Grafana 12.1.0
``` shell
# helm repo
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update grafana

# helm install
helm upgrade --install grafana grafana/grafana --version 9.3.2 -f ./scripts/helm/grafana-12.1.0.yaml -n monitoring --create-namespace

# grafana expose
kubectl apply -f ./network/grafana-expose.yaml
```