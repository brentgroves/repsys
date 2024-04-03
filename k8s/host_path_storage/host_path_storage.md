# **[Host path storage](https://microk8s.io/docs/addon-hostpath-storage)**

## When to enable hostpath-storage

Since Observability and the Postgress operator currently, 4/2/2024, do not run from Mayastor I would enable it on all MicroK8s Clusters for now. If you will be using Mayastor for MySQL Server or InnoDB cluster you can include the Mayastor class name on the deployments.

## Notes

Noticed that only 2 of the 3 nodes has the "/var/snap/microk8s/common/default-storage" directory created. It does not seem to be a problem since the node without this directory seems to change.

```bash
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
