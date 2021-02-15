#!/bin/bash
WORK_DIR=$(dirname $0)
source ${WORK_DIR}/configuration

nplist="NP1 NP2"
for np in ${nplist}
do
  az aks nodepool add \
	--name "$(eval echo \${${np}_NAME})" \
	--resource-group ${RESOURCE_GROUP} \
	--cluster-name ${AKS_NAME} \
	--kubernetes-version ${KUBERNETES_VERSION} \
	--labels $(eval echo \${${np}_LABELS}) \
        --os-type ${OS_TYPE} \
        --zones ${ZONES} \
	--node-vm-size $(eval echo \${${np}_NODE_VM_SIZE}) \
	--node-count $(eval echo \${${np}_NODE_COUNT}) \
	--min-count $(eval echo \${${np}_MIN_COUNT}) \
	--max-count $(eval echo \${${np}_MAX_COUNT}) \
	$(eval echo \${${np}_TAINTS}) \
	$(eval echo \${${np}_AUTOSCALER}) 
done
	
