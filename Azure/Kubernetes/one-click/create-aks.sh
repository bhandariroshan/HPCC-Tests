#!/bin/bash
WORK_DIR=$(dirname $0)
echo $WORK_DIR;
source ${WORK_DIR}/configuration
echo $KUBE_DIR;
echo $1;
${KUBE_DIR}/start.sh $1
