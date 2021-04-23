#!/bin/bash

WORK_DIR=$(dirname $0)
AWS_DIR=$(cd ${WORK_DIR}/..;  pwd); cd $WORK_DIR
source ${AWS_DIR}/aws-saml-profile
[[ -n $RISK_USERNAME ]] && ${AWS_DIR}/aws-get-saml 
echo "AWS_PROFILE: $AWS_PROFILE"

#EFS_PROFILE_NAME=HPCC-Dev-EFS-Test
EFS_PROFILE_NAME=EFS-dev-us-east-2-1
[[ -n "$1" ]] && source $1
[[ -n "${INPUT_EFS_PROFILE_NAME}" ]] && EFS_PROFILE_NAME=${INPUT_EFS_PROFILE_NAME}
source ${WORK_DIR}/${EFS_PROFILE_NAME}

#for zone in "${!EFS_MOUNT_TARGET_IDS[@]}"
#do
#	echo "$zone :  ${EFS_MOUNT_TARGET_IDS[$zone]}"
#done

EFS_NAME=efs-provisioner
EFS_CSI_DRIVER=true
#EKS_NAME=hpcc
#EKS_NAME=eks-one-np-us-east-1
EKS_NAME=eks-test-us-east-2
[[ -n "${INPUT_EFS_NAME}" ]] && EFS_NAME=${INPUT_EFS_NAME}
[[ -n "${INPUT_EKS_NAME}" ]] && EKS_NAME=${INPUT_EKS_NAME}
[[ -n "${INPUT_CSI_DRIVER}" ]] && EFS_CSI_DRIVER=${INPUT_EFS_CSI_DRIVER}

install_efs_provisioner()
{
  # Add efs-provistioner Helm Chart
  helm repo add efs-provisioner https://charts.helm.sh/stable

  # Get EKS security group
  echo "aws eks describe-cluster --name $EKS_NAME --region $AWS_REGION --query cluster.resourcesVpcConfig.clusterSecurityGroupId"
  eks_security_group_id=$(aws eks describe-cluster --name $EKS_NAME --region $AWS_REGION --query cluster.resourcesVpcConfig.clusterSecurityGroupId)
  echo "EKS security gorup id: $eks_security_group_id"

  # Get mount_target_security_group_id. Assume all of them are the same. Will deal with different ones later
  first_zone=$(echo "${!EFS_SECURITY_GROUPS[@]}" | cut -d' ' -f1)
  target_security_group_id=${EFS_SECURITY_GROUPS[$first_zone]}
  echo "Target security gorup id: $target_security_group_id"

  # Authorize inbound access to the security group for EFS mount target
  echo "aws ec2 authorize-security-group-ingress \
    --group-id $target_security_group_id \
    --protocol tcp \
    --port 2049 \
    --source-group $eks_security_group_id \
    --region $AWS_REGION
  "
  aws ec2 authorize-security-group-ingress \
    --group-id $target_security_group_id \
    --protocol tcp \
    --port 2049 \
    --source-group $eks_security_group_id \
    --region $EFS_REGION

  # create efs-provisiner
  echo "kubectl apply -k \"github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.0\""   
  kubectl apply -k "github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.0"   
  helm install ${EFS_NAME} \
    efs-provisioner/efs-provisioner \
    --set efsProvisioner.efsFileSystemId=${EFS_ID} \
    --set efsProvisioner.awsRegion=${EFS_REGION}
}
helm list | grep -q ${EFS_NAME} 
if [ $? -ne 0 ]
then
  if [ "${EFS_CSI_DRIVER}" = "true" ]
  then
    install_efs_provisioner
  #else # do not use CSI driver
  fi
else
  echo "efs-provisioner $EFS_NAME may already exists."
fi
