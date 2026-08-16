#!/usr/bin/env bash

set -e

apt-get update && apt-get upgrade -y

apt-get install -y \
sudo \
curl \
wget \
git \
unzip \
ca-certificates \
openssh-server

passwd root

tee /etc/ssh/sshd_config.d/root.conf > /dev/null <<'EOF'
PermitRootLogin yes
PasswordAuthentication yes
PubkeyAuthentication no
EOF

systemctl restart ssh

useradd -m -s /bin/bash master

echo "master ALL=(root) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/master-nopasswd
