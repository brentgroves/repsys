# **[Node Image](https://kind.sigs.k8s.io/docs/design/node-image)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research List](../../research/research_list.md)**\
**[Back Main](../../README.md)**

The **[“node” image](https://sigs.k8s.io/kind/images/node)** is a Docker image for running nested containers, systemd, and Kubernetes components.

This image is built on top of the **[“base” image](https://kind.sigs.k8s.io/docs/design/base-image)**.

Logic for building the “node” image can be found in **[pkg/build](https://sigs.k8s.io/kind/pkg/build)**, and it can be built with kind build node-image respectively.

## Design

Other than the requirements that this image inherits from the “base” image, which provides most of the tools statically needed for a Kubernetes deployment (eg systemd), variants of this image have the following properties:

- /kind/images/ contains various *.tar files which are **[Docker image archives](https://docs.docker.com/engine/reference/commandline/save/)**, these images will be loaded by the cluster tooling prior to running kubeadm
- kubeadm, kubectl, kubelet are in the path
- A **[systemd service](https://www.freedesktop.org/software/systemd/man/systemd.service.html)** is enabled for kubelet, and is configured to not fail on swap being enabled. (we must do the latter because swap is inherited from the host and we don’t want to force users to disable swap before using kind)
- /kind/version is a regular text file containing the gitVersion of the installed Kubernetes build

These properties are used by the **[cluster tooling](https://sigs.k8s.io/kind/pkg/cluster)** to boot each “node” container with **[kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/)**.
