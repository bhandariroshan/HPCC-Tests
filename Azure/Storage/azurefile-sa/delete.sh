#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration
[[ -n "$1" ]] && source $1

# Set subscription
az account set --subscription $SUBSCRIPTION

# Check Resource Group
rc=$(az group exists --name ${SA_RESOURCE_GROUP})
if [ "$rc" = "true" ]
then
  echo "Delete Resource group ${SA_RESOURCE_GROUP}."
  time az group delete --name ${SA_RESOURCE_GROUP} --yes
fi

