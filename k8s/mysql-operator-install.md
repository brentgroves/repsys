# **[MySQL operator install](https://dev.mysql.com/doc/mysql-operator/en/)**

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## references

<https://dev.mysql.com/doc/mysql-operator/en/>

## prerequisites

```bash
# Make sure hostpath storage is enabled
microk8s enable hostpath-storage
```

## **[Chapter 2 Installing MySQL Operator for Kubernetes](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-installation.html)**

Table of Contents

2.1 Install using Helm Charts
2.2 Install using Manifest Files
Two different installation methods are documented here; using either helm or manually applying manifests using kubectl. This documentation assumes that kubectl is available on a system configured with the desired Kubernetes context; and all examples use a Unix-like command line.

MySQL Operator for Kubernetes functions with Kubernetes 1.21 and newer.

Note
MySQL Operator for Kubernetes requires these three container images to function: MySQL Operator for Kubernetes, MySQL Router, and MySQL Server.

## delete MySQL Operator

```bash
kubectl get all -n mysql-operator
kubectl delete deployment mysql-operator -n mysql-operator
kubectl get all -n mysql-operator

```

## What is the MySQL Operator

MySQL Operator for Kubernetes
The MySQL Operator for Kubernetes is an operator focused on managing one or more MySQL InnoDB Clusters consisting of a group of MySQL Servers and MySQL Routers. The MySQL Operator itself runs in a Kubernetes cluster and is controlled by a Kubernetes Deployment to ensure that the MySQL Operator remains available and running.

The MySQL Operator is deployed in the 'mysql-operator' Kubernetes namespace by default; and watches all InnoDB Clusters and related resources in the Kubernetes cluster. To perform these tasks, the operator subscribes to the Kubernetes API server to update events and connects to the managed MySQL Server instance as needed. On top of the Kubernetes controllers, the operator configures the MySQL servers, replication using MySQL Group Replication, and MySQL Router.

**![MySQL Operator Architecture](https://dev.mysql.com/doc/mysql-operator/en/images/mysql-operator-architecture.png)**

## Install using Manifest Files

<https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-installation-kubectl.html>

This document assumes a familiarity with kubectl, and that you have it installed. Alternatively, see Section 2.1, “Install using Helm Charts”.

MySQL Operator for Kubernetes can be installed using raw manifest files with kubectl.

Note
Using trunk in the URL references the latest MySQL Operator for Kubernetes release because Github is updated at release time. Alternatively, replace trunk in the URL with a specific tagged released version.

First install the Custom Resource Definition (CRD) used by MySQL Operator for Kubernetes:

```bash
kubectl apply -f https://raw.githubusercontent.com/mysql/mysql-operator/trunk/deploy/deploy-crds.yaml
customresourcedefinition.apiextensions.k8s.io/innodbclusters.mysql.oracle.com created
customresourcedefinition.apiextensions.k8s.io/mysqlbackups.mysql.oracle.com created
customresourcedefinition.apiextensions.k8s.io/clusterkopfpeerings.zalando.org created
customresourcedefinition.apiextensions.k8s.io/kopfpeerings.zalando.org created

# Next deploy MySQL Operator for Kubernetes, which also includes RBAC definitions as noted in the output:


kubectl apply -f https://raw.githubusercontent.com/mysql/mysql-operator/trunk/deploy/deploy-operator.yaml
clusterrole.rbac.authorization.k8s.io/mysql-operator created
clusterrole.rbac.authorization.k8s.io/mysql-sidecar created
clusterrolebinding.rbac.authorization.k8s.io/mysql-operator-rolebinding created
clusterkopfpeering.zalando.org/mysql-operator created
namespace/mysql-operator created
serviceaccount/mysql-operator-sa created
deployment.apps/mysql-operator created

# Verify that the operator is running by checking the deployment that is managing the operator inside the mysql-operator namespace, a configurable namespace defined by deploy-operator.yaml:

```bash
kubectl get deployment mysql-operator --namespace mysql-operator
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
mysql-operator   1/1     1            1           2m19s

# check all
kubectl get all -n mysql-operator
NAME                                  READY   STATUS    RESTARTS   AGE
pod/mysql-operator-78688bfb4b-52lh6   1/1     Running   0          59s

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mysql-operator   1/1     1            1           59s

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/mysql-operator-78688bfb4b   1         1         1       59s

# A ReplicaSet (RS) is a Kubernetes object that ensures there is always a stable set of running pods for a specific workload. The ReplicaSet configuration defines a number of identical pods required, and if a pod is evicted or fails, creates more pods to compensate for the loss.

# Verify that the operator is running by checking the deployment that's managing the operator inside the mysql-operator namespace, a configurable namespace defined by deploy-operator.yaml:


# After MySQL Operator for Kubernetes is ready, the output should look similar to this:

NAME             READY   UP-TO-DATE   AVAILABLE   AGE
mysql-operator   1/1     1            1           37s

# version check

kubectl describe deployment mysql-operator --namespace mysql-operator

Name:                   mysql-operator
Namespace:              mysql-operator
CreationTimestamp:      Mon, 23 Dec 2024 15:35:39 -0500
Labels:                 app.kubernetes.io/component=controller
                        app.kubernetes.io/created-by=mysql-operator
                        app.kubernetes.io/instance=mysql-operator
                        app.kubernetes.io/managed-by=mysql-operator
                        app.kubernetes.io/name=mysql-operator
                        app.kubernetes.io/version=9.1.0-2.2.2
                        version=1.0
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               name=mysql-operator
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:           name=mysql-operator
  Service Account:  mysql-operator-sa
  Containers:
   mysql-operator:
    Image:      container-registry.oracle.com/mysql/community-operator:9.1.0-2.2.2
    Port:       <none>
    Host Port:  <none>
    Args:
      mysqlsh
      --log-level=@INFO
      --pym
      mysqloperator
      operator
    Readiness:  exec [cat /tmp/mysql-operator-ready] delay=1s timeout=1s period=3s #success=1 #failure=3
    Environment:
      MYSQLSH_USER_CONFIG_HOME:                 /mysqlsh
      MYSQLSH_CREDENTIAL_STORE_SAVE_PASSWORDS:  never
    Mounts:
      /mysqlsh from mysqlsh-home (rw)
      /tmp from tmpdir (rw)
  Volumes:
   mysqlsh-home:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
   tmpdir:
    Type:          EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:        
    SizeLimit:     <unset>
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   mysql-operator-575fb64d89 (1/1 replicas created)
Events:          <none>

```

## **[Router and Server Versions and Instances](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-innodbcluster-common.html)**

By default, MySQL Operator for Kubernetes installs MySQL Server with the same version as the Operator, and installs Router with the same version as MySQL Server. It also installs 3 MySQL instances and 1 Router instance by default. Optionally configure each:

```yaml
spec:
  instances: 3
  version: 9.1.0
  router:
    instances: 1
    version: 9.1.0
```
