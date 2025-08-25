#!/usr/bin/env bash

# ----------------------------------------
# 1. Swap 비활성화
# ----------------------------------------
sudo swapoff -a  # 즉시 스왑 비활성화
sudo sed -i '/swap/d' /etc/fstab  # 부팅 시 스왑 자동 활성화 방지

# ----------------------------------------
# 2. 방화벽 & SELinux 비활성화 (조건부 처리)
# ----------------------------------------
# firewalld가 설치된 경우에만 실행
if systemctl list-unit-files | grep -q firewalld.service; then
    sudo systemctl stop firewalld && sudo systemctl disable firewalld
fi

# SELinux 설정 파일이 존재하는 경우에만 처리
if [ -f /etc/selinux/config ]; then
    sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
    sudo setenforce 0 || true  # 명령어 없을 경우 무시
fi

# ----------------------------------------
# 3. AppArmor 비활성화 (조건부 처리)
# ----------------------------------------
# AppArmor가 설치된 경우에만 실행
if systemctl list-unit-files | grep -q apparmor.service; then
    sudo systemctl disable apparmor --now || true
fi

# ----------------------------------------
# 4. NetworkManager 비활성화 (필요시)
# ----------------------------------------
# NetworkManager가 사용 중인지 확인
if systemctl is-active NetworkManager &>/dev/null; then
    sudo systemctl disable NetworkManager --now
fi
# ----------------------------------------
# 5. 커널 모듈 로드
# ----------------------------------------
sudo modprobe br_netfilter || true
sudo modprobe overlay || true

# 영구적 모듈 로드 설정
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf >/dev/null
br_netfilter
overlay
EOF

# ----------------------------------------
# 6. sysctl 설정
# ----------------------------------------
cat << EOF | sudo tee /etc/sysctl.conf >/dev/null
net.ipv4.ip_forward=1
net.ipv4.conf.all.send_redirects=0
net.ipv4.conf.default.send_redirects=0
net.ipv4.conf.default.accept_source_route=0
net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.default.accept_redirects=0
net.ipv4.conf.all.log_martians=1
net.ipv4.conf.default.log_martians=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.default.rp_filter=1
net.ipv6.conf.all.accept_ra=0
net.ipv6.conf.default.accept_ra=0
net.ipv6.conf.all.accept_redirects=0
net.ipv6.conf.default.accept_redirects=0
kernel.keys.root_maxbytes=25000000
kernel.keys.root_maxkeys=1000000
kernel.panic=10
kernel.panic_on_oops=1
vm.overcommit_memory=1
vm.panic_on_oom=0
net.ipv4.ip_local_reserved_ports=30000-32767
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-arptables=1
net.bridge.bridge-nf-call-ip6tables=1
EOF

sudo sysctl --system

# ----------------------------------------
# 7. RKE2 CIS 설정 파일 복사 (조건부 처리)
# ----------------------------------------
RKE2_CONF_SRC="/usr/local/share/rke2/rke2-cis-sysctl.conf"
if [ -f "$RKE2_CONF_SRC" ]; then
    sudo cp -f "$RKE2_CONF_SRC" /etc/sysctl.d/60-rke2-cis.conf
    sudo sysctl -p "$RKE2_CONF_SRC"
else
    echo "[INFO] $RKE2_CONF_SRC 파일이 없어 생략됨" >&2
fi

# ----------------------------------------
# 8. etcd 사용자 설정 (마스터 노드 전용)
# ----------------------------------------
if [[ $(hostname) == *master* ]]; then
    if ! id etcd &>/dev/null; then
        sudo useradd -r -c "etcd user" -s /sbin/nologin -M etcd -U
    fi
    sudo mkdir -p /var/lib/rancher/rke2/server/db/etcd
    sudo chown etcd:etcd /var/lib/rancher/rke2/server/db/etcd
fi

# ----------------------------------------
# 9. IPVS 모듈 로드
# ----------------------------------------
IPVS_MODULES=("ip_vs" "ip_vs_rr" "ip_vs_wrr" "ip_vs_sh" "nf_conntrack")
for mod in "${IPVS_MODULES[@]}"; do
    sudo modprobe -q "$mod" || true
done

# 영구적 모듈 로드 설정
cat <<EOF | sudo tee /etc/modules-load.d/ipvs.conf >/dev/null
ip_vs
ip_vs_rr
ip_vs_wrr
ip_vs_sh
nf_conntrack
EOF

# ----------------------------------------
# 10. nm-cloud-setup 서비스 비활성화
# ----------------------------------------
sudo systemctl mask nm-cloud-setup.service
sudo systemctl mask nm-cloud-setup.timer
sudo mkdir -p /etc/systemd/system/nm-cloud-setup.service.d/
echo -e '[Install]\nEnabled=false' | sudo tee /etc/systemd/system/nm-cloud-setup.service.d/override.conf
sudo systemctl daemon-reload

# ----------------------------------------
# 11. 최종 검증
# ----------------------------------------
echo "******** 최종 검증 ********"
sudo sysctl vm.panic_on_oom vm.overcommit_memory kernel.panic kernel.panic_on_oops
lsmod | grep -E 'ip_vs|nf_conntrack'

# 재부팅 후 확인
#sudo reboot
#lsmod | grep ip_vs  # 재부팅 후 모듈 확인