# **[Host path storage](https://microk8s.io/docs/addon-hostpath-storage)**

**[Report System Install](../report-system-install.md)**\
**[Current Status](../../development/status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## When to enable hostpath-storage

Since Observability and the Postgress operator currently, 4/2/2024, do not run from Mayastor I would enable it on all MicroK8s Clusters for now. If you will be using Mayastor for MySQL Server or InnoDB cluster you can include the Mayastor class name on the deployments.

## Notes

Noticed that only 2 of the 3 nodes has the "/var/snap/microk8s/common/default-storage" directory created. It does not seem to be a problem since the node without this directory seems to change.

```bash
# is it already installed?
microk8s status
microk8s is running
high-availability: no
  datastore master nodes: 127.0.0.1:19001
  datastore standby nodes: none
addons:
  enabled:
    dns                  # (core) CoreDNS
    ha-cluster           # (core) Configure high availability on the current node
    helm                 # (core) Helm - the package manager for Kubernetes
    helm3                # (core) Helm 3 - the package manager for Kubernetes
    hostpath-storage     # (core) Storage class; allocates storage from host directory
    rbac                 # (core) Role-Based Access Control for authorisation
    storage              # (core) Alias to hostpath-storage add-on, deprecated

# observability or postgres operator does not like mayastor but hostpath storage works
microk8s enable hostpath-storage
Infer repository core for addon hostpath-storage
Enabling default storage class.
WARNING: Hostpath storage is not suitable for production environments.
         A hostpath volume can grow beyond the size limit set in the volume claim manifest.

deployment.apps/hostpath-provisioner created
storageclass.storage.k8s.io/microk8s-hostpath created
serviceaccount/microk8s-hostpath created
clusterrole.rbac.authorization.k8s.io/microk8s-hostpath created
clusterrolebinding.rbac.authorization.k8s.io/microk8s-hostpath created
Storage will be available soon.
# look at directory used for storage on each node
ls -alh /var/snap/microk8s/common/default-storage
# notice that report31 does not have this directory but last time default storage was enabled it was reports32 which did not have the storage directory.

# list storage classes
kubectl get sc          
NAME                          PROVISIONER            RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
microk8s-hostpath (default)   microk8s.io/hostpath   Delete          WaitForFirstConsumer   false                  7m52s


```

## Verify

Create an example pod with a PVC, using the microk8s-hostpath storage class. Note that the microk8s-hostpath storage class is marked as default, so you do not have to specify a storageClassName for the PVC definition:

```bash
pushd .
cd ~/src/repsys/k8s/host_path_storage
kubectl apply -f pvc.yaml

# or
kubectl apply -f - <<EOF
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-pvc
spec:
  accessModes: [ReadWriteOnce]
  resources: { requests: { storage: 1Gi } }
---
apiVersion: v1
kind: Pod
metadata:
  name: test-nginx
spec:
  volumes:
    - name: pvc
      persistentVolumeClaim:
        claimName: test-pvc
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
      volumeMounts:
        - name: pvc
          mountPath: /usr/share/nginx/html
EOF
```

Then use microk8s kubectl get pod,pvc to verify that the volume and the container were successfully created:

```bash
kubectl get pod,pvc
NAME             READY   STATUS    RESTARTS   AGE
pod/test-nginx   1/1     Running   0          32s

NAME                             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS        AGE
persistentvolumeclaim/test-pvc   Bound    pvc-c48dbcc1-ca7e-482d-954f-b9e80119e438   1Gi        RWO            
```
