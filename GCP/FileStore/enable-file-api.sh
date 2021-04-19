#!/bin/bash
CUR_DIR=$(pwd)
WORK_DIR=$(dirname $0)
#WORK_DIR=$(cd $WORK_DIR; pwd); cd $CUR_DIR


source ${WORK_DIR}/configuration
cd ${WORK_DIR}

gcloud projects add-iam-policy-binding ${GCP_PROJECT} --member serviceAccount:service-${GCP_PROJECT_NUMBER}@cloud-filer.iam.gserviceaccount.com --role roles/file.serviceAgent

echo ""
gcloud projects get-iam-policy ${GCP_PROJECT} \
  --flatten="bindings[].members" \
  --format='table(bindings.role)' \
  --filter="bindings.members:service-${GCP_PROJECT_NUMBER}@cloud-filer.iam.gserviceaccount.com"
