#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration

# Deploy EFS 
#-----------------------------
echo "${EFS_DIR}/deploy-efs.sh"
${EFS_DIR}/deploy-efs.sh

# Get HPCC Platform source
#-----------------------------
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

# Deploy HPCC Cluster
#-----------------------------
echo "Deploy HPCC cluster"
[ -n "$HPCC_IMAGE_NAME" ] && SET_IMG_NAME="--set global.image.name=${HPCC_IMAGE_NAME}"
helm install ${HPCC_CLUSTER_NAME} ./hpcc \
	--set global.image.version=${IMAGE_VERSION} ${SET_IMG_NAME} \
        --set storage.dllStorage.storageClass=aws-efs \
        --set storage.daliStorage.storageClass=aws-efs \
        --set storage.dataStorage.storageClass=aws-efs \
        --set sasha.wu-archiver.storage.storageClass=aws-efs \
        --set sasha.dfuwu-archiver.storage.storageClass=aws-efs 
