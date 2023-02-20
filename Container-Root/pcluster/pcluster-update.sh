#!/bin/bash

######################################################################
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
# SPDX-License-Identifier: MIT-0                                     #
######################################################################

function usage(){
	echo ""
	echo "Usage: $0 [CLUSTER_NAME] [CLUSTER_CONFIG]"
	echo ""
}

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
	usage
else

	CLUSTER_NAME=pcluster
	if [ ! "$1" == "" ]; then
		CLUSTER_NAME=$1
	fi

	CLUSTER_CONFIG=pcluster.yaml
	if [ ! "$2" == "" ]; then
		CLUSTER_CONFIG=$2
	fi

	pushd /wd/config

	pcluster update-cluster --cluster-name $CLUSTER_NAME --cluster-configuration $CLUSTER_CONFIG

	popd
fi
