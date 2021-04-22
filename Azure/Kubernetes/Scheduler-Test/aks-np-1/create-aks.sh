#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration
[[ -n "$1" ]] && source $1

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
