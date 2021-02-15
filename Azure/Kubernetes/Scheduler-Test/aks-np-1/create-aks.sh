#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration

# Create a Kubernetes Cluster
az aks create  ${GEN_SSK_KEYS} \
   --resource-group ${RESOURCE_GROUP} \
   --name ${AKS_NAME} \
   --node-vm-size ${DEFAULT_NODE_VM_SIZE} \
   --node-count  ${DEFAULT_NODE_COUNT} \
   --min-count ${DEFAULT_MIN_COUNT} \
   --max-count ${DEFAULT_MAX_COUNT} \
   ${DEFAULT_AUTOSCALER} \
   --enable-managed-identity \
   --kubernetes-version ${KUBERNETES_VERSION} \
   --zones $ZONES \
   --nodepool-labels $(echo ${DEFAULT_NP_LABELS}) \
   --nodepool-name ${DEFAULT_NP_NAME} \
   --tags $(eval echo ${TAGS} )

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
