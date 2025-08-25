#!/usr/bin/env bash
# shellcheck disable=SC2034
# Ubuntu
export DEBIAN_FRONTEND=noninteractive

# Vagrant
export INSTALL_PATH=/home/vagrant

# VirtualBox
export VM_INTERFACE_NAME=eth1

# Node
export NODE_IP=$(hostname -I | awk '{print $2}')

export MASTER01=192.168.33.11
export MASTER02=192.168.33.12
export MASTER03=192.168.33.13
export WORKER01=192.168.33.21
export WORKER02=192.168.33.22
export WORKER03=192.168.33.23
export CLUSTER_ENDPOINT=192.168.33.100
