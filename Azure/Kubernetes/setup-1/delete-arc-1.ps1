$subscription = "us-hpccplatform-dev"
$resource_group = "aks-arc-gitops-ming"
$location = "eastus2"

# Set subscription
az account set --subscription $subscription

# Create Resource Group
$rc = az group exists --name $resource_group
if ( $rc -eq "true" )
{
    "Delete Resource group $resource_group."
    az group delete --name $resource_group --yes
}