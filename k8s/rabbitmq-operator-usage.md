# **[Using Kubernetes RabbitMQ Cluster Kubernetes Operator](https://www.rabbitmq.com/kubernetes/operator/using-operator)**

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## references

- **[githug](https://github.com/rabbitmq/cluster-operator)**
- **[Install](https://www.rabbitmq.com/kubernetes/operator/install-operator)**
- **[Using Kubernetes RabbitMQ Cluster Kubernetes Operator](https://www.rabbitmq.com/kubernetes/operator/using-operator)**

## How to use the RabbitMQ Cluster Kubernetes Operator

Use this information to learn how to deploy custom resource objects that are then managed by the RabbitMQ Cluster Kubernetes Operator.

If the RabbitMQ Cluster Kubernetes Operator is not installed at this point, refer to installing the RabbitMQ Cluster Operator in a Kubernetes Cluster now. For instructions on getting started quickly, refer to the quickstart information.

This following information is structured into these sections:

- **[Confirm Service Availability](#confirm-service-availability)**
- **[Apply Pod Security Policies](#optional-apply-pod-security-policies)**
Create a RabbitMQ Instance
Existing examples
Configure a RabbitMQ Instance
Update a RabbitMQ Instance
Set a Pod Disruption Budget
Configure TLS
Find Your RabbitmqCluster Service Name and Admin Credentials
Use HashiCorp Vault
Verify the Instance is Running
Use the RabbitMQ Service in Your App
Monitor RabbitMQ Clusters
Restrict traffic using Network Policies
Delete a RabbitMQ Instance
Pause Reconciliation for a RabbitMQ Instance
Configure Log Level for the Operator

## Confirm Service Availability

Before configuring your app to use RabbitMQ Cluster Kubernetes Operator, ensure that RabbitmqCluster Custom Resource is deployed to your Kubernetes cluster and is available.

To confirm this availability, run

```bash
kubectl get customresourcedefinitions.apiextensions.k8s.io
NAME                                                  CREATED AT
bgpconfigurations.crd.projectcalico.org               2024-07-11T21:52:41Z
bgppeers.crd.projectcalico.org                        2024-07-11T21:52:42Z
blockaffinities.crd.projectcalico.org                 2024-07-11T21:52:42Z
...

# Then verify that rabbitmqclusters.rabbitmq.com is on the list, as in the example below:

kubectl get customresourcedefinitions.apiextensions.k8s.io
# NAME                                   CREATED AT
# rabbitmqclusters.rabbitmq.com   2019-10-23T10:11:06Z
...
rabbitmqclusters.rabbitmq.com                         2024-08-19T21:19:19Z
```

## (Optional) Apply Pod Security Policies

**Important NOTE**\
Pod Security Policies have been replaced with **[Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/)** an example can be found at **[Enforce Pod Security Standards with Namespace Labels](https://kubernetes.io/docs/tasks/configure-pod-container/enforce-standards-namespace-labels)**

If pod security policies are enabled in the Kubernetes cluster, a [Cluster]Role and [Cluster]RoleBinding must be created to enable the Pods to be scheduled. For more information about Pod security policies, see the Kubernetes documentation. If Role and RoleBinding are used, it will only be effective in the Namespace where the RBACs are deployed.

If Pod security policies are not enabled, skip to Create a RabbitMQ Instance below.

The Role and RoleBinding should be created before a RabbitmqCluster instance is created. It's ok to create a binding that refers to a non-existing Service Account or User. The Operator creates a Service Account using the pattern INSTANCE-NAME-server. For example, a RabbitmqCluster named 'mycluster' will generate a Service Account named mycluster-server. In order to allow a Service Account to use PSPs, a Role with the verb 'use' must be bound to the Service Account. For example:

```bash
# Assuming RabbitmqCluster name is 'mycluster'

kubectl create role rabbitmq:psp:unprivileged \
    --verb=use \
    --resource=podsecuritypolicy \
    --resource-name=some-pod-security-policy

# role "rabbitmq:psp:unprivileged" created

kubectl create rolebinding rabbitmq-mycluster:psp:unprivileged \
    --role=rabbitmq:psp:unprivileged \
    --serviceaccount=some-namespace:mycluster-server

# rolebinding "rabbitmq-mycluster:psp:unprivileged" created
```

**[Kubernetes documentation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#example)** has an example to create RBAC rules and a policy.

## Create a RabbitMQ Instance

To create a RabbitMQ instance, a RabbitmqCluster resource definition must be created and applied. RabbitMQ Cluster Kubernetes Operator creates the necessary resources, such as Services and StatefulSet, in the same namespace in which the RabbitmqCluster was defined.

First, create a YAML file to define a RabbitmqCluster resource named definition.yaml.
