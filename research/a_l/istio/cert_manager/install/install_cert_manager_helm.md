# **[Install Cert Manager using Helm](https://cert-manager.io/v1.6-docs/installation/helm/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

Installing with Helm
cert-manager provides Helm charts as a first-class method of installation on both Kubernetes and OpenShift.

Be sure never to embed cert-manager as a sub-chart of other Helm charts; cert-manager manages non-namespaced resources in your cluster and care must be taken to ensure that it is installed exactly once.

## Prerequisites

- Install Helm version 3 or later.
- Install a **[supported version of Kubernetes or OpenShift](https://cert-manager.io/docs/installation/supported-releases/)**.
- Read **[Compatibility with Kubernetes Platform Providers](https://cert-manager.io/v1.6-docs/installation/compatibility/)** if you are using Kubernetes on a cloud platform.

## Supported releases

| Release  | Release Date | End of Life     | Supported Kubernetes / OpenShift Versions | Tested Kubernetes Versions |
|----------|--------------|-----------------|-------------------------------------------|----------------------------|
| 1.16     | Oct 03, 2024 | Release of 1.18 | 1.25 → 1.31 / 4.14 → 4.16                 | 1.27 → 1.31                |
| 1.15     | Jun 05, 2024 | Release of 1.17 | 1.25 → 1.31 / 4.12 → 4.16                 | 1.25 → 1.31                |
| 1.12 LTS | May 19, 2023 | May 19, 2025    | 1.22 → 1.31 / 4.9 → 4.16                  | 1.22 → 1.29                |

## **[Compatibility with Kubernetes Platform Providers](https://cert-manager.io/v1.6-docs/installation/compatibility/)**

Don't see anything for aks.

## Steps

1. Add the Jetstack Helm repository:

    This repository is the only supported source of cert-manager charts. There are some other mirrors and copies across the internet, but those are entirely unofficial and could present a security risk.

    Notably, the "Helm stable repository" version of cert-manager is deprecated and should not be used.

    ```bash
    helm repo add jetstack https://charts.jetstack.io
    # AKS instructions show this with --force-update
    helm repo add jetstack https://charts.jetstack.io --force-update

    ```

2. Update your local Helm chart repository cache:

    ```bash
    helm repo update
    ```

3. Install CustomResourceDefinitions

    cert-manager requires a number of CRD resources, which can be installed manually using kubectl, or using the installCRDs option when installing the Helm chart.

    Option 1: installing CRDs with kubectl

    ```bash
    kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.6.3/cert-manager.crds.yaml
    ```

    Option 2: install CRDs as part of the Helm release
    To automatically install and manage the CRDs as part of your Helm release, you must add the --set installCRDs=true flag to your Helm installation command.

    Uncomment the relevant line in the next steps to enable this.

    Note that if you're using a helm version based on Kubernetes v1.18 or below (Helm v3.2), installCRDs will not work with cert-manager v0.16. See the **[v0.16 upgrade notes](https://cert-manager.io/docs/installation/upgrading/upgrading-0.15-0.16/#helm)** for more details.

4. Install cert-manager
To install the cert-manager Helm chart, use the **[Helm install command](https://helm.sh/docs/helm/helm_install/)** as described below.

```bash
$ helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.6.3 \
  # --set installCRDs=true
```

A full list of available Helm values is on **[cert-manager's ArtifactHub page](https://artifacthub.io/packages/helm/cert-manager/cert-manager)**.

The example below shows how to tune the cert-manager installation by overwriting the default Helm values:

```bash
$ helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.6.3 \
  --set prometheus.enabled=false \  # Example: disabling prometheus using a Helm parameter
  --set webhook.timeoutSeconds=4   # Example: changing the webhook timeout using a Helm parameter
```
