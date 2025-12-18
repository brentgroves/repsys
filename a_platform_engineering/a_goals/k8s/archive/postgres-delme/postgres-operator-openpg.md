This section describes how to test a PostgreSQL cluster on your laptop/computer using CloudNativePG on a local Kubernetes cluster in Kind or Minikube.

!!! Warning The instructions contained in this section are for demonstration, testing, and practice purposes only and must not be used in production.

Like any other Kubernetes application, CloudNativePG is deployed using regular manifests written in YAML.

By following the instructions on this page you should be able to start a PostgreSQL cluster on your local Kubernetes installation and experiment with it.

!!! Important Make sure that you have kubectl installed on your machine in order to connect to the Kubernetes cluster. Please follow the Kubernetes documentation on how to install kubectl.

The operator can be installed like any other resource in Kubernetes, through a YAML manifest applied via kubectl.

You can install the latest operator manifest for this minor release as follows:

kubectl apply -f \
  <https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.21/releases/cnpg-1.21.0.yaml>

  namespace/cnpg-system created
customresourcedefinition.apiextensions.k8s.io/backups.postgresql.cnpg.io created
customresourcedefinition.apiextensions.k8s.io/clusters.postgresql.cnpg.io created
customresourcedefinition.apiextensions.k8s.io/poolers.postgresql.cnpg.io created
customresourcedefinition.apiextensions.k8s.io/scheduledbackups.postgresql.cnpg.io created
serviceaccount/cnpg-manager created
clusterrole.rbac.authorization.k8s.io/cnpg-manager created
clusterrolebinding.rbac.authorization.k8s.io/cnpg-manager-rolebinding created
configmap/cnpg-default-monitoring created
service/cnpg-webhook-service created
deployment.apps/cnpg-controller-manager created
mutatingwebhookconfiguration.admissionregistration.k8s.io/cnpg-mutating-webhook-configuration created
validatingwebhookconfiguration.admissionregistration.k8s.io/cnpg-validating-webhook-configuration created

kubectl get deployment -n cnpg-system cnpg-controller-manager

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
cnpg-controller-manager   1/1     1            1           34s

Using the cnpg plugin for kubectl
You can use the cnpg plugin to override the default configuration options that are in the static manifests.

For example, to generate the default latest manifest but change the watch namespaces to only be a specific namespace, you could run:

kubectl cnpg install generate \
  --watch-namespaces "specific-namespace" \
  > cnpg_for_specific_namespace.yaml

# create cluster

<https://github.com/cloudnative-pg/cloudnative-pg/blob/main/docs/src/quickstart.md>
kubectl apply -f cluster-example.yaml
cluster.postgresql.cnpg.io/cluster-example created
cluster-example-1-initdb-r75j2          0/1     Error             0          44s
cluster-example-1-initdb-pgqmb          0/1     PodInitializing   0          2s
