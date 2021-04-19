#!/bin/bash
CUR_DIR=$(pwd)
WORK_DIR=$(dirname $0)
#WORK_DIR=$(cd $WORK_DIR; pwd); cd $CUR_DIR

#ZONE="us-east1-b"
#GKE_NAME="gke-${ZONE}-ming"
#GKE_VERSION=1.19

source ${WORK_DIR}/configuration

gcloud container clusters create $GKE_NAME \
	--zone  $GKE_ZONE \
        --cluster-version $GKE_VERSION \
	--enable-ip-alias \
	--node-locations $GKE_ZONE


#`--cluster-ipv4-cidr
# 
#https://cloud.google.com/kubernetes-engine/docs/how-to/alias-ips

