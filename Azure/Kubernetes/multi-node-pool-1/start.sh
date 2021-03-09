#!/bin/bash
WORK_DIR=$(dirname $0)
run ()
{
  ${WORK_DIR}/create-resource-group.sh
  ${WORK_DIR}/create-aks.sh
  ${WORK_DIR}/add-nodepools.sh
}

time run
