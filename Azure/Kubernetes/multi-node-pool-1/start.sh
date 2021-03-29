#!/bin/bash
WORK_DIR=$(dirname $0)
run ()
{
  ${WORK_DIR}/create-resource-group.sh $1
  ${WORK_DIR}/create-aks.sh $1
  ${WORK_DIR}/add-nodepools.sh $1
}

time run
