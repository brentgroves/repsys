# **[TLS Bootstrapping](https://kubernetes.io/docs/reference/access-authn-authz/kubelet-tls-bootstrapping/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## TLS bootstrapping

In a Kubernetes cluster, the components on the worker nodes - kubelet and kube-proxy - need to communicate with Kubernetes control plane components, specifically kube-apiserver. In order to ensure that communication is kept private, not interfered with, and ensure that each component of the cluster is talking to another trusted component, we strongly recommend using client TLS certificates on nodes.

The normal process of bootstrapping these components, especially worker nodes that need certificates so they can communicate safely with kube-apiserver, can be a challenging process as it is often outside of the scope of Kubernetes and requires significant additional work. This in turn, can make it challenging to initialize or scale a cluster.

In order to simplify the process, beginning in version 1.4, Kubernetes introduced a certificate request and signing API. The proposal can be found **[here](https://github.com/kubernetes/kubernetes/pull/20439)**.

This document describes the process of node initialization, how to set up TLS client certificate bootstrapping for kubelets, and how it works.

## Initialization process

When a worker node starts up, the kubelet does the following:

- Look for its kubeconfig file
- Retrieve the URL of the API server and credentials, normally a TLS key and signed certificate from the kubeconfig file
- Attempt to communicate with the API server using the credentials.

Assuming that the kube-apiserver successfully validates the kubelet's credentials, it will treat the kubelet as a valid node, and begin to assign pods to it.

Note that the above process depends upon:

- Existence of a key and certificate on the local host in the kubeconfig
- The certificate having been signed by a Certificate Authority (CA) trusted by the kube-apiserver

All of the following are responsibilities of whoever sets up and manages the cluster:

- Creating the CA key and certificate
- Distributing the CA certificate to the control plane nodes, where kube-apiserver is running
- Creating a key and certificate for each kubelet; strongly recommended to have a unique one, with a unique CN, for each kubelet
- Signing the kubelet certificate using the CA key
- Distributing the kubelet key and signed certificate to the specific node on which the kubelet is running

The TLS Bootstrapping described in this document is intended to simplify, and partially or even completely automate, steps 3 onwards, as these are the most common when initializing or scaling a cluster.

## Bootstrap initialization

In the bootstrap initialization process, the following occurs:

- kubelet begins
- kubelet sees that it does not have a kubeconfig file
- kubelet searches for and finds a bootstrap-kubeconfig file
- kubelet reads its bootstrap file, retrieving the URL of the API server and a limited usage "token"
- kubelet connects to the API server, authenticates using the token
- kubelet now has limited credentials to create and retrieve a certificate signing request (CSR)
- kubelet creates a CSR for itself with the signerName set to kubernetes.io/kube-apiserver-client-kubelet
- CSR is approved in one of two ways:
  - If configured, kube-controller-manager automatically approves the CSR
  - If configured, an outside process, possibly a person, approves the CSR using the Kubernetes API or via kubectl
- Certificate is created for the kubelet
- Certificate is issued to the kubelet
- kubelet retrieves the certificate
- kubelet creates a proper kubeconfig with the key and signed certificate
kubelet begins normal operation
- Optional: if configured, kubelet automatically requests renewal of the certificate when it is close to expiry
- The renewed certificate is approved and issued, either automatically or manually, depending on configuration.

The rest of this document describes the necessary steps to configure TLS Bootstrapping, and its limitations.

## Configuration

To configure for TLS bootstrapping and optional automatic approval, you must configure options on the following components:

kube-apiserver
kube-controller-manager
kubelet
in-cluster resources: ClusterRoleBinding and potentially ClusterRole
In addition, you need your Kubernetes Certificate Authority (CA).

## Certificate Authority

As without bootstrapping, you will need a Certificate Authority (CA) key and certificate. As without bootstrapping, these will be used to sign the kubelet certificate. As before, it is your responsibility to distribute them to control plane nodes.

For the purposes of this document, we will assume these have been distributed to control plane nodes at /var/lib/kubernetes/ca.pem (certificate) and /var/lib/kubernetes/ca-key.pem (key). We will refer to these as "Kubernetes CA certificate and key".

All Kubernetes components that use these certificates - kubelet, kube-apiserver, kube-controller-manager - assume the key and certificate to be PEM-encoded.

## **[NEXT](https://kubernetes.io/docs/reference/access-authn-authz/kubelet-tls-bootstrapping/#kube-apiserver-configuration)**
