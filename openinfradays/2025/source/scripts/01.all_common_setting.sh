#!/usr/bin/env bash
set -e

# Global Variable Setting
source /vagrant/scripts/00.global_variable.sh

# timezone change
sudo timedatectl set-timezone Asia/Seoul

# ubuntu 22.04 ssh setting
sudo sed -i 's/#Port 22/Port 22/'                                       /etc/ssh/sshd_config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g'  /etc/ssh/sshd_config
sudo systemctl restart ssh

# hosts setting
sudo cat << EOF | sudo tee -a /etc/hosts
$CLUSTER_ENDPOINT cluster-endpoint
$MASTER01 master01
$MASTER02 master02
$MASTER03 master03
$WORKER01 worker01
$WORKER02 worker02
$WORKER03 worker03
EOF
