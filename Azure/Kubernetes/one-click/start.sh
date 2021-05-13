#!/bin/bash
WORK_DIR=$(dirname $0);
echo $WORK_DIR;
WORK_DIR=$(cd ${WORK_DIR};  pwd); cd $WORK_DIR

run ()
{
  ${WORK_DIR}/create-aks.sh ${WORK_DIR}/configuration
  [[ $? -eq 0 ]] && ${WORK_DIR}/deploy-hpcc.sh 
}

time run 
