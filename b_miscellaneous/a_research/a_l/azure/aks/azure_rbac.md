# **[Use Azure role-based access control for Kubernetes Authorization](https://learn.microsoft.com/en-us/azure/aks/manage-azure-rbac?tabs=azure-cli)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

This article covers how to use Azure RBAC for Kubernetes Authorization, which allows for the unified management and access control across Azure resources, AKS, and Kubernetes resources. For more information, see **[Azure RBAC for Kubernetes Authorization](https://learn.microsoft.com/en-us/azure/aks/concepts-identity#azure-rbac-for-kubernetes-authorization)**.

When using **[integrated authentication between Microsoft Entra ID and AKS](https://learn.microsoft.com/en-us/azure/aks/managed-azure-ad)**, you can use Microsoft Entra users, groups, or service principals as subjects in Kubernetes role-based access control (Kubernetes RBAC). With this feature, you don't need to separately manage user identities and credentials for Kubernetes. However, you still need to set up and manage Azure RBAC and Kubernetes RBAC separately.

## Before you begin

- You need the Azure CLI version 2.24.0 or later installed and configured. Run az --version to find the version. If you need to install or upgrade, see Install Azure CLI.
- You need kubectl, with a minimum version of 1.18.3.
- You need managed Microsoft Entra integration enabled on your cluster before you can add Azure RBAC for Kubernetes authorization. If you need to enable managed Microsoft Entra integration, see **[Use Microsoft Entra ID in AKS](https://learn.microsoft.com/en-us/azure/aks/managed-azure-ad)**.
- If you have CRDs and are making custom role definitions, the only way to cover CRDs today is to use Microsoft.ContainerService/managedClusters/*/read. For the remaining objects, you can use the specific API groups, such as Microsoft.ContainerService/apps/deployments/read.
- New role assignments can take up to five minutes to propagate and be updated by the authorization server.
- Azure RBAC for Kubernetes Authorization requires that the Microsoft Entra tenant configured for authentication is same as the tenant for the subscription that holds your AKS cluster.

## Enable Azure RBAC on an existing AKS cluster
