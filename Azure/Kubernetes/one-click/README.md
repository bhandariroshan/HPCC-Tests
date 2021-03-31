# One touch to create AKS cluster and deploy HPCC 

## Configuration
Change configuration in configuration file

To change Kubernetes configuration edit configuration file
You should change at least RESOURCE_GROUP varialbe in above file

To use existing HPCC-Platform set USE_EXISTING="true" in current directory configuration file. Be ware in this case "DEPLOY_DIR" should be HPCC helm directory, for example, ~/work/HPCC-Platform/helm".:

## Deploy
./start.sh

## Clean up
./delete-aks.sh
