# **[Pause container](https://www.devopsschool.com/blog/what-is-pause-container-in-kubernetes/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[microk8s ctr](https://microk8s.io/docs/command-reference#heading--microk8s-ctr)**
- **[pause container purpose](https://adil.medium.com/what-is-the-purpose-of-the-pause-container-2ce70fa3d059)**

## microk8s

```bash
microk8s ctr
Usage: microk8s ctr [command]
```

## What is Pause container in Kubernetes?

The “pause container” is a special, internal container created and managed by Kubernetes within each pod. Its primary purpose is to serve as a placeholder for the network namespace and IPC (Inter-Process Communication) namespace for all other containers within the same pod. It is a critical component of Kubernetes’ container orchestration mechanism, providing the foundation for container-to-container communication and network isolation within a pod.

The pause container is a special type of container that is used to create a network namespace for each Pod in Kubernetes. It is responsible for routing traffic between the Pod and the outside world.

The pause container is automatically created by containerd when you start a Pod. It is not visible to kubectl, but you can see it using the ctr command. For example, the following command will list all pause containers on the node:

Here are some key characteristics and functions of the pause container:

- **Network Namespace:** The pause container shares its network namespace with all other containers in the pod. This means that all containers in the pod can communicate with each other over the same network stack, including sharing the same IP address and port space. This enables containers within the same pod to easily communicate with each other as if they were running on the same host.
- **IPC Namespace:** Similar to the network namespace, the pause container also shares its IPC namespace with other containers in the pod. This allows containers within the pod to use inter-process communication mechanisms like System V IPC and POSIX message queues to communicate with each other.
- **Lifetime Management:** The pause container is responsible for managing the lifecycle of the pod. When all other containers within the pod have completed their tasks and exited, the pause container remains running, effectively keeping the pod alive. This ensures that the resources allocated to the pod, such as network namespaces, are not prematurely released.
- **Minimal Resource Usage:** The pause container is typically minimal in terms of resource usage. It usually doesn’t run any application code or perform any specific functions other than serving as a placeholder for namespaces. Because of its minimal nature, it consumes very few system resources.
- **Automatically Managed:** Kubernetes automatically creates and manages the pause container, and it is not directly visible or configurable by users or administrators. It is created when the pod is started and terminated when the pod is deleted.

## Here are some of the key benefits of using the pause container in Kubernetes

- **Improved network isolation:** The pause container creates a separate network namespace for each Pod, which helps to isolate Pods from each other. This can improve security and performance by reducing the amount of traffic that can flow between Pods.
- **Simplified network configuration:** The pause container takes care of all the low-level details of networking for Pods. This makes it easier to configure and manage networks in Kubernetes.
- **Portability:** The pause container is a standard component of Kubernetes, so it is available on all Kubernetes platforms. This means that you can deploy your applications to any Kubernetes cluster without having to worry about configuring networking.

## How to see Pause containers using containerd cri?

```bash
microk8s ctr --namespace k8s.io images ls
microk8s ctr --namespace k8s.io c ls
CONTAINER                                                           IMAGE                                        RUNTIME                  
222a21b082dca7032ff1f8be3a49150bcef8a29dcc534ef41f76d0e518ff52c2    registry.k8s.io/pause:3.7                    io.containerd.runc.v2    
3fb42fbc318313796e4b592cdb44b5e8d184f812cd3cf006b70920dc63307b0d    registry.k8s.io/pause:3.7                    io.containerd.runc.v2    
44a37c04debd2e3c75451d3ce9d4be86f04e54a77a83060d34a3f8923b5461ba    registry.k8s.io/pause:3.7                    io.containerd.runc.v2    
4b4387e338eca8a78490a16ca9f1751c1fe886420b817d8239d425edf880fe63    registry.k8s.io/pause:3.7                    io.containerd.runc.v2    
4d621a954093cf0509748a7702f6b322cf62b46ac2aa323d43487c591f5af3dd    docker.io/calico/kube-controllers:v3.25.1    io.containerd.runc.v2    
69dafcdf00295f99ec06f7b2ccda138ef41b74b1e4f29a970daeda297aff42a2    docker.io/calico/node:v3.25.1                io.containerd.runc.v2    
6c44c443477b15a60f27a799367226883f7f0f017d1b4f7fc27902ed4259a501    docker.io/calico/cni:v3.25.1                 io.containerd.runc.v2    
78e09a53770afc8c9440b3202783325c8b758702d9d313f7d6c1929b46bc0583    registry.k8s.io/pause:3.7                    io.containerd.runc.v2    
8966291e73931a050809c57b937d6fe3f85f38ba3f878a4a21a84ef7132eaa01    registry.k8s.io/pause:3.7                    io.containerd.runc.v2    
8e6291abec2b2cca1479a56898d376115a766e9f6a8fe91edcb0e5faee32e9d8    docker.io/calico/kube-controllers:v3.25.1    io.containerd.runc.v2    
a34d5c90136bea8e24bf95402a8b7a51123fd1b0efda710b7d2675b9b231cf7e    docker.io/coredns/coredns:1.10.1             io.containerd.runc.v2    
a762deb58078a576c80a70938d7f67bc524770929dd483d157c272b512ff0db2    docker.io/calico/cni:v3.25.1                 io.containerd.runc.v2    
bd9e22fa815cace1f716c74c785c0bd26be46726064b6074bd45784f1ee06a2a    docker.io/calico/node:v3.25.1                io.containerd.runc.v2    
ef22894322523b3b3e5178936573eaf7b65da5260a0defe86f140af39d4ccf96    docker.io/coredns/coredns:1.10.1             io.containerd.runc.v2

$ ctr --namespace=k8s.io inspect my-pod-pause
```
