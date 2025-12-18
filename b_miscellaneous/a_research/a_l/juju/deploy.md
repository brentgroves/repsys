# **[Juju deploy](https://juju.is/docs/juju/juju-deploy)**

**[Back to Juju List](./juju_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Deploys a new application or bundle.  For K8s add a model which creates a namespace and after deploying the charm there will be pods/services/replicasets/statefulsets etc having to do with the charm/operator.

## Examples

Deploy to a new machine:

```bash
# Deploy and configure postgresql-k8s:
# juju deploy [options] <charm or bundle> [<application name>]
# Deploys a new application or bundle to a machine / container.
ubuntu@tutorial-vm:~$ juju deploy postgresql-k8s --channel 14/stable --trust --config profile=testing
Located charm "postgresql-k8s" in charm-hub, revision 193
Deploying "postgresql-k8s" from charm-hub charm "postgresql-k8s", revision 193 in channel 14/stable on ubuntu@22.04/stable

# Deploy self-signed-certificates:
# juju deploy [options] <charm or bundle> [<application name>]
ubuntu@my-juju-vm:~$ juju deploy self-signed-certificates
Located charm "self-signed-certificates" in charm-hub, revision 72
Deploying "self-signed-certificates" from charm-hub charm "self-signed-certificates", revision 72 in channel stable on ubuntu@22.04/stable

microk8s kubectl get all --namespace chat
NAME                                  READY   STATUS    RESTARTS   AGE
pod/modeloperator-545b744f7d-vb66p    1/1     Running   0          4d22h
pod/mattermost-k8s-operator-0         1/1     Running   0          4d22h
pod/self-signed-certificates-0        1/1     Running   0          4d22h
pod/mattermost-k8s-8497bd9757-gcqmz   1/1     Running   0          4d22h
pod/postgresql-k8s-0                  2/2     Running   0          4d22h

NAME                                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/modeloperator                        ClusterIP   10.152.183.184   <none>        17071/TCP           4d22h
service/mattermost-k8s-operator              ClusterIP   10.152.183.200   <none>        30666/TCP           4d22h
service/postgresql-k8s-endpoints             ClusterIP   None             <none>        <none>              4d22h
service/postgresql-k8s                       ClusterIP   10.152.183.124   <none>        5432/TCP,8008/TCP   4d22h
service/postgresql-k8s-primary               ClusterIP   10.152.183.74    <none>        8008/TCP,5432/TCP   4d22h
service/postgresql-k8s-replicas              ClusterIP   10.152.183.231   <none>        8008/TCP,5432/TCP   4d22h
service/patroni-postgresql-k8s-config        ClusterIP   None             <none>        <none>              4d22h
service/self-signed-certificates             ClusterIP   10.152.183.75    <none>        65535/TCP           4d22h
service/self-signed-certificates-endpoints   ClusterIP   None             <none>        <none>              4d22h
service/mattermost-k8s                       ClusterIP   10.152.183.104   <none>        8065/TCP            4d22h

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/modeloperator    1/1     1            1           4d22h
deployment.apps/mattermost-k8s   1/1     1            1           4d22h

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/modeloperator-545b744f7d    1         1         1       4d22h
replicaset.apps/mattermost-k8s-8497bd9757   1         1         1       4d22h

NAME                                        READY   AGE
statefulset.apps/mattermost-k8s-operator    1/1     4d22h
statefulset.apps/postgresql-k8s             1/1     4d22h
statefulset.apps/self-signed-certificates   1/1     4d22h

juju deploy apache2
Deploy to machine 23:

juju deploy mysql --to 23
Deploy to a new LXD container on a new machine:

juju deploy mysql --to lxd
Deploy to a new LXD container on machine 25:

juju deploy mysql --to lxd:25
Deploy to LXD container 3 on machine 24:

juju deploy mysql --to 24/lxd/3
```
