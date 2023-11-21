#!/usr/bin/env bash
set -e

sudo apt-get install -y sshpass

# xdotool key 'Overwrite' | ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa <<< n
ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa <<< n

# public key registration
# shellcheck disable=SC2129
ssh-keyscan -t ecdsa master >> ~/.ssh/known_hosts
ssh-keyscan -t ecdsa worker01 >> ~/.ssh/known_hosts
ssh-keyscan -t ecdsa worker02 >> ~/.ssh/known_hosts
ssh-keyscan -t ecdsa worker03 >> ~/.ssh/known_hosts

# ssh key copy
sshpass -pvagrant ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@master
sshpass -pvagrant ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@worker01
sshpass -pvagrant ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@worker02
sshpass -pvagrant ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@worker03
