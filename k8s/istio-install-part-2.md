# **[Set up a Kubernetes Cluster for Istio](https://istio.io/latest/docs/examples/microservices-istio/setup-kubernetes-cluster/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

This guide lets you quickly evaluate Istio. If you are already familiar with Istio or interested in installing other configuration profiles or advanced deployment models, refer to our which Istio installation method should I use? FAQ page.

## references

- **[microk8s istio](https://gist.github.com/Realiserad/391855c4a0fb0072994e5ad2a53d65c0)**
- **[install/uninstall k8s gateway crds](https://gateway-api.sigs.k8s.io/guides/)**

## 1

```bash
pushd .
cd ~/src/repsys/k8s
# Create an environment variable to store the name of a namespace that you will use when you run the tutorial commands. You can use any name, for example tutorial.

export NAMESPACE=tutorial

# Create the namespace:
kubectl create namespace $NAMESPACE
namespace/tutorial created
```

## 4. **[Install Istio](./istio-install-part-2.md) using the default profile

## 6. Create a Kubernetes Ingress resource for these common Istio services

Create a Kubernetes Ingress resource for these common Istio services using the kubectl command shown. It is not necessary to be familiar with each of these services at this point in the tutorial.

- **[grafana](https://grafana.com/docs/guides/getting_started/)**
- **[jaeger](https://www.jaegertracing.io/docs/1.13/getting-started/)**
- **[prometheus](https://prometheus.io/docs/prometheus/latest/getting_started/)**
- **[kali](https://kiali.io/docs/installation/quick-start/)**

The kubectl command can accept an in-line configuration to create the Ingress resources for each service:

Ingress is frozen. New features are being added to the Gateway API.

```bash
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: istio-system
  namespace: istio-system
  annotations:
    kubernetes.io/ingress.class: istio
spec:
  rules:
  - host: my-istio-dashboard.io
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: grafana
            port:
              number: 3000
  - host: my-istio-tracing.io
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: tracing
            port:
              number: 9411
  - host: my-istio-logs-database.io
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: prometheus
            port:
              number: 9090
  - host: my-kiali.io
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: kiali
            port:
              number: 20001
EOF
Warning: annotation "kubernetes.io/ingress.class" is deprecated, please use 'spec.ingressClassName' instead
ingress.networking.k8s.io/istio-system created
```

## Create a role

Create a role to provide read access to the istio-system namespace. This role is required to limit permissions of the participants in the steps below.

```bash
kubectl apply -f - <<EOF
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: istio-system-access
  namespace: istio-system
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["*"]
  verbs: ["get", "list"]
EOF
role.rbac.authorization.k8s.io/istio-system-access created
```

## 8. Create a service account for each participant

```bash
echo $NAMESPACE
tutorial

kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ${NAMESPACE}-user
  namespace: $NAMESPACE
EOF
serviceaccount/tutorial-user created
```

## 9. Limit each participant’s permissions

Limit each participant’s permissions. During the tutorial, participants only need to create resources in their namespace and to read resources from istio-system namespace. It is a good practice, even if using your own cluster, to avoid interfering with other namespaces in your cluster.

Create a role to allow read-write access to each participant’s namespace. Bind the participant’s service account to this role and to the role for reading resources from istio-system:

```bash
echo $NAMESPACE
tutorial

kubectl apply -f - <<EOF
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: ${NAMESPACE}-access
  namespace: $NAMESPACE
rules:
- apiGroups: ["", "extensions", "apps", "networking.k8s.io", "networking.istio.io", "authentication.istio.io",
              "rbac.istio.io", "config.istio.io", "security.istio.io"]
  resources: ["*"]
  verbs: ["*"]
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: ${NAMESPACE}-access
  namespace: $NAMESPACE
subjects:
- kind: ServiceAccount
  name: ${NAMESPACE}-user
  namespace: $NAMESPACE
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: ${NAMESPACE}-access
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: ${NAMESPACE}-istio-system-access
  namespace: istio-system
subjects:
- kind: ServiceAccount
  name: ${NAMESPACE}-user
  namespace: $NAMESPACE
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: istio-system-access
EOF

role.rbac.authorization.k8s.io/tutorial-access created
rolebinding.rbac.authorization.k8s.io/tutorial-access created
rolebinding.rbac.authorization.k8s.io/tutorial-istio-system-access created
```

## 10. Create config file

Each participant needs to use their own Kubernetes configuration file. This configuration file specifies the cluster details, the service account, the credentials and the namespace of the participant. The kubectl command uses the configuration file to operate on the cluster.

Generate a Kubernetes configuration file for each participant:

This command assumes your cluster is named tutorial-cluster. If your cluster is named differently, replace all references with the name of your cluster.

```bash
# get microk8s cluster name
cat ~/.kube/repsys11c2n1.yaml
# get name from clusters.name
clusters:
- cluster:
...
  name: microk8s-cluster
# cluster Name: microk8s-cluster

# get aks cluster name
cat ~/.kube/reports-aks-user.yaml
# get name from clusters.name
clusters:
- cluster:
...
  name: reports-aks
# cluster name: reports-aks

export NAMESPACE=tutorial

export CLUSTERNAME=microk8s-cluster
# export CLUSTERNAME=reports-aks

pushd .
cd ~/src/k8s/all-config-files
# cat <<EOF > ./${NAMESPACE}-user-config.yaml
cat <<EOF > ./repsys11c2n1-user-config.yaml
apiVersion: v1
kind: Config
preferences: {}

clusters:
- cluster:
    certificate-authority-data: $(kubectl get secret $(kubectl get sa ${NAMESPACE}-user -n $NAMESPACE -o jsonpath={.secrets..name}) -n $NAMESPACE -o jsonpath='{.data.ca\.crt}')
    server: $(kubectl config view -o jsonpath="{.clusters[?(.name==\"$(kubectl config view -o jsonpath="{.contexts[?(.name==\"$(kubectl config current-context)\")].context.cluster}")\")].cluster.server}")
  name: ${CLUSTERNAME}

users:
- name: ${NAMESPACE}-user
  user:
    as-user-extra: {}
    client-key-data: $(kubectl get secret $(kubectl get sa ${NAMESPACE}-user -n $NAMESPACE -o jsonpath={.secrets..name}) -n $NAMESPACE -o jsonpath='{.data.ca\.crt}')
    token: $(kubectl get secret $(kubectl get sa ${NAMESPACE}-user -n $NAMESPACE -o jsonpath={.secrets..name}) -n $NAMESPACE -o jsonpath={.data.token} | base64 --decode)

contexts:
- context:
    cluster: ${NAMESPACE}-cluster
    namespace: ${NAMESPACE}
    user: ${NAMESPACE}-user
  name: ${NAMESPACE}

current-context: ${NAMESPACE}
EOF

scc.sh repsys11c2n1-user-config.yaml tutorial 

set-cluster-context cluster: repsys11c2n1-user-config.yaml
set-cluster-context context: tutorial
Switched to context "tutorial".

```

## 12. Verify that the configuration took effect by printing the current namespace

```bash
kubectl config view -o jsonpath="{.contexts[?(@.name==\"$(kubectl config current-context)\")].context.namespace}"

tutorial%                                                                                                                                                           
```
