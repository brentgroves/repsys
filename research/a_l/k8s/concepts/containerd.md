# **[Containerd and ctr](https://cloudyuga.guru/blogs/containerd-and-ctr/)**

## references

<https://microk8s.io/docs/command-reference#heading--microk8s-ctr>
<https://microk8s.io/docs/configuring-services>

## microk8s

```bash
microk8s ctr
Usage: microk8s ctr [command]
```

snap.microk8s.daemon-containerd
Containerd is the container runtime used by MicroK8s to manage images and execute containers.

The containerd daemon started using the configuration in
${SNAP_DATA}/args/containerd and ${SNAP_DATA}/args/containerd-template.toml.

To learn how to work with container images and containers using containerd
In container runtime and runC hands-on lab, we have looked at the evolution of containers and their use cases with runC implementation. But with the help of runC, we can only create one container. If we have to manage multiple such runC containers we have a tool called containerd, and its command-line client called ctr.

Containerd is a high-level core container runtime that Docker created. It was donated to CNCF later. It pulls images from registries, mounts storage, and creates container networking. It is a daemon process that starts, stops, and kills containers. Thus, it manages the lifecycle of containers. Software projects can use this to run containers and manage container images.

 It has most of Docker’s functionality for managing containers and images, which makes it suitable for large-scale use as part of container orchestrators like Kubernetes.

Containerd follows and supports OCI standards. It also supports Container Runtime Interface (CRI), a Kubernetes specification, which helps run multiple container runtimes in a cluster.

## Comparison between Containerd and Docker

Docker provides many features to run and manage containers, and one of them is Docker Engine, an advanced container runtime with developer tools.

Containerd is also a container runtime out of Docker, and Docker Engine uses containerd behind the scenes. Docker Engine is a high-level container engine, while containerd is a low-level container engine mainly suitable for automated mechanisms.

## Installation of Containerd

Hands-on plays an important role to understand the concept thoroughly so you can Install containerd as compatible to your machine’s operating system and proceed further. Alternatively, you can also use VM on top of your OS and install ubuntu Linux distribution and follow this blog.

For ubuntu-based distribution, install it via apt

```bash
apt update && apt install -y containerd
```

Now, confirm the installation by running the following command:

```containerd --help```

containerd installation comes with the following downstream dependencies:

runC : to run containers
ctr : A CLI for containerd
containerd-shim : to support daemonless (containers can either be run as root or in rootless mode) containers

## Managing Containerd

In Linux, Services are managed using the systemctl command. We can use systemctl commands to manage our containers or pods as services. Run the following command to check the status of containerd service.

```bash
systemctl status containerd
```
