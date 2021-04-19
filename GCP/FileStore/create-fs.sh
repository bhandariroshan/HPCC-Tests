#!/bin/bash
CUR_DIR=$(pwd)
WORK_DIR=$(dirname $0)
#WORK_DIR=$(cd $WORK_DIR; pwd); cd $CUR_DIR


source ${WORK_DIR}/configuration
#cd ${WORK_DIR}
gcloud filestore instances create -q $FS_INSTANCE_ID \
    --project=${GCP_PROJECT} \
    --zone=${FS_ZONE} \
    --tier=${FS_TIER} \
    --network=name=${FS_NETWORK} \
    --file-share=name="hpccdata",capacity=1TB

#    --flags-file=${WORK_DIR}/nfs-export-options.json

gcloud filestore instances describe $FS_INSTANCE_ID \
    --project=${GCP_PROJECT} \
    --zone=${FS_ZONE} 
