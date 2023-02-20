#!/bin/bash

######################################################################
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
# SPDX-License-Identifier: MIT-0                                     #
######################################################################

function usage(){
	echo ""
	echo "Usage: $0 [CLUSTER_NAME]"
	echo ""
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	usage
else

	CLUSTER_NAME=pcluster
	if [ ! "$1" == "" ]; then
		CLUSTER_NAME=$1
	fi

	pcluster describe-cluster --cluster-name $CLUSTER_NAME
fi
