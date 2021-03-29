#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration
[[ -n "$1" ]] && source $1

# Set subscription
az account set --subscription $SUBSCRIPTION

# Create ssh keys
if [ ! -e ~/.ssh/id_rsa ] || [ ! -e ~/.ssh/id_rsa.pub ]  
then
     GEN_SSK_KEYS="--generate-ssh-keys"
fi

# Create Resource Group
rc=$(az group exists --name $RESOURCE_GROUP)
if [ "$rc" = "true" ]
then
    echo "Resource group $RESOURCE_GROUP already exists."
    exit 1
fi
az group create --name $RESOURCE_GROUP --location $LOCATION --tags $(eval echo ${TAGS})

# Create a Kubernetes Cluster
az aks create  ${GEN_SSK_KEYS} \
   --resource-group $RESOURCE_GROUP --name $AKS_NAME \
   --node-vm-size ${NODE_VM_SIZE} \
   --node-count ${NODE_COUNT} \
   --min-count ${MIN_COUNT} \
   --max-count ${MAX_COUNT} \
   --enable-cluster-autoscaler \
   --enable-managed-identity \
   --kubernetes-version $KUBERNETES_VERSION \
   --location $LOCATION

# Register Kubernetes cluster to local configure file
az aks get-credentials \
   --resource-group $RESOURCE_GROUP \
   --name $AKS_NAME \
   --admin \
   --overwrite-existing

# Create Storage Account
#$rc = $(az storage account check-name --name ${storage_account} | select-string  "nameAvailable" | select-string "true")
#if ( ${rc} -ne $null)
#{
#   az storage account create `
#      --name $storage_account `
#      --RESOURCE_GROUP $RESOURCE_GROUP `
#      --location $location `
#      --sku $sku_name
#}
