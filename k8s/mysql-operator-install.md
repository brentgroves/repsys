# **[MySQL operator install](https://dev.mysql.com/doc/mysql-operator/en/)**

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## **[Issue](https://github.com/canonical/microk8s/issues/4864)**

**[microk8s refresh certs](https://www.davidpuplava.com/coding-craft/kubernetes-refresh-certs-with-microk8s-cluster)**

```bash
kubectl get all --namespace mysql-operator                            
NAME                                  READY   STATUS             RESTARTS        AGE
pod/mysql-operator-7cbc8bd94d-v2n9k   0/1     CrashLoopBackOff   8 (3m10s ago)   27m

kubectl logs mysql-operator-7cbc8bd94d-v2n9k --namespace=mysql-operator
[2025-04-01 22:22:07,482] kopf._core.reactor.o [ERROR   ] Request attempt #8/9 failed; will retry: GET <https://10.152.183.1:443/apis> -> ClientConnectorCertificateError(ConnectionKey(host='10.152.183.1', port=443, is_ssl=True, ssl=True, proxy=None, proxy_auth=None, proxy_headers_hash=None), SSLCertVerificationError(1, '[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: CA cert does not include key usage extension (_ssl.c:1020)'))
```

Temp Resolve: In case anyone else hits this, I resolved it by creating and installing a CA:

```bash
mkdir cadir
openssl genrsa -out cadir/ca.key 2048
openssl req -x509 -new -nodes -key ca.key -sha256 -days 360 -out cadir/ca.crt -addext "keyUsage=critical,digitalSignature,keyCertSign"
microk8s.refresh-certs cadir
```

kubectl describe pod/mysql-operator-7cbc8bd94d-v2n9k -n mysql-operator
...
  Normal   Scheduled  7m45s                  default-scheduler  Successfully assigned mysql-operator/mysql-operator-7cbc8bd94d-v2n9k to k8sn211
  Warning  Unhealthy  7m43s (x2 over 7m44s)  kubelet            Readiness probe failed: cat: /tmp/mysql-operator-ready: No such file or directory
  Warning  Unhealthy  5m49s                  kubelet            Readiness probe errored: rpc error: code = Unknown desc = failed to exec in container: container is in CONTAINER_EXITED state
  Warning  BackOff    4m23s (x5 over 5m49s)  kubelet            Back-off restarting failed container mysql-operator in pod mysql-operator-7cbc8bd94d-v2n9k_mysql-operator(139bb71b-9c59-4174-af8e-135d5caabd07)

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
kubectl get all -n mysql-operator

NAME                                  READY   STATUS         RESTARTS   AGE
pod/mysql-operator-7cbc8bd94d-jqzb6   0/1     ErrImagePull   0          45s

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
