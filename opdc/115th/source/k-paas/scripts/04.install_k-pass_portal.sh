#!/usr/bin/env bash
set -e

# https://github.com/K-PaaS/container-platform/blob/master/install-guide/container-platform-portal/cp-portal-deployment-standalone-guide.md

export INSTALL_PATH=/home/vagrant

# Deployment 파일 다운로드 경로 생성
mkdir -p ${INSTALL_PATH}/workspace/container-platform
cd ${INSTALL_PATH}/workspace/container-platform

# Deployment 파일 다운로드 및 파일 경로 확인
wget --content-disposition https://nextcloud.k-paas.org/index.php/s/WtNQn2agk6epFHC/download

# Deployment 파일 압축 해제(2023.11.13)
tar -xvf cp-portal-deployment-v1.4.0.tar.gz

# 오류 수정
sed -i 's/paasta-cp-storageclass/cp-storageclass/g'                ${INSTALL_PATH}/workspace/container-platform/cp-portal-deployment/script/cp-portal-vars.sh

# 컨테이너 플랫폼 포털 변수 정의
sed -i 's/{k8s master node public ip}/192.168.100.100/g'           ${INSTALL_PATH}/workspace/container-platform/cp-portal-deployment/script/cp-portal-vars.sh
sed -i 's/{host cluster iaas type}/OPENSTACK/g'                    ${INSTALL_PATH}/workspace/container-platform/cp-portal-deployment/script/cp-portal-vars.sh
sed -i 's/{container platform portal provider type}/standalone/g'  ${INSTALL_PATH}/workspace/container-platform/cp-portal-deployment/script/cp-portal-vars.sh
sed -i 's/IMAGE_PULL_POLICY=\"Always\"/IMAGE_PULL_POLICY=\"IfNotPresent\"/g'  ${INSTALL_PATH}/workspace/container-platform/cp-portal-deployment/script/cp-portal-vars.sh

# cp: cannot stat '/home/ubuntu/.env//cp-vault-vars.sh': No such file or directory
sed -i 's/$VAULT_VARS_PATH\/$VAULT_VARS/\/home\/vagrant\/.env\/cp-vault-vars.sh/g'  ${INSTALL_PATH}/workspace/container-platform/cp-portal-deployment/script/deploy-cp-portal.sh

# error: cannot update repo 'ubi-8-baseos-rpms'
sed -i'' -r -e "/RUN microdnf update/i\RUN sed -i 's/gpgcheck = 1\/gpgcheck=1\\\\nsslverify=0\/g' \/etc\/yum.repos.d\/ubi.repo"  ${INSTALL_PATH}/workspace/container-platform/cp-portal-deployment/keycloak_orig/Dockerfile
sed -i'' -r -e "/RUN chmod 775/a\RUN sed -i 's\/curl\/curl --insecure\/g' \/opt\/jboss\/tools\/build-keycloak.sh"                ${INSTALL_PATH}/workspace/container-platform/cp-portal-deployment/keycloak_orig/Dockerfile

#  컨테이너 플랫폼 포털 배포 스크립트 실행
cd ${INSTALL_PATH}/workspace/container-platform/cp-portal-deployment/script
chmod +x deploy-cp-portal.sh
./deploy-cp-portal.sh
