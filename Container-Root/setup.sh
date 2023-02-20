#!/bin/sh

######################################################################
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
# SPDX-License-Identifier: MIT-0                                     #
######################################################################

if [ -d /etc/apt ]; then
        [ -n "$http_proxy" ] && echo "Acquire::http::proxy \"${http_proxy}\";" > /etc/apt/apt.conf; \
        [ -n "$https_proxy" ] && echo "Acquire::https::proxy \"${https_proxy}\";" >> /etc/apt/apt.conf; \
        [ -f /etc/apt/apt.conf ] && cat /etc/apt/apt.conf
fi

# Install basic tools
echo ""
echo "Installing basic tools ..."
apt-get update
apt-get install -y vim nano jq less gettext-base

# Install node (required by pcluster v3 and cdk)
curl -s https://nodejs.org/dist/v16.19.0/node-v16.19.0-linux-x64.tar.xz --output node-v16.19.0-linux-x64.tar.xz
mkdir -p /usr/local/lib/nodejs
tar -xJvf node-v16.19.0-linux-x64.tar.xz -C /usr/local/lib/nodejs
ln -s /usr/local/lib/nodejs/node-v16.19.0-linux-x64/bin/node /usr/local/bin/node
rm -f ./node-v16.19.0-linux-x64.tar.xz

# Install AWS CLI v2
echo ""
echo "Installing AWS CLI version 2"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf aws awscliv2.zip

# Install Packer
echo ""
echo "Installing Packer ..."
PACKER_VERSION="1.7.10"
PACKER_VERSION_SHA256SUM="1c8c176dd30f3b9ec3b418f8cb37822261ccebdaf0b01d9b8abf60213d1205cb"
curl -O https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
echo "${PACKER_VERSION_SHA256SUM}  packer_${PACKER_VERSION}_linux_amd64.zip" > checksum && sha256sum -c checksum
unzip packer_${PACKER_VERSION}_linux_amd64.zip
ln -s $PWD/packer /usr/sbin/packer
rm -f packer_${PACKER_VERSION}_linux_amd64.zip

# Install Session Manager Plugin
echo "Installing Session Manager Plugin ..."
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
dpkg -i session-manager-plugin.deb
rm -f ./session-manager-plugin.deb

# Install yq
YQ_VERSION=4.21.1
wget https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64 -O /usr/bin/yq
chmod +x /usr/bin/yq

# Install ParallelCluster
PCLUSTER_VERSION=3.4.1
python -m pip install aws-parallelcluster==$PCLUSTER_VERSION

# Configure .bashrc
echo "alias ll='ls -alh --color=auto'" >> /root/.bashrc

