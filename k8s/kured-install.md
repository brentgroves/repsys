# Kured

**[Kubernetes Reboot Daemon](https://kured.dev/docs/)**

Watches for the presence of a reboot sentinel file e.g. /var/run/reboot-required or the successful run of a sentinel command.
Cordons & drains worker nodes before reboot, uncordoning them after.
Utilises a lock in the API server to ensure only one node reboots at a time.
Optionally defers reboots in the presence of active Prometheus alerts or selected pods.

## Install Kured

**[Install Kured](https://kured.dev/docs/installation/)**

To obtain a default installation without Prometheus alerting interlock or Slack notifications:

```bash
sudo apt  install jq
latest=$(curl -s https://api.github.com/repos/kubereboot/kured/releases | jq -r '.[0].tag_name')
kubectl apply -f "https://github.com/kubereboot/kured/releases/download/$latest/kured-$latest-dockerhub.yaml"
clusterrole.rbac.authorization.k8s.io/kured created
clusterrolebinding.rbac.authorization.k8s.io/kured created
role.rbac.authorization.k8s.io/kured created
rolebinding.rbac.authorization.k8s.io/kured created
serviceaccount/kured created
daemonset.apps/kured created
```

If you want to customise the installation, download the manifest and edit it in accordance with the following **[section](https://kured.dev/docs/installation/)** before application.

## Operation

**[Install and test Kured](https://www.youtube.com/watch?v=t2vwuSHmInk)**

```bash
kubectl get pods -n kube-system -owide | grep kured
kured-hhxc7                                  1/1     Running   0               3m58s
kured-b5pqn                                  1/1     Running   0               3m58s
kured-rbcmj                                  1/1     Running   0               3m58s
kured-p88rs                                  1/1     Running   0               3m58s

# we can use prometheus metrics to control Kured
# I didn't create the svc to access this
curl metrics-ip:8080/metrics

# For a test edit the daemonset
# The default reboot check is every hour.
# --period duration                     sentinel check period (default 1h0m0s)

# Change this for test purposes to 30
kubectl edit daemonset kured -n kube-system
- command
  - /usr/bin/kured
  - --period=0h0m30s

# check if pods came up after change
kubectl get pods -n kube-system -owide | grep kured

# watch the nodes
kubectl get nodes -w

# You can test your configuration by provoking a reboot on a node:
ssh brent@reports54
sudo touch /var/run/reboot-required

# watch the nodes to detect reboot
kubectl get nodes -w

# Or look at the logs to see the reboot
kubectl logs -f kured-gpf2w -n kube-system
time="2023-10-20T20:52:04Z" level=info msg="Reboot check command: [test -f /var/run/reboot-required] every 30s"
time="2023-10-20T20:52:04Z" level=info msg="Concurrency: 1"
time="2023-10-20T20:52:04Z" level=info msg="Reboot command: [/bin/systemctl reboot]"
time="2023-10-20T20:53:41Z" level=info msg="Reboot required"
time="2023-10-20T20:53:42Z" level=info msg="Acquired reboot lock"
time="2023-10-20T20:53:42Z" level=info msg="Draining node reports54"
WARNING: ignoring DaemonSet-managed Pods: mayastor/mayastor-csi-node-8wl58, mayastor/mayastor-io-engine-89s9f, observability/loki-promtail-qn76d, observability/kube-prom-stack-prometheus-node-exporter-sr9m9, kube-system/calico-node-xdp7m, kube-system/kured-rtfrq
evicting pod default/mycluster-1
evicting pod mayastor/mayastor-csi-controller-f8b874bd8-5n7mc
evicting pod mayastor/mayastor-agent-core-7d6c88c8bf-mpmmm
evicting pod mayastor/mayastor-api-rest-84d867b977-ppvst
time="2023-10-20T20:54:47Z" level=info msg="Running command: [/usr/bin/nsenter -m/proc/1/ns/mnt -- /bin/systemctl reboot] for node: reports54"
time="2023-10-20T20:54:47Z" level=info msg="Waiting for reboot"
...
kubectl logs -f kured-rtfrq -n kube-system
time="2023-10-20T20:58:00Z" level=info msg="Reboot schedule: SunMonTueWedThuFriSat between 00:00 and 23:59 UTC"
time="2023-10-20T20:58:00Z" level=info msg="Reboot check command: [test -f /var/run/reboot-required] every 30s"
time="2023-10-20T20:58:00Z" level=info msg="Concurrency: 1"
time="2023-10-20T20:58:00Z" level=info msg="Reboot command: [/bin/systemctl reboot]"
time="2023-10-20T20:58:30Z" level=info msg="Holding lock"
time="2023-10-20T20:58:30Z" level=info msg="Uncordoning node reports54"
time="2023-10-20T20:58:30Z" level=info msg="Releasing lock"
time="2023-10-20T20:59:10Z" level=info msg="Reboot not required"
time="2023-10-20T20:59:40Z" level=info msg="Reboot not required"

# Check MySQL InnoDB Cluster

kubectl get pods -n default -owide                 
NAME                                READY   STATUS             RESTARTS      AGE   IP             NODE        NOMINATED NODE   READINESS GATES
mycluster-router-5db48cbbcb-xw6tc   1/1     Running            0             46h   10.1.211.207   reports53   <none>           <none>
mycluster-0                         2/2     Running            0             46h   10.1.195.85    reports51   <none>           2/2
mycluster-2                         2/2     Running            0             46h   10.1.184.151   reports52   <none>           2/2
mycluster-1                         1/2     CrashLoopBackOff   7 (54s ago)   16m   10.1.214.80    reports54   <none>           0/2

# Notice reports54 did not come up
# Can we access the cluster with reports54 down? YES
kubectl run --rm -it myshell --image=container-registry.oracle.com/mysql/community-operator -- mysqlsh root@mycluster --sql
****
use ETL;
select * from script;
...

# looking at the sidecar pods logs only shows that I didn't type the password right.
kubectl logs mycluster-1 -c sidecar
[2023-10-20 21:20:16,747] sidecar              [INFO    ] MySQL Operator/sidecar_main.py=2.1.0 timestamp=2023-07-10T12:11:08 kopf=1.35.4 uid=27
[2023-10-20 21:20:16,774] sidecar              [INFO    ] My pod is mycluster-1 in default
[2023-10-20 21:20:16,774] sidecar              [INFO    ] Bootstrapping
[2023-10-20 21:20:16,777] sidecar              [CRITICAL] Unexpected MySQL error during connection: MySQL Error (1045): Shell.connect: Access denied for user 'localroot'@'localhost' (using password: NO)
Exception happened in entrypoint sidecar. The message is: MySQL Error (1045): Shell.connect: Access denied for user 'localroot'@'localhost' (using password: NO)

kubectl logs mycluster-0 -c mysql
...
2023-10-20T20:51:37.445919Z 0 [Note] [MY-011287] [Server] Plugin mysqlx reported: '161.1: Maximum number of authentication attempts reached, login failed.'
2023-10-20T20:51:37.493636Z 0 [Note] [MY-011287] [Server] Plugin mysqlx reported: '162.1: Maximum number of authentication attempts reached, login failed.'
2023-10-20T20:53:47.309704Z 0 [Note] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Updating physical connections to other servers'
2023-10-20T20:53:47.318888Z 0 [Note] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Using existing server node 0 host mycluster-0.mycluster-instances.default.svc.cluster.local:3306'
2023-10-20T20:53:47.319036Z 0 [Note] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Using existing server node 1 host mycluster-2.mycluster-instances.default.svc.cluster.local:3306'
2023-10-20T20:53:47.319178Z 0 [Note] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Sucessfully installed new site definition. Start synode for this configuration is {3dba550f 271779 2}, boot key synode is {3dba550f 271768 2}, configured event horizon=10, my node identifier is 0'
2023-10-20T20:53:47.779253Z 0 [Note] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] A configuration change was detected. Sending a Global View Message to all nodes. My node identifier is 0 and my address is mycluster-0.mycluster-instances.default.svc.cluster.local:3306'
2023-10-20T20:53:47.800144Z 0 [Note] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Group is able to support up to communication protocol version 8.0.27'
2023-10-20T20:53:47.800432Z 0 [Warning] [MY-011499] [Repl] Plugin group_replication reported: 'Members removed from the group: mycluster-1.mycluster-instances.default.svc.cluster.local:3306'

# from kured logs
time="2023-10-20T20:53:42Z" level=info msg="Draining node reports54"
# looks like the same time the node was rebooted by kured the MySQL InnoDB Cluster operator removed reports54 from the group and it never comes up again

# back to mysql logs
2023-10-20T20:53:47.800717Z 0 [System] [MY-011503] [Repl] Plugin group_replication reported: 'Group membership changed to mycluster-2.mycluster-instances.default.svc.cluster.local:3306, mycluster-0.mycluster-instances.default.svc.cluster.local:3306 on view 16976699275680572:4.'
2023-10-20T20:53:50.339028Z 0 [Note] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Failure reading from fd=59 n=0 from mycluster-1.mycluster-instances.default.svc.cluster.local:3306'
2023-10-20T21:08:17.913942Z 0 [Note] [MY-011287] [Server] Plugin mysqlx reported: '163.1: Maximum number of authentication attempts reached, login failed.'
2023-10-20T21:08:17.975356Z 0 [Note] [MY-011287] [Server] Plugin mysqlx reported: '164.1: Maximum number of authentication attempts reached, login failed.'

```

**[Kured configuration](https://kured.dev/docs/configuration/)**

**[Operation](https://kured.dev/docs/operation/)**
"
Testing
You can test your configuration by provoking a reboot on a node:

sudo touch /var/run/reboot-required
Disabling Reboots
If you need to temporarily stop kured from rebooting any nodes, you can take the lock manually:

kubectl -n kube-system annotate ds kured weave.works/kured-node-lock='{"nodeID":"manual"}'
Don’t forget to release it afterwards!

Manual Unlock
In exceptional circumstances, such as a node experiencing a permanent failure whilst rebooting, manual intervention may be required to remove the cluster lock:

kubectl -n kube-system annotate ds kured weave.works/kured-node-lock-
NB the - at the end of the command is important - it instructs kubectl to remove that annotation entirely.

"
