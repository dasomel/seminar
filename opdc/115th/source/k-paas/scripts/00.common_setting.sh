#!/usr/bin/env bash
set -e

# ubuntu ssh
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g'  /etc/ssh/sshd_config
sudo sed -i 's/archive.ubuntu.com/mirror.kakao.com/g'  /etc/apt/sources.list
sudo sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
sudo systemctl restart ssh

# Hash Sum mismatch
sudo rm -rf /var/lib/apt/lists/*

sudo apt-get update
sudo apt-get upgrade -y

# hosts setting
sudo cat << EOF | sudo tee -a /etc/hosts
192.168.100.100 master
192.168.100.101 worker01
192.168.100.102 worker02
192.168.100.103 worker03
192.168.100.200 ansible-server
EOF
