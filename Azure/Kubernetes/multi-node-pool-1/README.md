# Create a AKS with mutiple node pools

## Introduction
AKS currently only supports one region but allow multiple zones
The default node pool is always in master mode which has all resource in namespace "kube-system"

## Kubernetes and node pools configuration
Most settings are in file configuration. You can change "aks create" options and node pools parameters. Also you can add new node pools in array node_pools
