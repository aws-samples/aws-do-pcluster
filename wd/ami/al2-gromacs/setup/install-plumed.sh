#!/bin/bash

#######################################################################
## Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
## SPDX-License-Identifier: MIT-0                                     #
#######################################################################

# Reference: https://github.com/plumed/plumed2

echo ""
echo "Installing plumed ..."
echo ""

git clone https://github.com/plumed/plumed2.git

cd plumed2

git checkout v2.7.5

./configure --prefix=/usr/local
make -j 4
make install

echo "export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH" >> /etc/bashrc

source /etc/bashrc

