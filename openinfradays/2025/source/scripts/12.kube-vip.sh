#!/usr/bin/env bash

# Global Variable Setting
source /vagrant/scripts/00.global_variable.sh

CTR_BIN="/var/lib/rancher/rke2/bin/ctr"
CONTAINERD_SOCKET="/run/k3s/containerd/containerd.sock"

# image pull
"$CTR_BIN" -n k8s.io image pull ghcr.io/kube-vip/kube-vip:v1.0.0

sudo cp /scripts/file/kube-vip/kube-vip-rbac.yaml /var/lib/rancher/rke2/server/manifests/kube-vip-rbac.yaml

sudo "$CTR_BIN" --address "$CONTAINERD_SOCKET" -n k8s.io run \
--rm \
--net-host \
ghcr.io/kube-vip/kube-vip:v1.0.0 vip /kube-vip manifest daemonset \
--interface "$VM_INTERFACE_NAME" \
--address "$CLUSTER_ENDPOINT" \
--inCluster \
--taint \
--controlplane \
--services \
--arp \
--leaderElection \
--k8sConfigPath /etc/rancher/rke2/rke2.yaml | sudo tee /var/lib/rancher/rke2/server/manifests/kube-vip.yaml
