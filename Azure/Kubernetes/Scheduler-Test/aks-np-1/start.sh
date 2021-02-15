#!/bin/bash
./create-resource-group.sh
time ./create-aks.sh
time. ./add-nodepools.sh
