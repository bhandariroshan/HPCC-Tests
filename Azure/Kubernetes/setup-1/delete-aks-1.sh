#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration

# Set subscription
az account set --subscription $subscription

# Create Resource Group
rc=$(az group exists --name $resource_group)
if [ "$rc" = "true" ]
then
    echo "Delete Resource group $resource_group."
    az group delete --name $resource_group --yes
fi 
