#!/usr/bin/env bash
set -e

# https://github.com/K-PaaS/container-platform/blob/master/install-guide/standalone/cp-cluster-install.md

cd

# v1.4.2(2023.11.13)
git clone https://github.com/K-PaaS/cp-deployment.git -b branch_v1.4.x

export INSTALL_PATH=/home/vagrant

cp /vagrant/scripts/k-pass_cp-cluster-vars.sh ${INSTALL_PATH}/cp-deployment/standalone/single_control_plane/cp-cluster-vars.sh

set +e

# modprobe: FATAL: Module nf_conntrack_ipv4 not found in directory
sed -i 's/nf_conntrack_ipv4/nf_conntrack/g' ${INSTALL_PATH}/cp-deployment/standalone/single_control_plane/roles/kubernetes/node/tasks/main.yml
sed -i 's/nf_conntrack_ipv4/nf_conntrack/g' ${INSTALL_PATH}/cp-deployment/standalone/single_control_plane/extra_playbooks/roles/kubernetes/node/tasks/main.yml

# error: one or more CSRs must be specified as <name> or -f <filename>
cat << EOF | tee -a ${INSTALL_PATH}/cp-deployment/standalone/single_control_plane/roles/cp/csr/tasks/main.yml
  ignore_errors: yes
EOF

# fatal: TASK [cp/vault : check vault-0 status]
sed -i 's/retries: 20/retries: 10000/g' ${INSTALL_PATH}/cp-deployment/standalone/single_control_plane/roles/cp/vault/tasks/main.yml

# vault
sed -i 's/\[/\[\"127.0.0.1\/32\", \"10.0.2.15\/32\", /g' ${INSTALL_PATH}/cp-deployment/standalone/applications/vault-1.11.3/payload.json.ori

# vault delete unseal_key file
sed -in '49s/- name/#- name/g'        ${INSTALL_PATH}/cp-deployment/standalone/single_control_plane/roles/cp/vault/tasks/main.yml
sed -in '50s/  file/#  file/g'        ${INSTALL_PATH}/cp-deployment/standalone/single_control_plane/roles/cp/vault/tasks/main.yml
sed -in '51s/    path/#    path/g'    ${INSTALL_PATH}/cp-deployment/standalone/single_control_plane/roles/cp/vault/tasks/main.yml
sed -in '52s/    state/#    state/g'  ${INSTALL_PATH}/cp-deployment/standalone/single_control_plane/roles/cp/vault/tasks/main.yml

cd ${INSTALL_PATH}/cp-deployment/standalone/single_control_plane
sleep 2

source deploy-cp-cluster.sh
