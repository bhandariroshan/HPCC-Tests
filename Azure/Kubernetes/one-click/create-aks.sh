#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration
echo ${KUBE_DIR}
${KUBE_DIR}/start.sh $1
