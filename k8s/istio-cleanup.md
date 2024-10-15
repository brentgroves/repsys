# **[Cleanup](https://istio.io/latest/docs/ambient/getting-started/cleanup/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## Cleanup

When you’re finished experimenting with the Bookinfo sample, uninstall and clean it up using the following command:

```bash
pushd .
cd ~/Downloads/istio-1.23.2
scc.sh repsys11c2n1.yaml microk8s  

# See what this script does before you run it.
cp ~/Downloads/istio-1.23.2/samples/bookinfo/platform/kube/cleanup.sh ~/src/repsys/k8s/istio/
./samples/bookinfo/platform/kube/cleanup.sh
namespace ? [default] 
using NAMESPACE=default
gateway.gateway.networking.k8s.io "bookinfo-gateway" deleted
httproute.gateway.networking.k8s.io "bookinfo" deleted
Application cleanup may take up to one minute
service "details" deleted
serviceaccount "bookinfo-details" deleted
deployment.apps "details-v1" deleted
service "ratings" deleted
serviceaccount "bookinfo-ratings" deleted
deployment.apps "ratings-v1" deleted
service "reviews" deleted
serviceaccount "bookinfo-reviews" deleted
deployment.apps "reviews-v1" deleted
deployment.apps "reviews-v2" deleted
deployment.apps "reviews-v3" deleted
service "productpage" deleted
serviceaccount "bookinfo-productpage" deleted
deployment.apps "productpage-v1" deleted
Application cleanup successful
```

The Istio uninstall deletes the RBAC permissions and all resources hierarchically under the istio-system namespace. It is safe to ignore errors for non-existent resources because they may have been deleted hierarchically.

```bash
kubectl delete -f samples/addons
serviceaccount "grafana" deleted
configmap "grafana" deleted
service "grafana" deleted
deployment.apps "grafana" deleted
configmap "istio-grafana-dashboards" deleted
configmap "istio-services-grafana-dashboards" deleted
deployment.apps "jaeger" deleted
service "tracing" deleted
service "zipkin" deleted
service "jaeger-collector" deleted
serviceaccount "kiali" deleted
configmap "kiali" deleted
clusterrole.rbac.authorization.k8s.io "kiali" deleted
clusterrolebinding.rbac.authorization.k8s.io "kiali" deleted
role.rbac.authorization.k8s.io "kiali-controlplane" deleted
rolebinding.rbac.authorization.k8s.io "kiali-controlplane" deleted
service "kiali" deleted
deployment.apps "kiali" deleted
serviceaccount "loki" deleted
configmap "loki" deleted
configmap "loki-runtime" deleted
service "loki-memberlist" deleted
service "loki-headless" deleted
service "loki" deleted
statefulset.apps "loki" deleted
serviceaccount "prometheus" deleted
configmap "prometheus" deleted
clusterrole.rbac.authorization.k8s.io "prometheus" deleted
clusterrolebinding.rbac.authorization.k8s.io "prometheus" deleted
service "prometheus" deleted
deployment.apps "prometheus" deleted

istioctl uninstall -y --purge
All Istio resources will be pruned from the cluster

  Removed Deployment:istio-system:istio-ingressgateway.
  Removed Deployment:istio-system:istiod.
  Removed Service:istio-system:istio-ingressgateway.
  Removed Service:istio-system:istiod.
  Removed ConfigMap:istio-system:istio.
  Removed ConfigMap:istio-system:istio-sidecar-injector.
  Removed Pod:istio-system:istio-ingressgateway-64f9774bdc-p6l9q.
  Removed Pod:istio-system:istiod-868cc8b7d7-dhjl6.
  Removed ServiceAccount:istio-system:istio-ingressgateway-service-account.
  Removed ServiceAccount:istio-system:istio-reader-service-account.
  Removed ServiceAccount:istio-system:istiod.
  Removed RoleBinding:istio-system:istio-ingressgateway-sds.
  Removed RoleBinding:istio-system:istiod.
  Removed Role:istio-system:istio-ingressgateway-sds.
  Removed Role:istio-system:istiod.
  Removed PodDisruptionBudget:istio-system:istio-ingressgateway.
  Removed PodDisruptionBudget:istio-system:istiod.
  Removed HorizontalPodAutoscaler:istio-system:istio-ingressgateway.
  Removed HorizontalPodAutoscaler:istio-system:istiod.
  Removed MutatingWebhookConfiguration::istio-revision-tag-default.
  Removed MutatingWebhookConfiguration::istio-sidecar-injector.
  Removed ValidatingWebhookConfiguration::istio-validator-istio-system.
  Removed ValidatingWebhookConfiguration::istiod-default-validator.
  Removed ClusterRole::istio-reader-clusterrole-istio-system.
  Removed ClusterRole::istiod-clusterrole-istio-system.
  Removed ClusterRole::istiod-gateway-controller-istio-system.
  Removed ClusterRoleBinding::istio-reader-clusterrole-istio-system.
  Removed ClusterRoleBinding::istiod-clusterrole-istio-system.
  Removed ClusterRoleBinding::istiod-gateway-controller-istio-system.
  Removed CustomResourceDefinition::authorizationpolicies.security.istio.io.
  Removed CustomResourceDefinition::destinationrules.networking.istio.io.
  Removed CustomResourceDefinition::envoyfilters.networking.istio.io.
  Removed CustomResourceDefinition::gateways.networking.istio.io.
  Removed CustomResourceDefinition::peerauthentications.security.istio.io.
  Removed CustomResourceDefinition::proxyconfigs.networking.istio.io.
  Removed CustomResourceDefinition::requestauthentications.security.istio.io.
  Removed CustomResourceDefinition::serviceentries.networking.istio.io.
  Removed CustomResourceDefinition::sidecars.networking.istio.io.
  Removed CustomResourceDefinition::telemetries.telemetry.istio.io.
  Removed CustomResourceDefinition::virtualservices.networking.istio.io.
  Removed CustomResourceDefinition::wasmplugins.extensions.istio.io.
  Removed CustomResourceDefinition::workloadentries.networking.istio.io.
  Removed CustomResourceDefinition::workloadgroups.networking.istio.io.
✔ Uninstall complete
```

