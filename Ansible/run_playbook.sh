#!/bin/bash

if grep -q Microsoft /proc/version; then
  folder=/mnt/c/Users/$USER
else
  folder=$HOME
fi

export VAULT_ADDR="https://vault.example.com"
export ANSIBLE_HOST_KEY_CHECKING=False
url=$VAULT_ADDR/v1/auth/token/lookup

token=$(cat "$folder/.vault-token")
header="X-Vault-Token:$token"

export VAULT_TOKEN=$(cat "$folder/.vault-token")
cp -r $folder/.ssh ~
chmod 700 ~/.ssh/privateKey
eval `ssh-agent -s`
ssh-add ~/.ssh/privateKey

if [[ $# -eq 1 ]]; then # YAML File
    ansible-playbook -u admin -i inventory.ini $1
elif [[ $# -eq 2 ]]; then # Inventory Group
    ansible-playbook -u admin -i inventory.ini $1 -l $2
fi