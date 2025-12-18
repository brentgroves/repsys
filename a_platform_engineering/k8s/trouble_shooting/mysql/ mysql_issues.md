# **[MySQL Issues](https://docs.oracle.com/en/cloud/iaas/verrazzano/vzdoc/docs/troubleshooting/troubleshooting-mysql/#:~:text=MySQL%20pod%20stuck%20Terminating,-A%20MySQL%20pod&text=This%20may%20occur%20while%20upgrading,the%20pod%20never%20finishes%20terminating.&text=You%20can%20repair%20this%20issue%20by%20restarting%20the%20mysql%2Doperator%20pod.)**
Troubleshoot MySQL issues
There are known issues that can occur with MySQL. The Verrazzano platform operator will automatically detect each of the described issues and perform actions to repair them. The operator initiates a repair within a few minutes of detecting an issue.

The following sections are provided in the event that a manual repair of an issue is required.

MySQL pod stuck Terminating
A MySQL pod may get stuck in a terminating state. This may occur while upgrading the nodes of a Kubernetes cluster.

Here is an example of what this condition looks like. All the pod containers are terminated, but the pod never finishes terminating.
CopyCopyCopyCopyCopyCopyCopyCopy
$ kubectl get pods -n keycloak -l component=mysqld
NAME      READY   STATUS        RESTARTS   AGE
mysql-0   0/3     Terminating   0          60m
You can repair this issue by restarting the mysql-operator pod.
CopyCopyCopyCopyCopyCopyCopy
$ kubectl delete pod -l name=mysql-operator -n mysql-operator
MySQL pod waiting for readiness gates
The mysql StatefulSet may get stuck while waiting to reach the ready state. This will occur when one or more MySQL pods not meeting its set of ReadinessGates.

Here is an example of what this condition looks like.
CopyCopyCopyCopyCopyCopy
$ kubectl describe pods -n keycloak -l component=mysqld
# Excerpt from the command output
Readiness Gates:
  Type                          Status
  mysql.oracle.com/configured   False
  mysql.oracle.com/ready        True
You can repair this issue by restarting the mysql-operator pod.
CopyCopyCopyCopyCopy
$ kubectl delete pod -l name=mysql-operator -n mysql-operator
MySQL router pod in CrashLoopBackOff state
Here is an example of what this condition looks like.
CopyCopyCopyCopy
$ kubectl get pods -n keycloak -l component=mysqlrouter
NAME                            READY   STATUS             RESTARTS   AGE
mysql-router-757595f6c5-pdgxj   1/2     CrashLoopBackOff   0          109m
You can repair this issue by deleting the pod that is in the CrashLoopBackOff state.
CopyCopyCopy
$ kubectl delete pod -n keycloak mysql-router-757595f6c5-pdgxj
InnoDBCluster object stuck Terminating
This condition has been observed to occur on an uninstallation of Verrazzano.

Here is an example of what this condition looks like.
CopyCopy
$ kubectl get InnoDBCluster -n keycloak
NAME    STATUS    ONLINE   INSTANCES   ROUTERS   AGE
mysql   OFFLINE   0        1           1         7m51s
You can repair this issue by restarting the mysql-operator pod.
Copy
$ kubectl delete pod -l name=mysql-operator -n mysql-operator