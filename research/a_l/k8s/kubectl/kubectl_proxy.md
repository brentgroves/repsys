# **[Kubectl Proxy](https://www.loft.sh/blog/when-and-how-to-use-kubectl-proxy)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Kubernetes is a virtualization platform that automates and simplifies application deployment, scaling, and maintenance by leveraging container technology. As a developer or engineer working with Kubernetes, you must learn how to configure the necessary components to deploy your app. One such component is the API server, which provides a RESTful interface for managing running nodes. This blog post will show you when and how to use the kubectl proxy server to access the Kubernetes API server from outside your cluster.

![kv](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de6a24f3bc7cfdb5711e2f_command.png)

## What Is Kubectl Proxy?

Kubectl proxy is a simple command line utility that allows access to the Kubernetes API server from within a cluster. It helps access the API server from within a pod or a remote location outside the cluster.

To use kubectl proxy, specify the desired port and hostname or IP address:

```bash
kubectl proxy --port=8080 --address=192.168.0.1
```

This will start a proxy server on port 8080 that will forward requests to the Kubernetes API server at 192.168.0.1.

If you just want to access the API server from within the cluster, you can use the cluster IP address:

```bash
kubectl proxy --port=8080 --address=10.0.0.1
```

You can also use a hostname or FQDN if your DNS is configured correctly:

```bash
kubectl proxy --port=8080 --address=kubernetes.default.svc.cluster.local
```

Once the proxy runs, you can access the API server using any standard HTTP client ```(curl http://localhost:8080/api/v1/)```. The proxy will forward all requests to the API server and return the response.

## Why Use Kubectl Proxy?

You can also use the proxy to access the Kubernetes dashboard if it runs in the cluster: ```http://localhost:8080/api/v1/proxy/namespaces/kube-system/services/kubernetes-dashboard```.

You may previously have used kubectl to manage these resources, e.g., to control the state of a Kubernetes cluster, create a Kubernetes Pod, or create Nodes. If a user wanted to send an HTTP request to Kubernetes API server, they would typically have started their environment this way:

```bash
kubectl proxy 
kubectl proxy -n default 
curl localhost:8080/api/v1/namespaces/kube-system -H "Content-Type: application/json;charset=UTF-8"
```

However, this is not the only way to access the API server outside your cluster. Kubectl proxy also provides an HTTPS proxy that you can use from a local host, AWS, or an external service.

## When Should I Use This?

The proxy is designed for use in a trusted environment. It's not suitable for environments that expose services directly to the internet. For example, you should never expose it on TCP port 80 of your laptop or on a machine that hosts any other internet services (e.g., web servers). Always follow best practices regarding network security and firewalls when using this tool.

![use](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de6a24f3bc7cfdb5711e2a_kubectl-proxy.png)

## What Are the Requirements?

To use this feature, you must access a local kubectl proxy. If you don't yet have a local kubectl proxy installed, follow the instructions here.

Make sure that you can install and run kubectl commands on your terminal. You can verify that you have the necessary kubectl credentials by running: ```$ kubectl get secret -n default```. The output should resemble something like this:

```yaml
kind : Secret
apiVersion : v1
metadata
    name : os-kubernetes-default-admin
sections :
... apiServer : http://localhost:8001/getting-started
```
