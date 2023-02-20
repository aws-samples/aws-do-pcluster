#!/bin/bash

######################################################################
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
# SPDX-License-Identifier: MIT-0                                     #
######################################################################

function usage(){
	echo ""
	echo "Usage: $0 <VPC_ID>
	echo ""
}

if [ "$1" == "" ]; then
	usage
else
	VPC_ID=$1
	aws ec2 delete-vpc --vpc-id $VPC_ID
fi

