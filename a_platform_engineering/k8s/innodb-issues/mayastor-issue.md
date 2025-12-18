# result of specifying the mayastor storage class

I am going to attempt to use the mayastor storage class by setting   storageClassName to mayastor according to the docs this is allowed but will mayastor be acceptable is the question.

Mayastor must have not been acceptable because the pvc got stuck in a pending state.

kubectl get pvc
NAME                  STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
test-pvc              Bound     pvc-f96f75e9-54d5-4b3d-8aba-02f63d33b008   5Gi        RWO            mayastor       18d
datadir-mycluster-0   Pending                                                                        mayastor       8m13s
datadir-mycluster-1   Pending                                                                        mayastor       8m13s
datadir-mycluster-2   Pending                                                                        mayastor       8m13s

kubectl describe pvc datadir-mycluster-0
Name:          datadir-mycluster-0
Namespace:     default
StorageClass:  mayastor
Status:        Pending
Volume:
Labels:        app.kubernetes.io/component=database
               app.kubernetes.io/created-by=mysql-operator
               app.kubernetes.io/instance=mysql-innodbcluster-mycluster-mysql-server
               app.kubernetes.io/managed-by=mysql-operator
               app.kubernetes.io/name=mysql-innodbcluster-mysql-server
               component=mysqld
               mysql.oracle.com/cluster=mycluster
               tier=mysql
Annotations:   volume.beta.kubernetes.io/storage-provisioner: io.openebs.csi-mayastor
               volume.kubernetes.io/selected-node: reports52
               volume.kubernetes.io/storage-provisioner: io.openebs.csi-mayastor
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:
Access Modes:  
VolumeMode:    Filesystem
Used By:       mycluster-0
Events:
  Type     Reason                Age                   From                                                                    Message
  ----     ------                ----                  ----                                                                    -------
  Normal   ExternalProvisioning  2m26s (x43 over 12m)  persistentvolume-controller                                             Waiting for a volume to be created either by the external provisioner 'io.openebs.csi-mayastor' or manually by the system administrator. If volume creation is delayed, please verify that the provisioner is running and correctly registered.
  Normal   Provisioning          79s (x11 over 12m)    io.openebs.csi-mayastor_reports54_ee63625f-f625-4086-8dfa-2da11dee2d74  External provisioner is provisioning volume for claim "default/datadir-mycluster-0"
  Warning  ProvisioningFailed    79s (x11 over 12m)    io.openebs.csi-mayastor_reports54_ee63625f-f625-4086-8dfa-2da11dee2d74  failed to provision volume with StorageClass "mayastor": rpc error: code = Internal desc = Operation failed: GenericOperation("error in response: status code '507 Insufficient Storage', content: 'RestJsonError { details: \"Operation failed due to insufficient resources: Not enough suitable pools available, 0/1\", message: \"SvcError :: NotEnoughResources\", kind: ResourceExhausted }'")
