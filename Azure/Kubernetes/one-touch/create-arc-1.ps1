
$kubernetes_version = "1.19.3"
$subscription = "us-hpccplatform-dev"
$resource_group = "aks-arc-gitops-ming"
$location = "eastus2"
$aks_name = "aks-arc-gitops-ming-${location}"
$node_vm_size = "Standard_DS2_v2"
$tags = "business_unit=research-and-development cost_center=st660 environment=development location=$location market=us product_group=dev production_name=hpccsystems project=arc-gitops-test resource_group_type=app sre_team=hpcc_platform subscription_id=module.subscription.output.subscription_id subcription_type=nonprod"
$storage_account = "arc-gitops-sa"
$sku_name = "Standard_LRS"

# Set subscription
az account set --subscription $subscription

# Create ssh keys
if (!(Test-Path -path ~/.ssh/id_rsa))
{
    ssh-keygen -m PEM -t rsa -b 4096 -q -N ""
}

# Create Resource Group
$rc = az group exists --name $resource_group
if ( $rc -eq "true" )
{
    "Resource group $resource_group already exists."
    exit 1
}
az group create --name $resource_group --location $location --tags `
  business_unit=research-and-development cost_center=st660 `
  environment=development location=$location market=us `
  product_group=dev production_name=hpccsystems project=arc-gitops-test `
  resource_group_type=app sre_team=hpcc_platform `
  subscription_id=module.subscription.output.subscription_id `
  subcription_type=nonprod

# Create a Kubernetes Cluster
az aks create `
   --resource-group $resource_group --name $aks_name `
   --node-vm-size ${node_vm_size} `
   --node-count 3 `
   --min-count 3 `
   --max-count 10 `
   --enable-cluster-autoscaler `
   --enable-managed-identity `
   --kubernetes-version $kubernetes_version `
   --location $location

# Register Kubernetes cluster to local configure file
az aks get-credentials `
   --resource-group $resource_group `
   --name $aks_name `
   --admin `
   --overwrite-existing

# Create Storage Account
#$rc = $(az storage account check-name --name ${storage_account} | select-string  "nameAvailable" | select-string "true")
#if ( ${rc} -ne $null)
#{
#   az storage account create `
#      --name $storage_account `
#      --resource_group $resource_group `
#      --location $location `
#      --sku $sku_name
#}
