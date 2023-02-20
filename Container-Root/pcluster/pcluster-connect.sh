#!/bin/bash

######################################################################
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
# SPDX-License-Identifier: MIT-0                                     #
######################################################################

function usage(){
	echo ""
	echo "Usage: $0 [CLUSTER_NAME] [KEYFILE_PATH]"
	echo ""
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	usage
else
	CLUSTER_NAME=pcluster
	if [ ! "$1" == "" ]; then
		CLUSTER_NAME=$1
	fi

	KEYFILE_PATH=/wd/ssh/pcluster.pem
	if [ ! "$2" == "" ]; then
		KEYFILE_PATH=$2
	fi

	pcluster ssh --cluster-name $CLUSTER_NAME -i $KEYFILE_PATH
fi
 
