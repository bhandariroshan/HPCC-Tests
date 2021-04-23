# Manage storage with storage account

## Create a azurefile share storage

### azurefile-sa
- Go to directory azurefile-sa and set the parameters in configuration.
- SA_LOCATION should be the same as Kubernetes cluster
- Use a different resource group name from Kubernetes cluster
- Maxiumum STORAGE_QUOTE probably is either 5TB or 100TB

Currently only SMB protocol is working
#### create a SMB storage
```console
./create-smb.sh
```
To list storages:
```console
./list.sh
```

#### delete storage
```console
./delete.sh
```
This will delete the Resource Group

#### Use the SMB storage
Before creating Kubernetes cluster make sure  Kubernetes/one-node-pool/configuration set STORAGE_DIR=azurefile-sa. Also make sure SECRET_NAME is set. 
Deploy hpcc-azurefile-sa helm chart
```console
helm install azstorage  hpcc-azurefile-sa/
```

Deploy HPCC cluster
```console
helm install hpcc  hpcc/  --set global.image.version=<version>  -f examples/azure/values-retained-azurefile.yaml
```
