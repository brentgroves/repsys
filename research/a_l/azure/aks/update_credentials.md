# **[Update or rotate the credentials for an Azure Kubernetes Service (AKS) cluster](https://learn.microsoft.com/en-us/azure/aks/concepts-network-services)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

AKS clusters created with a service principal have a one-year expiration time. As you near the expiration date, you can reset the credentials to extend the service principal for an additional period of time. You might also want to update, or rotate, the credentials as part of a defined security policy. AKS clusters integrated with Microsoft Entra ID as an authentication provider have two more identities: the Microsoft Entra Server App and the Microsoft Entra Client App. This article details how to update the service principal and Microsoft Entra credentials for an AKS cluster.

An **Azure service principal** is a security identity used by user-created apps, services, and automation tools to access specific Azure resources.

## Before you begin

You need the Azure CLI version 2.0.65 or later installed and configured. Run az --version to find the version. If you need to install or upgrade, see Install Azure CLI.

## Update or create a new service principal for your AKS cluster

When you want to update the credentials for an AKS cluster, you can choose to either:

- Update the credentials for the existing service principal.
- Create a new service principal and update the cluster to use these new credentials.

**Warning**\
If you choose to create a new service principal, wait around 30 minutes for the service principal permission to propagate across all regions. Updating a large AKS cluster to use these credentials can take a long time to complete.

## Check the expiration date of your service principal

To check the expiration date of your service principal, use the az ad app credential list command. The following example gets the service principal ID for the $CLUSTER_NAME cluster in the $RESOURCE_GROUP_NAME resource group using the az aks show command. The service principal ID is set as a variable named SP_ID.

Azure CLI

```bash
SP_ID=$(az aks show --resource-group $RESOURCE_GROUP_NAME --name $CLUSTER_NAME \
    --query servicePrincipalProfile.clientId -o tsv)
az ad app credential list --id "$SP_ID" --query "[].endDateTime" -o tsv
```

## **[Alternative to service principal is managed identities](https://learn.microsoft.com/en-us/azure/aks/use-managed-identity)** I have not used this way

Alternatively, you can use a managed identity for permissions instead of a service principal. Managed identities don't require updates or rotations. For more information, see **[Use managed identities](https://learn.microsoft.com/en-us/azure/aks/use-managed-identity)**.

Azure Kubernetes Service (AKS) clusters require a Microsoft Entra identity to access Azure resources like load balancers and managed disks. Managed identities for Azure resources are the recommended way to authorize access from an AKS cluster to other Azure services.

You can use a managed identity to authorize access from an AKS cluster to any service that supports Microsoft Entra authorization, without needing to manage credentials or include them in your code. You assign to the managed identity an Azure role-based access control (Azure RBAC) role to grant it permissions to a particular resource in Azure. For example, you can grant permissions to a managed identity to access secrets in an Azure key vault for use by the cluster. For more information about Azure RBAC, see What is Azure role-based access control (Azure RBAC)?.
