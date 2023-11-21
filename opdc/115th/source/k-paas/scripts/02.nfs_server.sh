#!/usr/bin/env bash
set -e

# https://github.com/K-PaaS/container-platform/blob/master/install-guide/nfs-server-install-guide.md

# NFS Server Install
sudo apt-get install -y nfs-common nfs-kernel-server portmap
sudo mkdir -p /home/share/nfs
sudo chmod -R 777 /home/share/nfs

## 변경되는 IP 대역대로 재설정 필요
# ip 주소 확인
sudo cat <<EOF | sudo tee /etc/exports
## 형식 : [/공유디렉토리] [접근IP] [옵션]
## 예시 : /home/share/nfs 10.0.0.1(rw,no_root_squash,async)
/home/share/nfs 192.168.100.100(rw,no_root_squash,async)
/home/share/nfs 192.168.100.101(rw,no_root_squash,async)
/home/share/nfs 192.168.100.102(rw,no_root_squash,async)
/home/share/nfs 192.168.100.103(rw,no_root_squash,async)
EOF

# restart
sudo /etc/init.d/nfs-kernel-server restart
sudo systemctl restart portmap
