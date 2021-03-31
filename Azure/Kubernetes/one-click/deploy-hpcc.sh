#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration

if [ "$USE_EXISTING" = "false" ]
then
  mkdir -p ${DEPLOY_DIR}
  cd ${DEPLOY_DIR}
  [ -d ./HPCC-Platform ] && rm -rf ./HPCC-Platform

  git clone https://github.com/hpcc-systems/HPCC-Platform.git
  cd HPCC-Platform/helm

  if [ -n "${HPCC_BRANCH}" ]
  then
    rc=$(git tag | grep ${HPCC_BRANCH}) 
    if [ -n "$rc" ]
    then
      git fetch && git fetch --tags
    fi
    git checkout ${HPCC_BRANCH}
  fi
else
  if [ ! -d ${DEPLOY_DIR}/hpcc/templates ]
  then
    "Can't find hpcc/templates in $DEPLOY_DIR . This should be HPCC helm chart directory"
    exit -1
  fi
  cd ${DEPLOY_DIR}
fi

hpcc_azure_file=examples/azure/values-auto-azurefile.yaml
if [ "${HPCC_STORAGE}" = "hpcc-azurefile" ]
then
  echo "Deploy HPCC storage ${HPCC_STORAGE}"
  helm install azstorage hpcc-azurefile/*
  hpcc_azure_file=examples/azure/values-retained-azurefile.yaml
fi

echo "Deploy HPCC cluster"
[ -n "$HPCC_IMAGE_NAME" ] && SET_IMG_NAME="--set global.image.name=${HPCC_IMAGE_NAME}"
helm install ${HPCC_CLUSTER_NAME} ./hpcc --set global.image.version=${IMAGE_VERSION} ${SET_IMG_NAME}  -f ${hpcc_azure_file}
