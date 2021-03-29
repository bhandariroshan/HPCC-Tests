#!/bin/bash
WORK_DIR=$(dirname $0)

AWS_DIR=$(cd ${WORK_DIR}/../..;  pwd); cd $WORK_DIR
source ${AWS_DIR}/aws-saml-profile 
[[ -n $RISK_USERNAME ]] && ${AWS_DIR}/aws-get-saml

echo $AWS_PROFILE
source ${WORK_DIR}/configuration
[[ -n "$1" ]] && source $1

# Create a Kubernetes Cluster
echo "eksctl create cluster  -p $AWS_PROFILE \
  --name ${EKS_NAME} \
  --version ${KUBERNETES_VERSION} \
  --region ${EKS_REGION} \
  --nodegroup-name ${NODE_GROUP_NAME} \
  --node-type ${NODE_TYPE} \
  --nodes ${NODE_COUNT} \
  --nodes-min ${MIN_COUNT} \
  --nodes-max ${MAX_COUNT} \
  --node-volume-size ${NODE_VOLUME_SIZE} \
  --node-ami ${NODE_AMI} \
  ${VPC_SUBNETS} \
  --tags \"${TAGS}\""

time eksctl create cluster -p $AWS_PROFILE \
  --name ${EKS_NAME} \
  --version ${KUBERNETES_VERSION} \
  --region ${EKS_REGION} \
  --nodegroup-name ${NODE_GROUP_NAME} \
  --node-type ${NODE_TYPE} \
  --nodes ${NODE_COUNT} \
  --nodes-min ${MIN_COUNT} \
  --nodes-max ${MAX_COUNT} \
  --node-volume-size ${NODE_VOLUME_SIZE} \
  --node-ami ${NODE_AMI} \
  ${VPC_SUBNETS} \
  --tags "${TAGS}"
