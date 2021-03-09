#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration

# Create a Kubernetes Cluster
#az aks create  $(eval echo {AKS_CREATE_OPTIONS}) 
echo "az aks create  $(eval echo ${AKS_CREATE_OPTIONS}) "
az aks create  $(eval echo ${AKS_CREATE_OPTIONS})

# Register Kubernetes cluster to local configure file
az aks get-credentials \
   --resource-group ${RESOURCE_GROUP} \
   --name ${AKS_NAME} \
   --admin \
   --overwrite-existing

# Create Storage Account
#$rc = $(az storage account check-name --name ${storage_account} | select-string  "nameAvailable" | select-string "true")
#if ( ${rc} -ne $null)
#{
#   az storage account create `
#      --name $storage_account `
#      --resource_group $resource_group `
#      --location $location `
#      --sku $sku_name
#}
