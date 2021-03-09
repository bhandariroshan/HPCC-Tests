#!/bin/bash
run ()
{
  ./create-aks.sh
  ./deploy-hpcc.sh
}

time run
