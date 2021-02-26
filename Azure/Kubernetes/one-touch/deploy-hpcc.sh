#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration

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

hpcc_azure_file=examples/azure/values-auto-azurefile.yaml
if [ "${HPCC_STORAGE}" = "hpcc-azurefile" ]
then
  echo "Deploy HPCC storage ${HPCC_STORAGE}"
  helm install azstorage hpcc-azurefile/*
  hpcc_azure_file=examples/azure/values-retained-azurefile.yaml
fi

echo "Deploy HPCC cluster"
helm install ${HPCC_CLUSTER_NAME} ./hpcc --set global.image.version=${IMAGE_VERSION} -f ${hpcc_azure_file}



