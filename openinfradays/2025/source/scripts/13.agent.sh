#!/usr/bin/env bash

# Global Variable Setting
source /vagrant/scripts/00.global_variable.sh

# Air gap install
mkdir -p ~/rke2-artifacts && cd ~/rke2-artifacts

# 2. RKE2 바이너리 및 이미지 파일 다운로드
curl -OLs https://github.com/rancher/rke2/releases/download/v1.32.7%2Brke2r1/rke2-images.linux-arm64.tar.zst
curl -OLs https://github.com/rancher/rke2/releases/download/v1.32.7%2Brke2r1/rke2.linux-arm64.tar.gz
curl -OLs https://github.com/rancher/rke2/releases/download/v1.32.7%2Brke2r1/sha256sum-arm64.txt
curl -sfL https://get.rke2.io --output install.sh

# config.yaml 생성
sudo mkdir -p /etc/rancher/rke2/

RKE2_NODE_TOKEN=$(cat /vagrant/node-token)

cat << EOF | sudo tee /etc/rancher/rke2/config.yaml
node-ip: "$NODE_IP"
bind-address: "$NODE_IP"
advertise-address: "$NODE_IP"
node-label:
  - "role=worker"
  - "env=production"
debug: true
token: $RKE2_NODE_TOKEN
server: https://$MASTER01:9345
kubelet-arg:
  - "--node-status-update-frequency=4s"
  - "--max-pods=100"
EOF

# install
INSTALL_RKE2_TYPE="agent" \
INSTALL_RKE2_ARTIFACT_PATH=~/rke2-artifacts \
sudo sh -x ~/rke2-artifacts/install.sh

# 서비스 등록
sudo systemctl enable rke2-agent.service --now
