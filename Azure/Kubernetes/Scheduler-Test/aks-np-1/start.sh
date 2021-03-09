#!/bin/bash
run ()
{
  ./create-resource-group.sh
  ./create-aks.sh
  ./add-nodepools.sh
}

time run
