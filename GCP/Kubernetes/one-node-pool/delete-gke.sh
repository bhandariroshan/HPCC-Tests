#!/bin/bash

CUR_DIR=$(pwd)
WORK_DIR=$(dirname $0)
#WORK_DIR=$(cd $WORK_DIR; pwd); cd $CUR_DIR

source ${WORK_DIR}/configuration
#cd ${WORK_DIR}

#ZONE="us-east1-b"
#GKE_NAME="gke-${ZONE}-ming"
gcloud container clusters delete -q $GKE_NAME --zone $GKE_ZONE

