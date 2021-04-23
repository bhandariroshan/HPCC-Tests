#!/bin/bash
# https://docs.microsoft.com/en-us/azure/aks/azure-files-volume

WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration
[[ -n "$1" ]] && source $1

# Set subscription
az account set --subscription $SUBSCRIPTION

# Create a resource group
az group create --name ${SA_RESOURCE_GROUP} --location ${SA_LOCATION}

# Create a storage account
az storage account create \
   -n $STORAGE_ACCOUNT_NAME \
   -g $SA_RESOURCE_GROUP \
   -l $SA_LOCATION \
   --sku $SA_SKU \
   --kind FileStorage

# Export the connection string as an environment variable, this is used when creating the Azure file share
#export AZURE_STORAGE_CONNECTION_STRING=$(az storage account show-connection-string -n $STORAGE_ACCOUNT_NAME -g $SA_RESOURCE_GROUP -o tsv)

# Create the file share
az storage share-rm create \
   --resource-group $SA_RESOURCE_GROUP \
   --storage-account $STORAGE_ACCOUNT_NAME \
   --name $SHARE_NAME \
   --enabled-protocol NFS \
   --root-squash RootSquash \
   --quota $STORAGE_QUOTE

# Get storage account key
STORAGE_KEY=$(az storage account keys list --resource-group $SA_RESOURCE_GROUP --account-name $STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv)

# Echo storage account name and key
echo Storage account name: $STORAGE_ACCOUNT_NAME
mkdir -p $KEY_DIR
echo Storage account key: $STORAGE_KEY > ${KEY_DIR}/${SHARE_NAME}.key
cat ${KEY_DIR}/${SHARE_NAME}.key
