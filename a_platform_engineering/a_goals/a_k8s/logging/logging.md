# logging

## references

<https://kubernetes.io/docs/concepts/cluster-administration/logging/>

## Logging Architecture

Application logs can help you understand what is happening inside your application. The logs are particularly useful for debugging problems and monitoring cluster activity. Most modern applications have some kind of logging mechanism. Likewise, container engines are designed to support logging. The easiest and most adopted logging method for containerized applications is writing to standard output and standard error streams.

However, the native functionality provided by a container engine or runtime is usually not enough for a complete logging solution.

For example, you may want to access your application's logs if a container crashes, a pod gets evicted, or a node dies.

In a cluster, logs should have a separate storage and lifecycle independent of nodes, pods, or containers. This concept is called cluster-level logging.

Cluster-level logging architectures require a separate backend to store, analyze, and query logs. Kubernetes does not provide a native storage solution for log data. Instead, there are many logging solutions that integrate with Kubernetes. The following sections describe how to handle and store logs on nodes.

## Pod and container logs

Kubernetes captures logs from each container in a running Pod.

This example uses a manifest for a Pod with a container that writes text to the standard output stream, once per second.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: counter
spec:
  containers:
  - name: count
    image: busybox:1.28
    args: [/bin/sh, -c,
            'i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done']

```

To run this pod, use the following command:

```bash
kubectl apply -f https://k8s.io/examples/debug/counter-pod.yaml
```

The output is:

pod/counter created
To fetch the logs, use the kubectl logs command, as follows:

```bash
kubectl logs counter
```

The output is similar to:

0: Fri Apr  1 11:42:23 UTC 2022
1: Fri Apr  1 11:42:24 UTC 2022
2: Fri Apr  1 11:42:25 UTC 2022
You can use kubectl logs --previous to retrieve logs from a previous instantiation of a container. If your pod has multiple containers, specify which container's logs you want to access by appending a container name to the command, with a -c flag, like so:

kubectl logs counter -c count
See the kubectl logs documentation for more details.

Cleanup

```bash
kubectl delete pods counter
```
