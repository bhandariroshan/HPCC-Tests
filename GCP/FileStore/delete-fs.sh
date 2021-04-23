#!/bin/bash
CUR_DIR=$(pwd)
WORK_DIR=$(dirname $0)
#WORK_DIR=$(cd $WORK_DIR; pwd); cd $CUR_DIR


source ${WORK_DIR}/configuration
cd ${WORK_DIR}
gcloud beta filestore instances delete -q $FS_INSTANCE_ID \
    --project=${GCP_PROJECT} \
    --zone=${FS_ZONE} 
