<https://medium.com/@suyashmohan/setting-up-postgresql-database-on-kubernetes-24a2a192e962>

kubectl apply -f pvc.yaml
persistentvolume/mysql-reports51-pv created
persistentvolumeclaim/postgres-reports51-pvc created
kubectl apply -f configmap.yaml
configmap/postgres-configuration created
kubectl apply -f statefulset.yaml
statefulset.apps/postgres-statefulset created
kubectl get pvc
NAME                     STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS        AGE
test-pvc                 Bound    pvc-f96f75e9-54d5-4b3d-8aba-02f63d33b008   5Gi        RWO            mayastor            22d
datadir-mycluster-0      Bound    pvc-ba54b58a-d21d-440a-855b-0fe1f7008f15   40Gi       RWO            microk8s-hostpath   25h
datadir-mycluster-1      Bound    pvc-6c0a8851-670c-4f5f-a136-8b967631a883   40Gi       RWO            microk8s-hostpath   25h
datadir-mycluster-2      Bound    pvc-9483d2f1-8f60-4822-aa48-0e2659fb43e3   40Gi       RWO            microk8s-hostpath   25h
postgres-reports51-pvc   Bound    mysql-reports51-pv                         1Gi        RWO            microk8s-hostpath   5m1s
kubectl get pods
NAME                                READY   STATUS              RESTARTS   AGE
postgres-statefulset-0              0/1     ContainerCreating   0          64s
