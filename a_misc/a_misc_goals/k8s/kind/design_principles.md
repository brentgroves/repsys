# **[Principles](https://kind.sigs.k8s.io/docs/design/principles/)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research List](../../research/research_list.md)**\
**[Back Main](../../README.md)**

## Degrade Gracefully

As much as possible kind should not fail, because it is to be used for testing. Partially degraded states can still be useful and still be debugged.

As a concrete example: We “pre-load” images that the cluster depends on by packing them into the “node image”. If these images fail to load or are not present in the node image, kind will fall back to letting the “node"s container runtime attempt to pull them.

Similarly we must at least support all officially supported Kubernetes releases, which may mean gracefully degrading functionality for older releases.

## Target CRI Functionality

Currently kind only supports containerd, with experimental support for podman. It uses these container runtimes directly to create “node” containers.

With the long term goal of supporting multiple container runtimes and avoid unnecessary coupling, we try to target functionality covered by the Kubernetes CRI (Container Runtime Interface).

## Leverage Existing Tooling

Where possible we should not reinvent the wheel.

Examples include:

- **[kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/)** is used to handle node configuration, certificates, etc.
- **[kustomize](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/)** is used to handle merging user provided config patches with our generated kubeadm configs
- **[k8s.io/apimachinery](https://github.com/kubernetes/apimachinery)** is used to build our own configuration functionality
- In general we re-use k8s.io
  - **[utility libraries](https://github.com/kubernetes/utils)**

    - As Kubernetes grows and spins functionality out of its core and into cooperating repositories like apiserver, kubectl, kubeadm, etc., the need arises for leaf repositories to house shared code and avoid cycles in repository relationships.
    - This repository is intended to hold shared utilities with no Kubernetes dependencies that may be of interest to any Go project. See these instructions for moving an existing package to this repository.

  - **[generators](https://github.com/kubernetes/code-generator)**

    These code-generators can be used

    - in the context of CustomResourceDefinition to build native, versioned clients, informers and other helpers
    - in the context of User-provider API Servers to build conversions between internal and versioned types, defaulters, protobuf codecs, internal and versioned clients and informers.

Re-implementing some amount of functionality is expected, particularly between languages and for internal / insufficiently-generic components, but in general we should collaborate where possible.

## Avoid Breaking Users 🔗︎

Going forward kind will avoid breaking changes to the command line interface and configuration.

Next we will extend this to a documented set of re-usable packages (To be determined, but likely IE **[pkg/cluster](https://github.com/kubernetes-sigs/kind/tree/main/pkg/cluster)**).

While we are alpha grade currently, we will move to beta and respect the **[Kubernetes Deprecation Policy](https://kubernetes.io/docs/reference/using-api/deprecation-policy/)**.

Externally facing features should consider long-term supportability and extensibility.

## Follow Kubernetes API Conventions

A
s a general rule of thumb kind prefers to implement configuration using Kubernetes style configuration files.

While doing this we should respect the Kubernetes **[API Conventions](https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md)**.

Additionally we should minimize the number of flags used and avoid structured values in flags as these cannot be versioned.

## Minimize Assumptions 🔗︎

Avoid making any unnecessary assumptions. Currently we assume:

- docker is installed on the host and the current user has permission to talk to dockerd
  - Unless using experimental support for podman or nerdctl.
  - In the future we may instead only assume that a CRI is available. See above.
- “node” images follow our format
  - However whenever we make changes we do not assume the updated contents definitely exist
  - Metadata in the images is assumed to be correct
- When building Kubernetes, we make the same assumptions & requirements as upstream

## Be Hermetic

As an extension of minimizing assumptions, kind should be as hermetic as possible. In other words:

- Strive for reproducibility of operations
- Avoid depending on external services, vendor / pre-pull dependencies

## No External State

State is offloaded into the “node” containers in the form of labels, files in the container filesystem, and processes in the container. The cluster itself stores all state. No external state stores are used and the only stateful process is the container runtime. kind does not itself store or manage state.

This simplifies a lot of problems and eases portability, while forcing cluster interactions to be consistent.

## Consider Automation

While kind strives to present a pleasant UX to users on their local machines, automation for end to end testing is the original & primary use case. Automated usage should be considered for all features.
