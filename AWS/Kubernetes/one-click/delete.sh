#!/bin/bash
WORK_DIR=$(dirname $0)
WORK_DIR=$(cd ${WORK_DIR};  pwd); cd $WORK_DIR
source ${WORK_DIR}/configuration
${EKS_DIR}/delete-eks.sh ${WORK_DIR}/configuration
