#!/bin/bash

######################################################################
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
# SPDX-License-Identifier: MIT-0                                     #
######################################################################

aws ec2 describe-vpcs --query "Vpcs[*].{Name:Tags[?Key=='Name']|[0].Value,CidrBlock:CidrBlock,VpcId:VpcId}" --output table

