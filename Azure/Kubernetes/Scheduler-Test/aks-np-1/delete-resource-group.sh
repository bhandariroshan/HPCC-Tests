#!/bin/bash

WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration
# Set subscription
az account set --subscription $SUBSCRIPTION

# Create Resource Group
rc=$(az group exists --name ${RESOURCE_GROUP})
if [ "$rc" = "true" ]
then
    echo "Delete Resource group ${RESOURCE_GROUP}."
    time az group delete --name ${RESOURCE_GROUP} --yes
fi 
