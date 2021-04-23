#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration
[[ -n "$1" ]] && source $1

# Set subscription
az account set --subscription $SUBSCRIPTION
account_key=$(cat ${KEY_DIR}/${SHARE_NAME}.key | cut -d':' -f2 | sed 's/[[:space:]]\+//g')
az storage share list --account-name ${STORAGE_ACCOUNT_NAME} --account-key $account_key
