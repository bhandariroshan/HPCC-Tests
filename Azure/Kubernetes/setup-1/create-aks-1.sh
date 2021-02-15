#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration

# Set subscription
az account set --subscription $subscription

# Create ssh keys
if [ ! -e ~/.ssh/id_rsa ] || [ ! -e ~/.ssh/id_rsa.pub ]  
then
     GEN_SSK_KEYS="--generate-ssh-keys"
fi

# Create Resource Group
rc=$(az group exists --name $resource_group)
if [ "$rc" = "true" ]
then
    echo "Resource group $resource_group already exists."
    exit 1
fi
az group create --name $resource_group --location $location --tags \
  business_unit=research-and-development cost_center=st660 \
  environment=development location=$location market=us \
  product_group=dev production_name=hpccsystems project=arc-gitops-test \
  resource_group_type=app sre_team=hpcc_platform \
  subscription_id=module.subscription.output.subscription_id \
  subcription_type=nonprod

# Create a Kubernetes Cluster
az aks create  ${GEN_SSK_KEYS} \
   --resource-group $resource_group --name $aks_name \
   --node-vm-size ${node_vm_size} \
   --node-count 2 \
   --min-count 2 \
   --max-count 4 \
   --enable-cluster-autoscaler \
   --enable-managed-identity \
   --kubernetes-version $kubernetes_version \
   --location $location

# Register Kubernetes cluster to local configure file
az aks get-credentials \
   --resource-group $resource_group \
   --name $aks_name \
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
