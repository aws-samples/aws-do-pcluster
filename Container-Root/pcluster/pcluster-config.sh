#!/bin/bash

######################################################################
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
# SPDX-License-Identifier: MIT-0                                     #
######################################################################

function usage(){
	echo ""
	echo "Usage: $0 [CLUSTER_CONFIG] [-i | --interactive]"
	echo "Example - Generage pcluster config using wizard - $0 pcluster.yaml -i"
	echo "Example - Open pcluster config in editor - $0 pcluster.yaml"
	echo ""
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	usage
else
	CLUSTER_CONFIG=pcluster.yaml
	if [ ! "$1" == "" ]; then
		CLUSTER_CONFIG=$1
	fi

	if [[ "$2" == "-i" || "$2" == "--interactive" ]]; then
		pcluster configure --config /wd/config/$CLUSTER_CONFIG
	else
		vi /wd/config/$CLUSTER_CONFIG
	fi
fi

