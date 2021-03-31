#!/bin/bash
WORK_DIR=$(dirname $0)
WORK_DIR=$(cd ${WORK_DIR};  pwd); cd $WORK_DIR
source ${WORK_DIR}/configuration

OPTION_CONFIG=
[[ -n "$ADDITIONAL_EKS_CONFIGURATION" ]] && OPTION_CONFIG="${EKS_DIR}/${ADDITIONAL_EKS_CONFIGURATION}
${EKS_DIR}/start.sh ${OPTION_CONFIG} ${WORK_DIR}/configuration
${WORK_DIR}/deploy-hpcc.sh
