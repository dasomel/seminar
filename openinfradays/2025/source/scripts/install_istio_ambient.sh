#!/usr/bin/env bash
set -euo pipefail

ISTIO_VERSION="${ISTIO_VERSION:-1.27.0}"
ISTIO_DIR="istio-${ISTIO_VERSION}"
ISTIOCTL_BIN="${ISTIO_DIR}/bin/istioctl"
ISTIO_NAMESPACE="${ISTIO_NAMESPACE:-istio-system}"
GATEWAY_API_VERSION="${GATEWAY_API_VERSION:-v1.3.0}"

# RKE2 기본 Cilium HelmChartConfig 경로 (환경에 맞게 필요 시 변경)
CILIUM_MANIFEST="${CILIUM_MANIFEST:-/var/lib/rancher/rke2/server/manifests/rke2-cilium-config.yaml}"

usage() {
  cat <<'EOF'
Usage:
  install_istio_ambient.sh install
    - Install Gateway API, label istio-system for CIS, install Istio Ambient, patch Cilium
  install_istio_ambient.sh verify
    - Show Istio core status summary
  install_istio_ambient.sh enable-ns <ns>
    - Enable Ambient on a namespace (istio.io/dataplane-mode=ambient)
  install_istio_ambient.sh waypoint <ns> <name>
    - Create a minimal Waypoint Gateway in a namespace
  install_istio_ambient.sh status
    - Show Istio core status (pods/ds/deploy/gatewayclasses/events)
  install_istio_ambient.sh uninstall [--revision <rev> | --set revision=<rev> | --filename <manifest.yaml> | --purge]

Env:
  ISTIO_VERSION, ISTIO_NAMESPACE, GATEWAY_API_VERSION, CILIUM_MANIFEST
EOF
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || { echo "Missing command: $1"; exit 1; }
}

# 존재만 확인하는 간소화 버전
find_kubeconfig() {
  # 0) 이미 kubectl이 동작하면 그대로 사용
  if kubectl version --short >/dev/null 2>&1; then
    return 0
  fi

  # 1) KUBECONFIG가 설정되어 있고 파일이 있으면 그대로 사용
  if [ -n "${KUBECONFIG:-}" ] && [ -f "${KUBECONFIG}" ]; then
    return 0
  fi

  # 2) 기본 경로가 있으면 그것을 사용
  if [ -f "$HOME/.kube/config" ]; then
    export KUBECONFIG="$HOME/.kube/config"
    return 0
  fi

  # 3) 시스템 kubeconfig 후보를 ~/.kube/config로 복사 시도 (발견 시에만)
  local candidates=(
    "/etc/rancher/rke2/rke2.yaml"
    "/etc/rancher/k3s/k3s.yaml"
    "/etc/kubernetes/admin.conf"
  )
  mkdir -p "$HOME/.kube"
  for f in "${candidates[@]}"; do
    if [ -f "$f" ]; then
      cp "$f" "$HOME/.kube/config" 2>/dev/null || sudo cp "$f" "$HOME/.kube/config" || true
      sudo chown "$(id -u)":"$(id -g)" "$HOME/.kube/config" 2>/dev/null || true
      export KUBECONFIG="$HOME/.kube/config"
      return 0
    fi
  done

  # 4) 여기까지 오면 kubeconfig를 못 찾았지만, 종료하지 않고 경고만 출력
  echo "[WARN] kubeconfig not found via known paths; proceeding may fail."
  echo "       Tip: export KUBECONFIG=$HOME/.kube/config  (or your actual path)"
  echo "       Tip: ensure 'server:' in kubeconfig points to reachable API (e.g., https://<MASTER_IP>:6443)"
}

download_istio() {
  if [[ ! -d "${ISTIO_DIR}" ]]; then
    echo "[INFO] Downloading Istio ${ISTIO_VERSION}"
    curl -fsSL "https://istio.io/downloadIstio" | ISTIO_VERSION="${ISTIO_VERSION}" sh -
  fi
  export PATH="$PWD/${ISTIO_DIR}/bin:$PATH"
  [[ -x "${ISTIOCTL_BIN}" ]] || { echo "[ERROR] istioctl not found at ${ISTIOCTL_BIN}"; exit 1; }
}

