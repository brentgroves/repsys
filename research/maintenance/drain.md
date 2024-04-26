# Remove a K8s node

## Reference

<https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/>

**[If, joining a new node fails for any reason, the joining node gets added to .dqlite, and the cluster has to be fully shutdown to remediate.](https://github.com/canonical/microk8s/issues/3694)**

## Pod Disruption Budget

<https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/>

To ensure that your workloads remain available during maintenance, you can configure a PodDisruptionBudget.

If availability is important for any applications that run or could run on the node(s) that you are draining, configure a PodDisruptionBudgets first and then continue following this guide.

It is recommended to set AlwaysAllow Unhealthy Pod Eviction Policy to your PodDisruptionBudgets to support eviction of misbehaving applications during a node drain. The default behavior is to wait for the application pods to become healthy before the drain can proceed.

## Drain Node

Use kubectl drain to remove a node from service
You can use kubectl drain to safely evict all of your pods from a node before you perform maintenance on the node (e.g. kernel upgrade, hardware maintenance, etc.). Safe evictions allow the pod's containers to gracefully terminate and will respect the PodDisruptionBudgets you have specified.

When kubectl drain returns successfully, that indicates that all of the pods (except the ones excluded as described in the previous paragraph) have been safely evicted (respecting the desired graceful termination period, and respecting the PodDisruptionBudget you have defined). It is then safe to bring down the node by powering down its physical machine or, if running on a cloud platform, deleting its virtual machine.

## Drain process

First, identify the name of the node you wish to drain. You can list all of the nodes in your cluster with

kubectl get nodes
Next, tell Kubernetes to drain the node:

If there are pods managed by a DaemonSet, you will need to specify --ignore-daemonsets with kubectl to successfully drain the node. The kubectl drain subcommand on its own does not actually drain a node of its DaemonSet pods: the DaemonSet controller (part of the control plane) immediately replaces missing Pods with new equivalent Pods. The DaemonSet controller also creates Pods that ignore unschedulable taints, which allows the new Pods to launch onto a node that you are draining.

```bash
sudo kubectl drain --ignore-daemonsets <node name>

# reports13=10.1.0.112
sudo microk8s kubectl drain --ignore-daemonsets reports13
# node/reports13 already cordoned
# Warning: ignoring DaemonSet-managed Pods: kube-system/calico-node-ssbht
# evicting pod kube-system/hostpath-provisioner-7df77bc496-5rnsp
# pod/hostpath-provisioner-7df77bc496-5rnsp evicted
# node/reports13 drained

microk8s status
# high-availability: yes
#   datastore master nodes: 10.1.0.110:19001 10.1.0.111:19001 10.1.0.112:19001

# Notice reports13:10.1.0.112 is no longer part of the cluster
```

Once it returns (without giving an error), you can power down the node (or equivalently, if on a cloud platform, delete the virtual machine backing the node). If you leave the node in the cluster during the maintenance operation, you need to run

```bash
# This was done on the drain command already so did not do it again
kubectl uncordon <node name>
```

afterwards to tell Kubernetes that it can resume scheduling new pods onto the node.
