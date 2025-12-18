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

## How Do I Start Using It?

To access the Kubernetes API server through a local proxy, you must specify your proxy in settings.yaml by adding `kubectl.proxyURL: "https://<IP>:5555":`

![np](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de6a24f3bc7cfdb5711e46_ethernet2.jpeg)

## How Do I Connect to the Kubernetes API Server?

You can connect to the Kubernetes API server from a local machine by specifying proxyName in the kubectl.contexts object in settings.yaml. To view the contexts that are already configured, use kubectl config get-contexts.

```bash
kubectl config get-contexts
CURRENT   NAME      CLUSTER   AUTHINFO                          NAMESPACE
*         repsys1   repsys1   clusterUser_reports-aks_repsys1 

kubectl config set-context <context_name> --proxy=https://<ip>:5555
```

The kubectl proxy commands must be run separately from where you run your applications. If you run your proxy commands in the same shell, you must specify an explicit proxy with the command. For example, if you use the same shell to run your applications and the kubectl proxy commands, you must add the -p flag for each command.

```bash
kubectl proxy -p 5555 
kubectl get nodes -p 5555 
curl localhost:5555/api/v1/namespaces/default/services/kubernetes
```

Alternatively, you can use a separate terminal tab to run your applications and proxy commands.

## Where Is the Log Output?

The logs for all kubectl proxy commands are printed on standard output (stdout). When you run kubectl proxy, the log output shows how the commands interact with the Kubernetes API server.

## How Do I Connect to a Remote Proxy?

To connect to a remote proxy, you must specify a URL in the --url flag in your kubectl proxy command. For example:

```bash
kubectl proxy --url https://192.168.0.28:5555 # Remote machine. 
kubectl proxy -n default --url http://192.168.0.28:8080 # Remote machine.
```

The -n defaults to the current context defined in your .kube/config file.

## How Do I Configure My Firewall to Allow a Remote Proxy?

Suppose you're running a remote Kubernetes API server (such as one in Google Container Engine, AWS, etc.). In that case, you can configure your firewall to allow access to the port that the Kubernetes API server specifies (e.g., 8080).

-p &lt;port> The port on which to serve the API (default: 8443)

--http-address=<address> The IP address on which to serve the API. If not specified, you use 160.202.73.11
--https-address=<address> The IP address on which to serve HTTPS requests. If not specified, you use 0.0.0.0

Here's how you can allow access to Kubernetes on the container engine:

```bash
-p 8080 -p 443 -http-address 192.168.0.28 --https-address 192.168.0.28
```

These rules will work without creating a firewall rule (unless it's part of a larger port specification). There are two exceptions: if you're running on OpenShift Origin and you want to access your Kubernetes cluster on port 443 with TLS/SSL, or if you want to access the Kubernetes API server outside of your network (e.g., on the internet). See the sections below for more.

To run kubectl proxy on Google Container Engine, you must create a firewall rule that allows access to Google Container Engine services (e.g., <http://container-name:2443>).

Here's an example of running kubectl proxy on Google Container Engine with TLS/SSL (type in "--tls" to get a list of options):

```bash
-p 443 -p 8443 -https-address=0.0.0.0 -http-address=192.168.0.28 --tls --context="cluster:<container_name>" --user cloud-user@cloud-router:client-certificate-authority=/etc/kubernetes/ssl/client.pem --user cloud-user@cloud-router:client-key/ca.crt:/path/to/client.key
```
