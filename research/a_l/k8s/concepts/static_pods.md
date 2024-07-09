# **[static pods](https://blog.devops.dev/static-pods-in-kubernetes-what-are-they-and-how-to-configure-them-980d3e74172)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Static Pods in Kubernetes: What Are They and How to Configure Them

Static Pods are a feature in Kubernetes that allows you to run pods without the need for a Kubernetes API server. They are useful in situations where you need to run a pod on a node that is not managed by a Kubernetes cluster. In this article, we will explore what Static Pods are, how to configure them, and examples of Static Pods that come with Kubernetes.

## What are Static Pods?

Static Pods are pods that are created and managed by a kubelet on a node, rather than by the Kubernetes API server. When the kubelet on a node detects a static pod manifest file in a specific directory, it creates a pod from the manifest file and manages the pod’s lifecycle.

Static Pods are useful in situations where you need to run a pod on a node that is not part of a Kubernetes cluster or when you want to run a pod without relying on the Kubernetes API server.

## How to Configure Static Pods in Kubernetes

To configure a Static Pod in Kubernetes, follow these steps:

Create a Static Pod Manifest File

To create a Static Pod, you need to create a manifest file in YAML format that describes the pod’s configuration. For example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-static-pod
spec:
  containers:
  - name: my-container
    image: nginx
```

The above YAML manifest file creates a Static Pod named my-static-pod with a single container that runs an Nginx image.

Place the Manifest File in the Static Pod Directory

By default, the kubelet on a node looks for Static Pod manifest files in the /etc/kubernetes/manifests directory. You can also configure the kubelet to look for Static Pod manifest files in a different directory.

To place the manifest file in the Static Pod directory, copy it to the appropriate directory on the node. For example:

```sudo cp my-static-pod.yaml /etc/kubernetes/manifests/```

The above command copies the my-static-pod.yaml file to the default Static Pod directory.

Verify the Static Pod

To verify that the Static Pod is running, use the kubectl get pods command, for example:

```kubectl get pods -o wide```

The output should show the Static Pod running on the node.

Examples of Static Pods in Kubernetes

Kubernetes comes with several Static Pods that are configured by default. These include:

- kube-apiserver: The API server for the Kubernetes control plane.
- kube-controller-manager: The controller manager that runs various controllers in the Kubernetes control plane.
- kube-scheduler: The component that schedules pods to run on nodes.

These Static Pods are managed by the kubelet on the control plane node.

To view the configuration files for these Static Pods, use the kubectl describe pod command, for example:

```kubectl describe pod kube-apiserver-control-plane -n kube-system```

The output should show the manifest file used to create the Static Pod.

Default Static Pod Directory

By default, the kubelet on a node looks for Static Pod manifest files in the /etc/kubernetes/manifests directory. You can also configure the kubelet to look for Static Pod manifest files in a different directory by specifying the --pod-manifest-path flag when starting the kubelet.

## Conclusion

Static Pods are a useful feature in Kubernetes that allows you to run pods without relying on the Kubernetes API server. By following the steps outlined in this article, you can easily configure Static Pods and run them on nodes in your Kubernetes cluster. Additionally, Kubernetes comes with several default Static Pods that are configured by default, allowing you to run essential components of the Kubernetes control plane as Static Pods. Understanding how Static Pods work and how to configure them effectively can help you optimize your Kubernetes cluster for your specific workloads and improve the overall stability and reliability of your environment.

In conclusion, Static Pods are a powerful feature in Kubernetes that provides flexibility and control over running pods on nodes that are not part of a Kubernetes cluster or running pods without relying on the Kubernetes API server. By following the steps outlined in this article, you can easily configure Static Pods and take full advantage of this powerful feature in your Kubernetes cluster.