The istio-system namespace is not removed by default. If no longer needed, use the following command to remove it:

```bash
kubectl delete namespace istio-system
namespace "istio-system" deleted
```

The label to instruct Istio to automatically inject Envoy sidecar proxies is not removed by default. If no longer needed, use the following command to remove it:

```bash
kubectl label namespace default istio-injection-
namespace/default unlabeled
```

If you installed the Kubernetes Gateway API CRDs and would now like to remove them, run one of the following commands:

If you ran any tasks that required the experimental version of the CRDs:

```bash
kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd/experimental?ref=v1.1.0" | kubectl delete -f -
customresourcedefinition.apiextensions.k8s.io "backendtlspolicies.gateway.networking.k8s.io" deleted
customresourcedefinition.apiextensions.k8s.io "gatewayclasses.gateway.networking.k8s.io" deleted
customresourcedefinition.apiextensions.k8s.io "gateways.gateway.networking.k8s.io" deleted
customresourcedefinition.apiextensions.k8s.io "grpcroutes.gateway.networking.k8s.io" deleted
customresourcedefinition.apiextensions.k8s.io "httproutes.gateway.networking.k8s.io" deleted
customresourcedefinition.apiextensions.k8s.io "referencegrants.gateway.networking.k8s.io" deleted
customresourcedefinition.apiextensions.k8s.io "tcproutes.gateway.networking.k8s.io" deleted
customresourcedefinition.apiextensions.k8s.io "tlsroutes.gateway.networking.k8s.io" deleted
customresourcedefinition.apiextensions.k8s.io "udproutes.gateway.networking.k8s.io" deleted
```

Otherwise:

```bash
kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.1.0" | kubectl delete -f -
```

## Verify

```bash
kubectl get all                                                                                                    
NAME          READY   STATUS    RESTARTS          AGE
pod/mysql-0   1/1     Running   2479 (5d6h ago)   91d

NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/kubernetes   ClusterIP   10.152.183.1     <none>        443/TCP          96d
service/mysql-svc    NodePort    10.152.183.210   <none>        3306:30031/TCP   91d

NAME                     READY   AGE
statefulset.apps/mysql   1/1     91d
```
