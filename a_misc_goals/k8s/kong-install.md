# **[Install KIC with Kong Gateway Operator](https://docs.konghq.com/gateway-operator/latest/get-started/kic/install/)**

## Note

**Uninstalling this was not easy because I could not find any documentation!**  Now that I have thought about it.  If I would have deleted the gatewayclass and gateway configuration after deleting the echo service and before uninstalling the kgo helm chart and deleting the kong-system namespace things might have gone smoothly.

Both Kong Gateway Operator and Kong Ingress Controller can be configured using the **[Kubernetes Gateway API](https://github.com/kubernetes-sigs/gateway-api)**.

You can configure your GatewayClass and Gateway objects in a vendor independent way and Kong Gateway Operator translates those requirements in to Kong specific configuration.

This means that CRDs for both the Gateway API and Kong Ingress Controller have to be installed.

## Uninstall the Helm chart

To remove the Kubernetes components associated with the chart and delete the release, uninstall the Helm chart.

Uninstall and delete the my-release deployment:

```bash
pushd .
cd ~/src/repsys/k8s/kong
scc.sh reports-aks-user.yaml reports-aks
kubectl delete -f echo-service.yaml

kubectl delete gatewayclass kong
kubectl delete GatewayConfiguration kong
# list releases
# helm list -n <namespace>
helm list -n kong-system
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/brent/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/brent/.kube/config
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
kgo     kong-system     1               2024-10-09 17:40:36.742480888 -0400 EDT deployed        gateway-operator-0.2.1  1.3 

# helm uninstall <name-of-the-release> -n <namespace>
helm uninstall kgo -n kong-system

# This does not delete kong deployments which get created when a gatewayclass is installed.

# kubectl edit gateway kong
# Then delete the finalizer line along with all finalizers

# do the same with anything that wont delete
# kubectl edit controlplane.gateway-operator.konghq.com/kong-4trrn
kubectl delete  httproute echo
kubectl delete ns kong-system
kubectl delete clusterrolebinding controlplane-kong-4trrn-5dxrg 
kubectl delete clusterrole kong-4trrn-2j9qt
kubectl delete validatingwebhookconfiguration kong-4trrn
kubectl delete validatingwebhookconfiguration gateway-operator-validation.konghq.com

kubectl delete crd tcpingresses.configuration.konghq.com                          
kubectl delete crd aigateways.gateway-operator.konghq.com    
```

## Install Kong Gateway Operator

Update the Helm repository:

```bash
# add repo
helm repo add kong https://charts.konghq.com
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/brent/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/brent/.kube/config
"kong" already exists with the same configuration, skipping

# update repo
helm repo update kong
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/brent/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/brent/.kube/config
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "kong" chart repository
Update Complete. ⎈Happy Helming!⎈
```

Install Kong Gateway Operator with Helm:

```bash
# --install option: if a release by this name doesn't already exist, run an install
helm upgrade --install kgo kong/gateway-operator -n kong-system --create-namespace --set image.tag=1.3
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/brent/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/brent/.kube/config
Release "kgo" does not exist. Installing it now.
NAME: kgo
LAST DEPLOYED: Wed Oct  9 17:40:36 2024
NAMESPACE: kong-system
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
kgo-gateway-operator has been installed. Check its status by running:

  kubectl --namespace kong-system  get pods

For more details, please refer to the following documents:

* https://docs.konghq.com/gateway-operator/latest/get-started/kic/create-gateway/
* https://docs.konghq.com/gateway-operator/latest/get-started/konnect/deploy-data-plane/
```

You can wait for the operator to be ready using kubectl wait:

```bash
kubectl -n kong-system wait --for=condition=Available=true --timeout=120s deployment/kgo-gateway-operator-controller-manager
deployment.apps/kgo-gateway-operator-controller-manager condition met

  kubectl --namespace kong-system  get pods
  NAME                                                     READY   STATUS      RESTARTS   AGE
gateway-operator-admission-jcgrv-c6vsl                   0/1     Completed   0          4m47s
kgo-gateway-operator-controller-manager-68cb9b45-l96qj   2/2     Running     0          4m52s

```

### Create a GatewayClass

To use the Gateway API resources to configure your routes, you need to create a GatewayClass instance and create a Gateway resource that listens on the ports that you need.

```bash
echo '
kind: GatewayConfiguration
apiVersion: gateway-operator.konghq.com/v1beta1
metadata:
 name: kong
 namespace: default
spec:
 dataPlaneOptions:
   deployment:
     podTemplateSpec:
       spec:
         containers:
         - name: proxy
           image: kong:3.8.0
           readinessProbe:
             initialDelaySeconds: 1
             periodSeconds: 1
 controlPlaneOptions:
   deployment:
     podTemplateSpec:
       spec:
         containers:
         - name: controller
           image: kong/kubernetes-ingress-controller:3.3.1
           env:
           - name: CONTROLLER_LOG_LEVEL
             value: debug
---
kind: GatewayClass
apiVersion: gateway.networking.k8s.io/v1
metadata:
 name: kong
spec:
 controllerName: konghq.com/gateway-operator
 parametersRef:
   group: gateway-operator.konghq.com
   kind: GatewayConfiguration
   name: kong
   namespace: default
---
kind: Gateway
apiVersion: gateway.networking.k8s.io/v1
metadata:
 name: kong
 namespace: default
spec:
 gatewayClassName: kong
 listeners:
 - name: http
   protocol: HTTP
   port: 80

' | kubectl apply -f -

gatewayconfiguration.gateway-operator.konghq.com/kong created
gatewayclass.gateway.networking.k8s.io/kong created
gateway.gateway.networking.k8s.io/kong created
```

Run ```kubectl get gateway kong -n default``` to get the IP address for the gateway and set that as the value for the variable PROXY_IP.

```bash
export PROXY_IP=$(kubectl get gateway kong -n default -o jsonpath='{.status.addresses[0].value}')

echo $PROXY_IP                                                                                   
172.169.103.249

kubectl  get svc                      
NAME                                    TYPE           CLUSTER-IP    EXTERNAL-IP       PORT(S)        AGE
controlplane-webhook-kong-4trrn-trhph   ClusterIP      10.0.200.36   <none>            8080/TCP       4m26s
dataplane-admin-kong-dckgd-224dn        ClusterIP      None          <none>            8444/TCP       4m26s
dataplane-ingress-kong-dckgd-rdl4k      LoadBalancer   10.0.61.63    172.169.103.249   80:32308/TCP   4m26s
kubernetes                              ClusterIP      10.0.0.1      <none>            443/TCP        576d
```

Note: if your cluster can not provision LoadBalancer type Services then the IP you receive may only be routable from within the cluster.

## Create a Route

After you’ve installed all of the required components and configured a GatewayClass you can route some traffic to a service in your Kubernetes cluster.

## Configure the echo service

In order to route a request using Kong Gateway we need a service running in our cluster. Install an echo service using the following command:

```bash
pushd .
cd ~/src/repsys/k8s/kong
curl https://docs.konghq.com/assets/kubernetes-ingress-controller/examples/echo-service.yaml > echo-service.yaml

kubectl apply -f echo-service.yaml
service/echo created
deployment.apps/echo created
```

Create a HTTPRoute to send any requests that start with /echo to the echo service.

```bash
echo '
kind: HTTPRoute
apiVersion: gateway.networking.k8s.io/v1
metadata:
  name: echo
spec:
  parentRefs:
    - group: gateway.networking.k8s.io
      kind: Gateway
      name: kong
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /echo
      backendRefs:
        - name: echo
          port: 1027
' | kubectl apply -f -

httproute.gateway.networking.k8s.io/echo created
```

## Test the configuration

To test the configuration, make a call to the $PROXY_IP that you configured.

```bash
curl $PROXY_IP/echo

Welcome, you are connected to node aks-default-29924714-vmss000000.
Running on Pod echo-9c54d7f88-nt7kf.
In namespace default.
With IP address 10.244.2.30.
```

Congratulations! You just configured Kong Gateway Operator, Kong Ingress Controller and Kong Gateway using open standards.

## Next steps

Now that you have a running DataPlane configured using Gateway API resources, you can explore the power that Kong Gateway provides:

- **[tls](./kong/tls.md)**
- **[Configuring Kong Gateway plugins using Kong Ingress Controller](./kong/config_kong_gw_plugins_using_kic.md)**
- Upgrading Kong Gateway Operator managed data planes
