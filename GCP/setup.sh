#!/bin/bash

CUR_DIR=$(pwd)
WORK_DIR=$(dirname $0)
#WORK_DIR=$(cd $WORK_DIR; pwd); cd $CUR_DIR

.  ${WORK_DIR}/env


#gcloud auth login
#gcloud components install beta

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
 --member user:${GCP_EMAIL_ADDRESS} \
 --role roles/editor
 #--role roles/computer.admin \
 #--role roles/container.admin \
 #--role=roles/gkehub.admin \
 #--role=roles/iam.serviceAccountAdmin \
 #--role=roles/iam.serviceAccountKeyAdmin \
 #--role=roles/resourcemanager.projectIamAdmin

gcloud services enable \
 --project=${PROJECT_ID} \
 file.googleapis.com 
 #container.googleapis.com \
 #compute.googleapis.com \
 #monitoring.googleapis.com \
 #logging.googleapis.com \
 #cloudtrace.googleapis.com \
 #gkeconnect.googleapis.com \
 #gkehub.googleapis.com \
 #cloudresourcemanager.googleapis.com \
 #anthos.googleapis.com \
 #meshca.googleapis.com \
 #meshtelemetry.googleapis.com \
 #meshconfig.googleapis.com \
 #iap.googleapis.com  \


#gcloud projects add-iam-policy-binding ${PROJECT_ID} \
# --member user:${GCP_EMAIL_ADDRESS} \
# --role=roles/file.serviceAgent

 #--role roles/gkehub.viewer \
 #--role=roles/compute.viewer \
 #--role=roles/container.viewer \
 #--role=roles/monitoring.editor \

gcloud iam service-accounts create ${SERVICE_ACCOUNT_NAME} --project=${PROJECT_ID}
gcloud iam service-accounts list --project=${PROJECT_ID}

#gcloud projects add-iam-policy-binding ${PROJECT_ID} \
# --member="serviceAccount:${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com" \
# --role="roles/gkehub.connect"

gcloud iam service-accounts keys create ${LOCAL_KEY_PATH} \
  --iam-account=${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com \
  --project=${PROJECT_ID}

