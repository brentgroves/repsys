# **[SQL2019 Workshop](https://github.com/microsoft/sqlworkshops-sql2019workshop/blob/master/sql2019workshop/07_SQLOnKubernetes.md)**

## Deploying SQL Server on Kubernetes

Since SQL Server is a stateful container application it is a perfect fit to deploy and use on a Kubernetes platform.

## Activity: Deploying SQL Server on Kubernetes

In this activity you will learn the basics of how to deploy a SQL Server container in a Kubernetes cluster. You will learn various aspects of deploying in Kubernetes including common patterns such a namespace, node, pod, service, persistent volume claim, deployment, and ReplicaSet.

This activity is designed to be used with an Azure Kubernetes Service (AKS) cluster but most of the scripts and steps can be used with any Kubernetes cluster. This activity only requires a single-node Kubernetes cluster with only 6Gb RAM. Therefore this activity could be used even on a minikube cluster. While this module could be used on a RedHat OpenShift cluster you should use the workshop specifically designed for RedHat OpenShift at <https://github.com/Microsoft/sqlworkshops/tree/master/SQLonOpenShift>.

**NOTE: If at anytime during the Activities of this Module you need to "start over" you can run the script cleanup.ps1 or cleanup.sh and go back to the first Activity in 7.0 and run through all the steps again.

## Activity Steps

All scripts for this activity can be found in the sql2019workshop\07_SQLOnKubernetes\deploy folder.

There are two subfolders for scripts to be used in different shells:

powershell - Use scripts here for kubectl on Windows
bash - Use these scripts for kubectl on Linux or MacOS

## STEP 1: Connect to the cluster

```bash
scc.sh repsys11_sql_server.yaml microk8s
```

## STEP 2: Create a namespace

A Kubernetes namespace is a scope object to organize your Kubernetes deployment and objects from other deployments. Run the script step2_create_namespace.ps1 which runs the following command:

```bash
kubectl create namespace mssql
```

When this command completes you should see a message like

```namespace/mssql created```

## STEP 3: Set the default context

To now deploy in Kubernetes you can specify which namespace to use with parameters. But there is also a method to set the context to the new namespace.

```bash
scc.sh repsys11_sql_server.yaml mssql
```

## STEP 4: Create a Load Balancer Service

I created a nodeport service instead.
