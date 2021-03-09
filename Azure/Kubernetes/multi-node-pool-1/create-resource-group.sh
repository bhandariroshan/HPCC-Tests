#!/bin/bash

WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration

rc=$(az group exists --name ${RESOURCE_GROUP})
if [ "$rc" != "true" ]
then
  echo "Create resource group: $RESOURCE_GROUP ..."	
  az group create --name $RESOURCE_GROUP --location $REGION --tags $(eval echo ${TAGS} )
fi