install_gateway_api() {
  echo "[INFO] Installing Gateway API ${GATEWAY_API_VERSION}"
  kubectl apply -f "https://github.com/kubernetes-sigs/gateway-api/releases/download/${GATEWAY_API_VERSION}/standard-install.yaml"
}

ensure_ns() {
  local ns="$1"
  kubectl get ns "${ns}" >/dev/null 2>&1 || kubectl create ns "${ns}"
}

label_ns_privileged_for_cis() {
  local ns="$1"
  echo "[INFO] Labeling namespace '${ns}' as Pod Security privileged for CIS compatibility"
  kubectl label ns "${ns}" pod-security.kubernetes.io/enforce=privileged --overwrite || true
  kubectl label ns "${ns}" pod-security.kubernetes.io/audit=privileged --overwrite || true
  kubectl label ns "${ns}" pod-security.kubernetes.io/warn=privileged --overwrite || true
}

install_istio_ambient() {
  echo "[INFO] Installing Istio ${ISTIO_VERSION} (profile=ambient)"
  "${ISTIOCTL_BIN}" install --set profile=ambient -y \
  --set values.pilot.env.PILOT_ENABLE_HBONE=true \
  --set meshConfig.accessLogFile="/dev/stdout"
}

verify_istio_simple() {
  echo "[INFO] Istio core pods:"
  kubectl -n "${ISTIO_NAMESPACE}" get pods -o wide || true
  echo "[INFO] GatewayClasses:"
  kubectl get gatewayclasses.gateway.networking.k8s.io || true
}

patch_cilium_for_ambient() {
  # kubeProxyReplacement=true 환경에서 권장: socketLB.hostNamespaceOnly=true
  if [[ -f "${CILIUM_MANIFEST}" ]]; then
    # 파일 구조에 따라 valuesContent: | 블록 내 들여쓰기가 필요할 수 있음(수동 검토 권장)
    if ! grep -qE '^[[:space:]]*socketLB:[[:space:]]*$' "${CILIUM_MANIFEST}"; then
      echo "[INFO] Appending socketLB.hostNamespaceOnly: true to ${CILIUM_MANIFEST}"
      sudo tee -a "${CILIUM_MANIFEST}" >/dev/null <<'YAML_APPEND'
  socketLB:
    hostNamespaceOnly: true
YAML_APPEND
      echo "[INFO] Change appended. RKE2 will reconcile Cilium chart."
    else
      if awk '/socketLB:/{flag=1;next}/^[^[:space:]]/{flag=0}flag' "${CILIUM_MANIFEST}" | grep -qE 'hostNamespaceOnly:[[:space:]]*false'; then
        echo "[WARN] Found socketLB.hostNamespaceOnly: false. Consider switching to true for Istio Ambient compatibility."
      else
        echo "[INFO] Cilium socketLB block present; ensure hostNamespaceOnly: true."
      fi
    fi
  else
    echo "[WARN] Cilium manifest not found at ${CILIUM_MANIFEST}. Skipping Cilium patch."
  fi
}

rollout_restart_core() {
  if kubectl -n "${ISTIO_NAMESPACE}" get ds istio-cni >/dev/null 2>&1; then
    kubectl -n "${ISTIO_NAMESPACE}" rollout restart ds/istio-cni || true
  else
    echo "[INFO] istio-cni DaemonSet not found, skipping restart."
  fi
  if kubectl -n "${ISTIO_NAMESPACE}" get ds ztunnel >/dev/null 2>&1; then
    kubectl -n "${ISTIO_NAMESPACE}" rollout restart ds/ztunnel || true
  fi
  if kubectl -n "${ISTIO_NAMESPACE}" get deploy istiod >/dev/null 2>&1; then
    kubectl -n "${ISTIO_NAMESPACE}" rollout restart deploy/istiod || true
  fi
}

