# Install MySQL stateful-set

## reference

- **[Mongo Istio Gateway](https://istio.io/latest/docs/reference/config/networking/gateway/)**
- **[MySQL Protocol](https://istio.io/latest/docs/ops/configuration/traffic-management/protocol-selection/)**
- **[mysql version comparison](https://www.percona.com/blog/mysql-8-0-vs-5-7-are-the-newer-versions-more-problematic/#:~:text=What%20are%20the%20main%20differences,security%20features%2C%20and%20new%20functionalities.)**
- **[mysql replicated stateful set](https://kubernetes.io/docs/tasks/run-application/run-replicated-stateful-application/)**
- **[mysql k8s install](https://kubernetes.io/docs/tasks/run-application/run-single-instance-stateful-application/)**
- **[k8s book](https://livebook.manning.com/book/kubernetes-in-action/chapter-10/7)**
- **[stateful set](https://www.howtoforge.com/create-a-statefulset-in-kubernetes/)**

## remove mysql deployment

```bash
az login
scc.sh aks_repsys1.yaml repsys1
pushd .
cd  ~/src/repsys/k8s/mysql_statefulset/azure
kubectl config set-context $(kubectl config current-context) --namespace=mysql
kubectl delete -f stateful-set.yaml
kubectl delete pvc mysql-pvc
kubectl delete pv mysql-pv
kubectl delete -f mysql-retain.yaml
```

## login to k8s node to install mysql

```bash
az login
scc.sh aks_repsys1.yaml repsys1
pushd .
cd  ~/src/repsys/k8s/mysql_statefulset/azure
kubectl config set-context $(kubectl config current-context) --namespace=mysql
```

## make the backup directory if needed

```bash
mkdir -p ~/backups/repsys1/mysql
sudo chmod 777 ~/backups
```

## Make a fresh backup of mysql dw if needed

```bash
mysqldump -u root -p -h reports31 --port=30031 --column-statistics=0 --add-drop-table --routines --all-databases > /home/brent/backups/reports31/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

```

## Create in mysql namespace

```bash
az login
scc.sh aks_repsys1.yaml repsys1
pushd .
cd  ~/src/repsys/k8s/mysql_statefulset/azure
kubectl config set-context $(kubectl config current-context) --namespace=mysql
kubectl create ns mysql
kubectl config set-context $(kubectl config current-context) --namespace=mysql
```

## Create a StorageClass

StorageClass helps pods provision persistent volume claims on the node.

```bash
az login
scc.sh aks_repsys1.yaml repsys1
pushd .
cd  ~/src/repsys/k8s/mysql_statefulset/azure
kubectl config set-context $(kubectl config current-context) --namespace=mysql
kubectl apply -f mysql_retain.yaml
kubectl get storageclass
kubectl describe sc mysql-retain
```

## create persistent persistent volume claim

```bash
az login
scc.sh aks_repsys1.yaml repsys1
pushd .
cd  ~/src/repsys/k8s/mysql_statefulset/azure
kubectl config set-context $(kubectl config current-context) --namespace=mysql
# https://medium.com/@bingorabbit/mux-propagate-to-all-panes-9d2bfb969f01 
# create persistent volume
kubectl apply -f volume.yaml
kubectl describe pvc mysql-pvc
```

## create the stateful set

The headless Service provides a home for the DNS entries that the StatefulSet controllers creates for each Pod that's part of the set. Because the headless Service is named mysql, the Pods are accessible by resolving <pod-name>.mysql from within any other Pod in the same Kubernetes cluster and namespace.

The client Service, called mysql-read, is a normal Service with its own cluster IP that distributes connections across all MySQL Pods that report being Ready. The set of potential endpoints includes the primary MySQL server and all replicas.

Note that only read queries can use the load-balanced client Service. Because there is only one primary MySQL server, clients should connect directly to the primary MySQL Pod (through its DNS entry within the headless Service) to execute writes.

```bash
kubectl apply -f stateful-set.yaml

kubectl describe svc mysql
kubectl describe statefulset mysql

# validation

kubectl exec statefulset/mysql -it -- /bin/bash
mysql -u root -ppassword

## restore datbases from a backup

```bash
mysql -u root -p -h repsys11_c2_n1 --port=30031 < ~/backups/reports31/mysql/2024-07-16-17:57:41.sql.bak
```

## Istio Gateway

```bash
kubectl get gateway.networking.istio.io --all-namespaces
NAMESPACE   NAME                        AGE
default     bookinfo-gateway            66d
default     bookinfo-gateway-external   70d
default     mygateway                   38d

 kubectl describe gateway.networking.istio.io mygateway -n default
Name:         mygateway
Namespace:    default
Labels:       <none>
Annotations:  <none>
API Version:  networking.istio.io/v1
Kind:         Gateway
Metadata:
  Creation Timestamp:  2024-11-20T22:11:29Z
  Generation:          2
  Resource Version:    12152784
  UID:                 2357d740-214a-485c-8a6f-ade3e500400e
Spec:
  Selector:
    Istio:  aks-istio-ingressgateway-external
  Servers:
    Hosts:
      httpbin.linamar.com
      repsys.linamar.com
      requester.linamar.com
      helloworld.linamar.com
      bookinfo.linamar.com
    Port:
      Name:      https
      Number:    443
      Protocol:  HTTPS
    Tls:
      Credential Name:  linamar-credential
      Mode:             MUTUAL
Events:                 <none>
```

## **[MySQL Protocol](https://istio.io/latest/docs/ops/configuration/traffic-management/protocol-selection/)**
