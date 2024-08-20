# **[RabitMQ Install](https://www.rabbitmq.com/kubernetes/operator/operator-overview)**

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## references

- **[githug](https://github.com/rabbitmq/cluster-operator)**
- **[Install](https://www.rabbitmq.com/kubernetes/operator/install-operator)**
- **[Using Kubernetes RabbitMQ Cluster Kubernetes Operator](https://www.rabbitmq.com/kubernetes/operator/using-operator)**

## **[Installing RabbitMQ Cluster Operator in a Kubernetes Cluster](https://www.rabbitmq.com/kubernetes/operator/install-operator)**

This guide covers the installation of the RabbitMQ Cluster Kubernetes Operator in a Kubernetes cluster.

## Compatibility

The Operator requires

- Kubernetes 1.19 or later (1.25 or later versions are recommended, in particular for environments that use RabbitMQ Streams)
- **[RabbitMQ DockerHub image](https://hub.docker.com/_/rabbitmq)** that provides a **[supported release series of RabbitMQ](https://www.rabbitmq.com/release-information)**

Installation
To install the Operator, run the following command:

```bash
pushd
cd ~//src/repsys/k8s/rabbitmq
kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
# or you can download it first
curl -L -O https://github.com/rabbitmq/cluster-operator/releases/download/v2.9.0/cluster-operator.yml
kubectl apply -f cluster-operator.yml
# namespace/rabbitmq-system created
# customresourcedefinition.apiextensions.k8s.io/rabbitmqclusters.rabbitmq.com created
# serviceaccount/rabbitmq-cluster-operator created
# role.rbac.authorization.k8s.io/rabbitmq-cluster-leader-election-role created
# clusterrole.rbac.authorization.k8s.io/rabbitmq-cluster-operator-role created
# rolebinding.rbac.authorization.k8s.io/rabbitmq-cluster-leader-election-rolebinding created
# clusterrolebinding.rbac.authorization.k8s.io/rabbitmq-cluster-operator-rolebinding created
# deployment.apps/rabbitmq-cluster-operator created
```

At this point, the RabbitMQ Cluster Kubernetes Operator is successfully installed. Once the RabbitMQ Cluster Kubernetes Operator pod is running, head over to **[Using Kubernetes RabbitMQ Cluster Kubernetes Operator](https://www.rabbitmq.com/kubernetes/operator/using-operator)**
)** for instructions on how to deploy RabbitMQ using a Kubernetes Custom Resource.

If you want to install a specific version of the Operator, you will have to obtain the manifest link from the Operator Releases. Please note that releases prior to 0.46.0 do not have this manifest. We strongly recommend to install versions 0.46.0+

If you want to relocate the Operator image to a custom location, the section Relocate the Image has instructions to relocate the Operator image to a private registry.

## Installation using kubectl-rabbitmq plugin

The kubectl rabbitmq plugin provides commands for managing RabbitMQ clusters. The plugin can be installed using krew:

```bash
# To remove this plugin
kubectl krew remove rabbitmq
kubectl krew install rabbitmq
Installing plugin: rabbitmq
Installed plugin: rabbitmq
\
 | Use this plugin:
 |      kubectl rabbitmq
 | Documentation:
 |      https://github.com/rabbitmq/cluster-operator
 | Caveats:
 | \
 |  | This plugin requires the RabbitMQ cluster operator to be installed.
 |  | To install the RabbitMQ cluster operator run `kubectl rabbitmq install-cluster-operator`.
 |  | 
 |  | `tail` subcommand requires the `tail` plugin. You can install it with `kubectl krew install tail`.
 | /
/
WARNING: You installed plugin "rabbitmq" from the krew-index plugin repository.
   These plugins are not audited for security by the Krew maintainers.
   Run them at your own risk.

# To get the list of available commands, use:

# USAGE:
#   Install RabbitMQ Cluster Operator (optionally provide image to use a relocated image or a specific version)
#     kubectl rabbitmq install-cluster-operator [IMAGE]
# [...]
kubectl rabbitmq install-cluster-operator
# namespace/rabbitmq-system created
# customresourcedefinition.apiextensions.k8s.io/rabbitmqclusters.rabbitmq.com created
# serviceaccount/rabbitmq-cluster-operator created
# role.rbac.authorization.k8s.io/rabbitmq-cluster-leader-election-role created
# clusterrole.rbac.authorization.k8s.io/rabbitmq-cluster-operator-role created
# rolebinding.rbac.authorization.k8s.io/rabbitmq-cluster-leader-election-rolebinding created
# clusterrolebinding.rbac.authorization.k8s.io/rabbitmq-cluster-operator-rolebinding created
# deployment.apps/rabbitmq-cluster-operator created


```

## RabbitMQ Kubernetes Operators: Cluster Operator and Messaging Topology Operator

The RabbitMQ team develop and maintain two **[Kubernetes operators](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/)**: the RabbitMQ Cluster Kubernetes Operator and the RabbitMQ Messaging Topology Operator.

- The RabbitMQ Cluster Kubernetes Operator automates provisioning, management, and operations of RabbitMQ clusters running on Kubernetes.

- The RabbitMQ Messaging Topology Operator manages RabbitMQ messaging topologies within a RabbitMQ cluster deployed via the RabbitMQ Cluster Kubernetes Operator.

Kubernetes Operators are software extensions to Kubernetes that provide custom resources for management of applications, services and their components.

In this information and other Operator related information, "Operator" (with a capital O) is used to refer to a Kubernetes Operator pattern implementation and "operator" (with a lowercase o) is used to refer to a technical operations engineer (administrator).

## RabbitMQ Cluster Kubernetes Operator

The RabbitMQ Cluster Kubernetes Operator provides a consistent and easy way to deploy RabbitMQ clusters to Kubernetes and run them, including "day two" (continuous) operations. RabbitMQ clusters deployed using the Operator can be used by applications running on Kubernetes or outside of Kubernetes.

## Documentation of Cluster Operator spans several guides

- Limitations
- Quickstart guide for RabbitMQ Cluster Kubernetes Operator
- Installing RabbitMQ Cluster Kubernetes Operator
- Configuring Defaults for RabbitMQ Cluster Operator
- RabbitMQ Plugin for kubectl
- Using RabbitMQ Cluster Kubernetes Operator
- Monitoring RabbitMQ Clusters on Kubernetes
- Troubleshooting RabbitMQ Clusters on Kubernetes
- Upgrading the RabbitMQ Kubernetes Operators
- Using the RabbitMQ Kubernetes Operators on Openshift

In addition, a separate Operator for managing cluster objects collectively known as the messaging topology: virtual hosts, user, queues, etc. It is covered in the following guides:

- Installing RabbitMQ Messaging Topology Operator
- Using RabbitMQ Messaging Topology Operator
- Using TLS with Messaging Topology Kubernetes Operator
- Troubleshooting Messaging Topology Kubernetes Operator

## The Operator provides the following key features

- Provisioning of single-node and multi-node RabbitMQ clusters
- Automatic reconciliation of deployed clusters whenever their actual state does not match the expected state
- Monitoring of RabbitMQ clusters using Prometheus and Grafana
- Scaling up and automated rolling upgrades of RabbitMQ clusters

## RabbitMQ Cluster Kubernetes Operator Design Principles

RabbitMQ Cluster Kubernetes Operator was designed with the following ideas and concepts in mind:

- It should provide RabbitMQ node configuration flexibility
- It should provide reasonably safe defaults where possible
- It should simplify RabbitMQ operations

Following these ideas, the Operator will not modify an existing RabbitmqCluster spec. This implies that, when the Operator is upgraded, it will not automatically update existing instances of RabbitmqCluster with new defaults, if any, or to the latest version of RabbitMQ.

The only exception to this, is when a field is removed from the spec, by user action, the Operator will set the default value.

## Limitations of RabbitMQ Cluster Operator Reconciliation

Deleted Secret objects will be recreated by the Kubernetes Operator but the newly generated secret value will not be deployed to the RabbitMQ cluster. For example, if the Secret with administrator credentials is deleted, a new Secret will be created with new username and password, but those will not be reflected in the RabbitMQ cluster. It works the same way for any Secret value, e.g. the value of the shared inter-node authentication secret known as the Erlang cookie.

## RabbitMQ Cluster Operator Feature Flags

Cluster Operator does not support disabling any RabbitMQ feature flags. The Operator lists all available feature flags and enables all of them at cluster start.

## RabbitMQ Messaging Topology Operator

The RabbitMQ Messaging Topology Operator supports managing RabbitMQ messaging topologies objects through the kubernetes declarative API.

Documentation for the Messaging Topology Operator is structured as follows:

Limitations
Installing RabbitMQ Messaging Topology Operator
Using RabbitMQ Messaging Topology Operator
TLS for Messaging Topology Operator
Troubleshooting Messaging Topology Operator
Limitations
Custom default credentials result in 401 unauthorised
The Topology Operator relies on the default credentials Secret created by the Cluster Operator. If the RabbitmqCluster spec defines the default user in additionalConfig using the keys default_user and default_pass, it will result in incorrect credentials generated for the default credentials Secret. Due to the incorrect credentials, all operations from the Topology Operator will error and print the following message in the log:

Error: API responded with a 401 Unauthorized

See the troubleshooting Messaging Topology Operator section for more details and a workaround.

The Source Code for these Kubernetes Operators
Both Operators are open source. You can contribute to its development on GitHub:

RabbitMQ Cluster Kubernetes Operator
RabbitMQ Messaging Topology Operator
The Licenses for these Kubernetes Operators
Both Operators are released under the Mozilla Public License 2.0.

Supported Kubernetes Versions
RabbitMQ Operators are intended to be used with any Kubernetes-compliant platform. If you encounter an issue with a particular distribution of Kubernetes, please check for known issues in the GitHub repo.

For more information on which Kubernetes & RabbitMQ server versions are supported by the Operator, please consult the README.
