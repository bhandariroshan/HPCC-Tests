# hpcc-istio

## Install
Download Istio from https://istio.io/latest/docs/setup/getting-started/#download
Unpack the file and add <Istio directory>/bin to PATH variable.
Tested ISTIO release is v1.9.1

This is tested local on Docker Desktop

```sh
istioctl install -f install-components.yaml
```

For v1.9.1 there are some changes:
- addons moved to <Istio directory>/samples/addons/
- remove telemetry v1

addons install issue for Kiali:<br/>
unable to recognize "addons/kiali.yaml": no matches for kind "MonitoringDashboard" in version "monitoring.kiali.io/v1alpha1"<br/>
Fix: splite kiali.yaml to two files. The first one has top "kind: CustomResourceDefinition" to a different file, such as crd.yaml. Make sure change "v1beta" to "v1". The rest is kept in kiali.yaml. Run:
```sh
#kubectl apply -f crd.yaml
#kubectl apply -f kiali.yaml
kubectl apply -f samples/addons
```

To uninstall
```sh
istioctl manifest generate -f install-components.yaml | kubectl delete -f -
istioctl delete -f samples/addons

```
## Enable istio-inject
Before start HPCC cluster enabble istio-injection
```sh
 kubectl label namespace ${hpcc_namespace} istio-injection=enabled --overwrite
```
To check what is enabled for the namespace
```sh
 kubectl label namespace ${hpcc_namespace} --list=true
```
The default namespace is "default"


## Side car lifecycle issue
Since default HPCC Systems cloud will use job pod for eclcc, eclagent and thor and job cannot terminate itself due to envoy still running. It is a known issue for any sidecar job pod for current Kubernetes release (1.19).

Kubernetes is planning to provide a fix but not sure when. The fix is not even in the feature gate yet.

To work around the problem
### useChileProcesses:true
Set following in hpcc/values.yaml
```sh
 misc:
    postJobCommand: "curl -sf -XPOST http://127.0.0.1:15020/quitquitquit"
```
