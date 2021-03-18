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
Add "curl -sf -XPOST http://127.0.0.1:15020/quitquitquit" will get error in job but the job will terminiate and funcion OK

