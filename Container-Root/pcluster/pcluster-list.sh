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
	if [ "$1" == "" ]; then
		pcluster list-clusters
	else
		pcluster list-clusters --query "clusters[?clusterName==`$1`]"
	fi
fi
