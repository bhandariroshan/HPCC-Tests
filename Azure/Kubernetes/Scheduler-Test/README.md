# Test Kubernetes Scheduler

## Introduction
JIRA : https://track.hpccsystems.com/browse/HPCC-25219

## Check Yaml Output
- Uncomment "kubeScheduler" in values.yaml
- helm template hpcc ./hpcc --set global.image.version=<HPCC Vesion> >~/tmp/hpcc.yaml
- Validate nodeSelector/tolerations/affinity/schedulerName entries.

## Test nodeSelector and toleraatins in Azure
- Only set nodeSelector and tolerations of "kubeScheduler" in values.
- Update resource group name and AKS cluster name in aks-np-1/configuration
- Setup AKS by runing aks-np-1/start.sh
- Deploy HPCC cluster:  helm template hpcc ./hpcc --set global.image.version=<HPCC Vesion> 
- Check pods node assigning as defined in "kubeScheduler"
- Delete the AKS cluster:  delete-resource-group.sh
