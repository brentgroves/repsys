# Rebooting k8s

## reboot all

Had much success just rebooting every node at ounce.
```bash
# reboot every node at the same time
sudo reboot
```

## kured

I had to edit postgresql and innodb router instances to 0 before this in order for the reboot to happen on all of the nodes.

### when you don't edit these two before doing using kured to reboot.

```bash
## error rebooting last node
error when evicting pods/"mycluster-1" -n "default" (will retry after 5s): Cannot evict pod as it would violate the pod's disruption budget.

kubectl get all
pod/mycluster-router-6444b6fc88-rr4d2   0/1     CrashLoopBackOff   7 (110s ago)   13m

```
- kubectl edit postgresql.acid.zalan.do/acid-minimal-cluster
- kubectl edit innodbcluster mycluster

```bash
# go to node to reboot
sudo touch /var/run/reboot-required
kubectl get nodes -watch
# or
# Or look at the logs to see the reboot
kubectl get pods -n kube-system -owide | grep kured
kubectl logs -f kured-q5v9f -n kube-system
## error rebooting last node
# error when evicting pods/"mycluster-1" -n "default" (will retry after 5s): Cannot evict pod as it would violate the pod's disruption budget.
# sometimes it does finally reboot the last node but then

kubectl get all
pod/mycluster-router-6444b6fc88-rr4d2   0/1     CrashLoopBackOff   7 (110s ago)   13m

# Sometimes if you wait long enough k8s resolves this issue by itself but you can do the following to help it along.
# change the router instances to 0 and wait for the router pod and deployment to be removed
kubectl edit innodbcluster mycluster
# set the router instance to 1
kubectl edit innodbcluster mycluster

# kubectl edit postgresql acid-minimal-cluster

kubectl get pods -n kube-system -owide | grep kured
kubectl logs -f kured-w9gqk -n kube-system
kubectl edit postgresql.acid.zalan.do/acid-minimal-cluster

kubectl edit innodbcluster mycluster

```

```yaml
apiVersion: "acid.zalan.do/v1"
kind: postgresql
metadata:
  name: acid-minimal-cluster
spec:
  teamId: "acid"
  volume:
    size: 20Gi
  numberOfInstances: 2
```