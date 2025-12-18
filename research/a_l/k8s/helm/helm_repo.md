# **[How to Add, Update or Remove Helm Repositories](https://phoenixnap.com/kb/helm-repo-add-update-remove)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Introduction

Helm chart repositories are remote servers containing a collection of Kubernetes resource files. Charts are displayed in directory trees and packaged into Helm chart repositories.

To deploy applications with Helm, you need to know how to manage repositories.

In this tutorial, you will learn how to add, update, or remove Helm chart repositories.

## Prerequisites

- A system running Ubuntu, Windows, or Mac.
- Access to a command line/terminal.
- A Kubernetes cluster installed.
- **Helm installed](<https://phoenixnap.com/kb/install-helm>)** and configured.

## How to Add Helm Repositories

The general syntax for adding a Helm chart repository is:

```bash
# helm repo add [NAME] [URL] [flags]
helm repo add kong https://charts.konghq.com
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/brent/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/brent/.kube/config
"kong" already exists with the same configuration, skipping

```

To add official stable Helm charts, enter the following command:

```bash
helm repo add stable https://charts.helm.sh/stable
```

The terminal prints out a confirmation message when adding is complete:

![b](https://phoenixnap.com/kb/wp-content/uploads/2021/04/add-helm-repo.png)

List the contents of the repository using the search repo command:

```bash
helm search repo stable
```

The terminal prints out the list of all available charts.

![list](https://phoenixnap.com/kb/wp-content/uploads/2021/04/search-helm-repositories.png)

## How to Update Helm Repositories

Update all Helm repositories in your system by running the following command:

```bash
# helm repo update
helm repo update kong
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/brent/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/brent/.kube/config
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "kong" chart repository
Update Complete. ⎈Happy Helming!⎈

```

The output contains a list of all updated repositories.

![up](https://phoenixnap.com/kb/wp-content/uploads/2021/04/update-helm-repo.png)

## How to list helm repos

```bash
helm repo list       
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/brent/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/brent/.kube/config
NAME                    URL                                               
prometheus-community    https://prometheus-community.github.io/helm-charts
ot-helm                 https://ot-container-kit.github.io/helm-charts/   
kong                    https://charts.konghq.com                         
bitnami                 https://charts.bitnami.com/bitnami                
```

## How to Remove Helm Repositories

```bash
# The general syntax for removing Helm repositories is:
helm repo remove [REPO1 [REPO2 ...]] [flags]

# Remove a Helm repository by entering:
helm repo remove stable
```

The terminal prints out a confirmation message once the repository is removed.

![remove](https://phoenixnap.com/kb/wp-content/uploads/2021/04/remove-helm-chart-repository.png)
