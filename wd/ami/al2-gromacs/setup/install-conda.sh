#!/bin/bash

#######################################################################
## Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
## SPDX-License-Identifier: MIT-0                                     #
#######################################################################

# Install conda
# Reference: https://docs.anaconda.com/anaconda/install/linux/

echo ""
echo "Installing conda ..."
echo ""

curl -o anaconda3.sh -L https://repo.anaconda.com/archive/Anaconda3-4.4.0-Linux-x86_64.sh

chmod +x anaconda3.sh 

./anaconda3.sh -b -p /home/ec2-user/anaconda3 

echo "export PATH=/home/ec2-user/anaconda3/bin:$PATH" >> /home/ec2-user/.bashrc

source /home/ec2-user/.bashrc

