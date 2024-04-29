# Default storage class

## My experiences

Once I enabled the observability add-on MicroK8s installed the microk8s-hostpath storage class and set it to default also ignoring the mayastor default storage. Now I have two default storage classes and according to the docs <https://kubernetes.io/docs/concepts/storage/storage-classes/>: "If more than one default StorageClass is accidentally set, the newest default is used when the PVC is dynamically provisioned." I presume the Mayastor storage class was not acceptable to the observability add-on so it enabled and set as default the microk8s-hostpath storage class.

kubectl get sc
NAME                          PROVISIONER               RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
mayastor-3                    io.openebs.csi-mayastor   Delete          WaitForFirstConsumer   false                  18d
mayastor-2                    io.openebs.csi-mayastor   Delete          WaitForFirstConsumer   false                  18d
mayastor (default)            io.openebs.csi-mayastor   Delete          WaitForFirstConsumer   false                  18d
microk8s-hostpath (default)   microk8s.io/hostpath      Delete          WaitForFirstConsumer   false                  6d22h

## Set default storage class

<https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/>

Changing the default StorageClass
List the StorageClasses in your cluster:

kubectl get storageclass
The output is similar to this:

NAME                 PROVISIONER               AGE
standard (default)   kubernetes.io/gce-pd      1d
gold                 kubernetes.io/gce-pd      1d
The default StorageClass is marked by (default).

Mark the default StorageClass as non-default:

The default StorageClass has an annotation storageclass.kubernetes.io/is-default-class set to true. Any other value or absence of the annotation is interpreted as false.

To mark a StorageClass as non-default, you need to change its value to false:

kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
where standard is the name of your chosen StorageClass.

kubectl patch storageclass microk8s-hostpath -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

kubectl patch storageclass mayastor -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

Mark a StorageClass as default:

Similar to the previous step, you need to add/set the annotation storageclass.kubernetes.io/is-default-class=true.

kubectl patch storageclass gold -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

kubectl patch storageclass microk8s-hostpath -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

Please note that at most one StorageClass can be marked as default. If two or more of them are marked as default, a PersistentVolumeClaim without storageClassName explicitly specified cannot be created.

Verify that your chosen StorageClass is default:

kubectl get storageclass
The output is similar to this:

## PVC

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pv-claim
spec:
  storageClassName: base
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi
