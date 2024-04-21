# Pod stuck in Terminating status

## refererence

https://containersolutions.github.io/runbooks/posts/kubernetes/pod-stuck-in-terminating-state/

pod/mycluster-0                         0/2     Terminating   2          16h

**[MySQL pod stuck Terminating](https://docs.oracle.com/en/cloud/iaas/verrazzano/vzdoc/docs/troubleshooting/troubleshooting-mysql/#:~:text=MySQL%20pod%20stuck%20Terminating,-A%20MySQL%20pod&text=This%20may%20occur%20while%20upgrading,the%20pod%20never%20finishes%20terminating.&text=You%20can%20repair%20this%20issue%20by%20restarting%20the%20mysql%2Doperator%20pod.)**
This may occur while upgrading the nodes of a Kubernetes cluster. Here is an example of what this condition looks like. All the pod containers are terminated, but the pod never finishes terminating. You can repair this issue by restarting the mysql-operator pod.

You can repair this issue by restarting the mysql-operator pod.

```bash
CopyCopyCopyCopyCopyCopyCopy
$ kubectl delete pod -l name=mysql-operator -n mysql-operator
NAME                                 READY   STATUS    RESTARTS   AGE
pod/mysql-operator-ff46567db-mspcr   0/1     Running   0          19s

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mysql-operator   0/1     1            0           8d

kubectl get all -n mysql-operator

NAME                                 READY   STATUS    RESTARTS   AGE
pod/mysql-operator-ff46567db-mspcr   1/1     Running   0          48s

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mysql-operator   1/1     1            1           8d

NAME                                       DESIRED   CURRENT   READY   AGE
replicaset.apps/mysql-operator-ff46567db   1         1         1       8d

```