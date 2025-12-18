# **[Using nsenter to Troubleshoot Pod Networking Issues](https://www.suse.com/support/kb/doc/?id=000021060)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Kubernetes is a popular container orchestration platform used to manage containerized applications. Networking is a critical component of any Kubernetes cluster, and issues can often arise that require troubleshooting. One tool that can help troubleshoot networking issues is nsenter.

nsenter is a Linux utility that allows you to enter namespaces of other processes. In a Kubernetes cluster, each pod has its own network namespace, which means that you can use nsenter to enter the network namespace of a pod and troubleshoot networking issues from the host node of the pod.

This is extremely useful in scenarios where pods do not have a shell to exec into or in environments where you might not have access to a network utility pod to troubleshoot.

## Issue: Unable to Connect to a Service

If you're unable to connect to a service running in a Kubernetes cluster, you can use nsenter to troubleshoot the issue from the host node of the pod. Here's how:

### 1. Identify the pod that's running the service. You can use the kubectl get pods command to list all the pods in your cluster and their current status

```bash
ssh ubuntu@repsys11-c2-n1
kubectl get pods
NAME                                      READY   STATUS    RESTARTS          AGE
bookinfo-gateway-istio-79d6cf5b49-clctt   1/1     Running   0                 4d3h
details-v1-65cfcf56f9-bdr7h               2/2     Running   0                 4d4h
mysql-0                                   1/1     Running   2479 (4d5h ago)   89d
productpage-v1-d5789fdfb-7fq5k            2/2     Running   0                 4d4h
ratings-v1-7c9bd4b87f-hhjsv               2/2     Running   0                 4d4h
reviews-v1-6584ddcf65-tf9kv               2/2     Running   0                 4d4h
reviews-v2-6f85cb9b7c-689bt               2/2     Running   0                 4d4h
reviews-v3-6f5b775685-jzvzc               2/2     Running   0                 4d4h
```

### 2. Use the ps aux command to find the PID of the container running the pod

```bash
ps aux | grep mysql                         
root        3671  0.1  0.0 1236368 11388 ?       Sl   Oct10   9:21 /snap/microk8s/7232/bin/containerd-shim-runc-v2 -namespace k8s.io -id c67ecff905ee643927de01c8013ef51a6f5a4578f85b28ff4bb66adfb6d05a19 -a
65535       3902  0.0  0.0    996     4 ?        Ss   Oct10   0:00  \_ /pause
lxd         4249  0.2  2.3 1306640 382716 ?      Ssl  Oct10  13:55  \_ mysqld

# pid=4249
```

### 3. Once you've identified the PID, use the nsenter command to enter the container's network namespace

The network namespace is located at /proc/{PID}/ns/net. For example, nsenter -t {PID} -n.

```bash
# nsenter -t {PID} -n
nsenter -t 4249 -n
```

### 4. Once you're inside the container's network namespace, you can use standard networking tools (such as ping, curl, or telnet) to test connectivity to the service

## From **[Sidecar Injection Demystified](https://istio.io/latest/blog/2019/data-plane-setup/)**

## Traffic flow from application container to sidecar proxy

Now that we are clear about how a sidecar container and an init container are injected into an application manifest, how does the sidecar proxy grab the inbound and outbound traffic to and from the container? We did briefly mention that it is done by setting up the iptable rules within the pod namespace, which in turn is done by the istio-init container. Now, it is time to verify what actually gets updated within the namespace.

Let’s get into the application pod namespace we deployed in the previous section and look at the configured iptables. I am going to show an example using nsenter. Alternatively, you can enter the container in a privileged mode to see the same information. For folks without access to the nodes, using exec to get into the sidecar and running iptables is more practical.

```bash
docker inspect b8de099d3510 --format '{{ .State.Pid }}'
```

```bash
nsenter -t 4215 -n iptables -t nat -S

-P PREROUTING ACCEPT
-P INPUT ACCEPT
-P OUTPUT ACCEPT
-P POSTROUTING ACCEPT
-N ISTIO_INBOUND
-N ISTIO_IN_REDIRECT
-N ISTIO_OUTPUT
-N ISTIO_REDIRECT
-A PREROUTING -p tcp -j ISTIO_INBOUND
-A OUTPUT -p tcp -j ISTIO_OUTPUT
-A ISTIO_INBOUND -p tcp -m tcp --dport 80 -j ISTIO_IN_REDIRECT
-A ISTIO_IN_REDIRECT -p tcp -j REDIRECT --to-ports 15001
-A ISTIO_OUTPUT ! -d 127.0.0.1/32 -o lo -j ISTIO_REDIRECT
-A ISTIO_OUTPUT -m owner --uid-owner 1337 -j RETURN
-A ISTIO_OUTPUT -m owner --gid-owner 1337 -j RETURN
-A ISTIO_OUTPUT -d 127.0.0.1/32 -j RETURN
-A ISTIO_OUTPUT -j ISTIO_REDIRECT
-A ISTIO_REDIRECT -p tcp -j REDIRECT --to-ports 15001
```

The output above clearly shows that all the incoming traffic to port 80, which is the port our red-demo application is listening, is now REDIRECTED to port 15001, which is the port that the istio-proxy, an Envoy proxy, is listening. The same holds true for the outgoing traffic.

This brings us to the end of this post. I hope it helped to de-mystify how Istio manages to inject the sidecar proxies into an existing deployment and how Istio routes the traffic to the proxy.

Update: In place of istio-init, there now seems to be an option of using the new CNI, which removes the need for the init container and associated privileges. This istio-cni plugin sets up the pods’ networking to fulfill this requirement in place of the current Istio injected pod istio-init approach.