enable_namespace_ambient() {
  local ns="$1"
  echo "[INFO] Enabling Ambient on namespace: ${ns}"
  kubectl label ns "${ns}" istio.io/dataplane-mode=ambient --overwrite
}

create_minimal_waypoint() {
  local ns="$1"
  local name="$2"
  cat <<YAML | kubectl -n "${ns}" apply -f -
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: ${name}
  labels:
    istio.io/use-waypoint: "true"
spec:
  gatewayClassName: istio
  listeners:
  - name: http
    hostname: "*"
    port: 8080
    protocol: HTTP
YAML
  echo "[INFO] Created Waypoint Gateway '${name}' in ns '${ns}'. Attach policies/routes as needed."
}

show_status() {
  echo "[INFO] Istio core:"
  kubectl -n "${ISTIO_NAMESPACE}" get pods -o wide || true
  echo "[INFO] DaemonSets:"
  kubectl -n "${ISTIO_NAMESPACE}" get ds -o wide || true
  echo "[INFO] Deployments:"
  kubectl -n "${ISTIO_NAMESPACE}" get deploy -o wide || true
  echo "[INFO] GatewayClasses:"
  kubectl get gatewayclasses.gateway.networking.k8s.io || true
  echo "[INFO] Recent events (istio-system):"
  kubectl -n "${ISTIO_NAMESPACE}" get events --sort-by=.metadata.creationTimestamp | tail -n 50 || true
}

uninstall_istio() {
  echo "[INFO] Uninstalling Istio (ambient)"
  if [[ "${1:-}" == "--revision" && -n "${2:-}" ]]; then
    "${ISTIOCTL_BIN}" uninstall --revision "$2" -y || true
    return
  fi
  if [[ "${1:-}" == "--set" && "${2:-}" =~ ^revision=.+$ ]]; then
    "${ISTIOCTL_BIN}" uninstall "$1" "$2" -y || true
    return
  fi
  if [[ "${1:-}" == "--filename" && -n "${2:-}" ]]; then
    "${ISTIOCTL_BIN}" uninstall --filename "$2" -y || true
    return
  fi
  if [[ "${1:-}" == "--purge" ]]; then
    "${ISTIOCTL_BIN}" uninstall --purge -y || true
    return
  fi
  # 기본: 전체 purge (모든 리비전 제거)
  "${ISTIOCTL_BIN}" uninstall --purge -y || true
}

# ---------------- Main ----------------
cmd="${1:-}"
case "${cmd}" in
  install)
    need_cmd kubectl
    need_cmd curl
    find_kubeconfig
    download_istio
    install_gateway_api
    ensure_ns "${ISTIO_NAMESPACE}"
    label_ns_privileged_for_cis "${ISTIO_NAMESPACE}"
    install_istio_ambient
    verify_istio_simple
    patch_cilium_for_ambient
    rollout_restart_core
    echo "[DONE] Istio Ambient ${ISTIO_VERSION} installed for CIS environment."
    ;;
  verify)
    need_cmd kubectl
    find_kubeconfig
    download_istio
    verify_istio_simple
    ;;
  enable-ns)
    need_cmd kubectl
    find_kubeconfig
    ns="${2:-}"
    [[ -z "${ns}" ]] && { echo "Namespace required"; usage; exit 1; }
    enable_namespace_ambient "${ns}"
    ;;
  waypoint)
    need_cmd kubectl
    find_kubeconfig
    ns="${2:-}"; name="${3:-}"
    [[ -z "${ns}" || -z "${name}" ]] && { echo "Namespace and name required"; usage; exit 1; }
    create_minimal_waypoint "${ns}" "${name}"
    ;;
  status)
    need_cmd kubectl
    find_kubeconfig
    show_status
    ;;
  uninstall)
    need_cmd kubectl
    find_kubeconfig
    download_istio
    shift || true
    uninstall_istio "$@"
    ;;
  *)
    usage
    exit 1
    ;;
esac
