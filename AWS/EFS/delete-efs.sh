#!/bin/bash


EFS_NAME=efs-provisioner

[[ -n "${INPUT_EFS_NAME}" ]] && EFS_NAME=${INPUT_EFS_NAME}

helm list | grep -q ${EFS_NAME} 
if [ $? -eq 0 ]
then
  helm uninstall ${EFS_NAME} 
fi
