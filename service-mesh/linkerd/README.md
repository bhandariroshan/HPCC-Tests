# Linkerd

- https://linkerd.io/2.10/getting-started/

## Installation

```sh
curl -sL run.linkerd.io/install | sh
export PATH=$PATH:<USER HOME>/.linkerd2/bin
linkerd check --pre
linkerd install | kubectl apply -f -
linkerd viz install | kubectl apply -f -

#linkerd jaeger install | kubectl apply -f -
#linkerd multicluster install | kubectl apply -f -



#Uninstall
linkerd viz uninstall | kubectl delete -f -
linkerd uninstall | kubectl delete -f -
#linkerd jaeger uninstall | kubectl delete -f -
#linkerd multicluster uninstall | kubectl delete -f -
```

## Sidecar injection
- Deploy HPCC cluster 
- sidecar inject 
```sh
# This will not inject to Job which can't terminate.
# See https://linkerd.io/2.10/tasks/graceful-shutdown/
kubectl get deploy -o yaml | linkerd inject - | kubectl apply -f -
```
To inject for all pods
```sh
kubectl annotate namespace default --overwrite linkerd.io/inject='enabled'

```


