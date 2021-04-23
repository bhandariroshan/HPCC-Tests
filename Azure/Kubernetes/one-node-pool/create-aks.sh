#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration
[[ -n "$STORAGE_DIR" ]] &&  source ${WORK_DIR}/../../Storage/${STORAGE_DIR}/configuration
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
   --location $LOCATION

#   --kubernetes-version $KUBERNETES_VERSION \

# Register Kubernetes cluster to local configure file
az aks get-credentials \
   --resource-group $RESOURCE_GROUP \
   --name $AKS_NAME \
   --admin \
   --overwrite-existing

if [[ -n "$STORAGE_DIR" ]]
then
  echo "create secret $SECRET_NAME"
  account_key=$(cat ${KEY_DIR}/${SHARE_NAME}.key | cut -d':' -f2 | sed 's/[[:space:]]\+//g')
  kubectl create secret generic $SECRET_NAME \
	  --from-literal=azurestorageaccountname=${STORAGE_ACCOUNT_NAME} \
	  --from-literal=azurestorageaccountkey=${account_key}
fi
