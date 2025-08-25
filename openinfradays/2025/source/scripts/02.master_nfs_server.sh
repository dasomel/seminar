#!/usr/bin/env bash
set -e

# Global Variable Setting
source /vagrant/scripts/00.global_variable.sh

# NFS Server Install
sudo apt-get install -y nfs-common nfs-kernel-server portmap
sudo mkdir -p /home/share/nfs
sudo chmod -R 777 /home/share/nfs

sudo cat <<EOF | sudo tee /etc/exports
## 형식 : [/공유디렉토리] [접근IP] [옵션]
## 예시 : /home/share/nfs 10.0.0.1(rw,no_root_squash,async)
/home/share/nfs master01(rw,no_root_squash,async)
/home/share/nfs master02(rw,no_root_squash,async)
/home/share/nfs master03(rw,no_root_squash,async)
/home/share/nfs worker01(rw,no_root_squash,async)
/home/share/nfs worker02(rw,no_root_squash,async)
/home/share/nfs worker03(rw,no_root_squash,async)
EOF

# NFS Server install
if [ $(hostname) == master01 ]; then
sudo /etc/init.d/nfs-kernel-server restart
sudo systemctl restart portmap
fi