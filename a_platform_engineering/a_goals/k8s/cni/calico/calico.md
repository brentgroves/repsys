# **[Calico with Charmed Kubernetes]()**

Calico is the default and a core CNI component for Charmed Kubernetes, providing robust networking and network security policies for containers, virtual machines, and bare metal services.

The default Container Network Interface (CNI) for MicroK8s and Charmed k8s is Calico. Calico is installed automatically and configured with a VXLAN backend by default in versions 1.19 and later. You can change the CNI by enabling an alternative addon, such as KubeOVN, using the microk8s enable kube-ovn command.

Key points regarding Calico in Charmed Kubernetes:

- **Default CNI:** Calico (or Canal, which bundles Flannel and Calico) is often the default networking option when deploying Charmed Kubernetes using Juju.
- **Deployment as a Charm:** It is deployed as a Juju charm, which encapsulates the operational logic and configuration for running Calico as a background service and configuring the CNI for the cluster.
- **Security Policies:** Calico provides a rich set of network security enforcement capabilities, allowing for fine-grained control over pod-to-pod communication within the Kubernetes cluster.
- **Integration:** The Calico charm implements the kubernetes-cni interface, allowing it to integrate seamlessly with other principal charms like kubernetes-master and kubernetes-worker.

## How to use Calico with Charmed Kubernetes

You can typically deploy a cluster with Calico as the CNI using a Juju bundle. The Juju application modeling tool simplifies the deployment and lifecycle management of the cluster and its components.

For detailed installation and configuration instructions, refer to the official Ubuntu documentation for the **[Calico charm](https://ubuntu.com/kubernetes/charmed-k8s/docs/1.23/charm-calico)** and the general Charmed Kubernetes documentation on the Ubuntu website.
