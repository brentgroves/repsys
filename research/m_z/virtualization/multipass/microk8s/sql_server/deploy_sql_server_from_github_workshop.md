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

Deploy objects in Kubernetes is done in a declarative fashion. One of the key objects to create is a LoadBalancer service which is supported by default in Azure Kubernetes Service (AKS). A LoadBalancer provides a static public IP address mapped to a public IP address in Azure. You will be able to map the LoadBalancer to a SQL Server deployment including a port to map to the SQL Server port 1433. Non-cloud Kubernetes clusters also support a similar concept called a NodePort.
I created a nodeport service instead.

**[port/targetport/nodeport](<https://www.bmc.com/blogs/kubernetes-port-targetport-nodeport/>**

- **Port** exposes the Kubernetes service on the specified port within the cluster. Other pods within the cluster can communicate with this server on the specified port.
- **TargetPort** is the port on which the service will send requests to, that your pod will be listening on. Your application in the container will need to be listening on this port also.
- **NodePort** exposes a service externally to the cluster by means of the target nodes IP address and the NodePort. NodePort is the default setting if the port field is not specified.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mssql-service
spec:
  selector:
    app: mssql
  ports:
    - protocol: TCP
      port: 31433
      targetPort: 1433
  type: LoadBalancer
```

This is the nodeport that created:

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: mssql-service
  namespace: mssql
spec:
  type: NodePort
  selector:
    app: mssql
  ports:
  - protocol: TCP
    # NodePort exposes a service externally to the cluster by means of
    # the target nodes IP address and the NodePort. NodePort is the default setting if the port field is not specified.
    nodePort: 31433
    # Port exposes the Kubernetes service on the specified port within the cluster. Other pods within 
    # the cluster can communicate with this server on the specified port.
    port: 1433
    targetPort: 1433
    # TargetPort is the port on which the service will send requests to, that your pod will be listening on. Your application 
    # in the container will need to be listening on this port also.
```

```bash
pushd .
cd ~/src/repsys/k8s/sql_server/
kubectl apply -f nodeport.yaml
kubectl get all               
NAME                    TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/mssql-service   NodePort   10.152.183.235   <none>        1433:31433/TCP   4s
```

## STEP 5: **[Create a secret](https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kubectl/)** to hold the sa password

**[Important](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-kubernetes-best-practices-statefulsets?view=sql-server-ver16)** The SA_PASSWORD environment variable is deprecated. Use MSSQL_SA_PASSWORD instead.

In order to use a password to connect to SQL Server, Kubernetes provides an object called a secret. Use the script step5_create_secret.ps1 to create the secret which runs the following command: (You are free to change the password but you will need to use the new password later in this Activity to connect to SQL Server)

kubectl create secret generic mssql-secret --from-literal=SA_PASSWORD="Sql2019isfast"
The name of the secret is called mssql-secret which you will need when deploying a pod later in this Activity.

When this command completes you should see the following message:

secret/mssql-secret created
You cannot retrieve the plaintext of the password from the secret later so you need to remember this password.

I created the secret by doing this:

```bash
pushd .
cd ~/src/k8s/repsys/namespaces/mssql/
kubectl apply -f credentials.yaml 
kubectl get secret credentials -o jsonpath='{.data.password2}' | base64 --decode
```
