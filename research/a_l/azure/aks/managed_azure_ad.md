# **[Enable Azure managed identity authentication for Kubernetes clusters with kubelogin](https://learn.microsoft.com/en-us/azure/aks/managed-azure-ad)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[Use Azure role-based access control for Kubernetes Authorization](https://learn.microsoft.com/en-us/azure/aks/manage-azure-rbac?tabs=azure-cli)**

The AKS-managed Microsoft Entra integration simplifies the Microsoft Entra integration process. Previously, you were required to create a client and server app, and the Microsoft Entra tenant had to assign **[Directory Readers](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#directory-readers)** role permissions. Now, the AKS resource provider manages the client and server apps for you.

Cluster administrators can configure Kubernetes role-based access control (Kubernetes RBAC) based on a user's identity or directory group membership. Microsoft Entra authentication is provided to AKS clusters with OpenID Connect. OpenID Connect is an identity layer built on top of the OAuth 2.0 protocol. For more information on OpenID Connect, see the **[OpenID Connect](https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc)** documentation.

Learn more about the Microsoft Entra integration flow in the **[Microsoft Entra](https://learn.microsoft.com/en-us/azure/aks/concepts-identity#azure-ad-integration)** documentation.

This article provides details on how to enable and use managed identities for Azure resources with your AKS cluster.

## Limitations

The following are constraints integrating Azure managed identity authentication on AKS.

- Integration can't be disabled once added.
- Downgrades from an integrated cluster to the legacy Microsoft Entra ID clusters aren't supported.
- Clusters without Kubernetes RBAC support are unable to add the integration.

## Before you begin

The following requirements need to be met in order to properly install the AKS addon for managed identity.

- You have Azure CLI version 2.29.0 or later installed and configured. Run az --version to find the version. If you need to install or upgrade, see **[Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)**.
- You need kubectl with a minimum version of 1.18.1 or kubelogin. With the Azure CLI and the Azure PowerShell module, these two commands are included and automatically managed. Meaning, they're upgraded by default and running az aks install-cli isn't required or recommended. If you're using an automated pipeline, you need to manage upgrades for the correct or latest version. The difference between the minor versions of Kubernetes and kubectl shouldn't be more than one version. Otherwise, authentication issues occur on the wrong version.
- If you're using helm, you need a minimum version of helm 3.3.
- This configuration requires you have a Microsoft Entra group for your cluster. This group is registered as an admin group on the cluster to grant admin permissions. If you don't have an existing Microsoft Entra group, you can create one using the **[az ad group create](https://learn.microsoft.com/en-us/cli/azure/ad/group#az_ad_group_create)** command.

Microsoft Entra integrated clusters using a Kubernetes version newer than version 1.24 automatically use the kubelogin format. Starting with Kubernetes version 1.24, the default format of the clusterUser credential for Microsoft Entra ID clusters is exec, which requires **[kubelogin](https://github.com/Azure/kubelogin)** binary in the execution PATH. There is no behavior change for non-Microsoft Entra clusters, or Microsoft Entra ID clusters running a version older than 1.24. Existing downloaded kubeconfig continues to work. An optional query parameter format is included when getting clusterUser credential to overwrite the default behavior change. You can explicitly specify format to azure if you need to maintain the old kubeconfig format.

```bash
sudo snap install kubelogin
kubelogin v0.1.0 from Miguel Alvarado (exodus) installed
```

## Determine what EntraID group to be admin for cluster

```bash
az ad group list --display-name cont
```

## Use an existing cluster

Enable AKS-managed Microsoft Entra integration on your existing Kubernetes RBAC enabled cluster using the **[az aks update](https://learn.microsoft.com/en-us/cli/azure/aks#az_aks_update)** command. Make sure to set your admin group to keep access on your cluster.

```bash
export AKV_NAME=reports-aks 
export RESOURCE_GROUP=reports-aks 
export LOCATION=centralus
export CLUSTER=reports-aks

az aks show --resource-group $RESOURCE_GROUP --name $CLUSTER
...
  "aadProfile": null,
  "addonProfiles": {
    "azureKeyvaultSecretsProvider": {
      "config": {
        "enableSecretRotation": "false",
        "rotationPollInterval": "2m"
      },
      "enabled": true,
      "identity": null
    }
  },
  ...
  "enableRbac": true,
  ...
  "fqdn": "reports-ak-reports-aks-f7d0cf-acy9oemr.hcp.centralus.azmk8s.io",
  ...
  "kubernetesVersion": "1.30.4",
  "linuxProfile": {
    "adminUsername": "azureuser",
    "ssh": {
      "publicKeys": [
        {
          "keyData": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnKCQ0ckzB0QcdGDEi+T54xX/zbKo9F0qEtMuvRq/bJ6teGYT2Ti4Ag/+XqEIHeDRRK2FNiOHJJfqmoCUih+b0ol0G6Z5Nru4Hk3UUk/dCFDZE7A7ehgfE/+Vch9qcv3vaOlqmxCdt3LacDOh/FbrrUT7yzu59S+Wbt6KMMPOdUe42zNWAvdqBVCShv+FHq40+m4xzO0Pe9RoEaVcLEJcvuprUfATTKYwntX+A9qKu/dImFI8ol67ufu3vWIRXtpEAnDOuF7tip2pRCPpPXI+9M+ePq/jCF6A96RiFnRyaLUrOy/KiEqvIa0XB1Qb6jdsRFIgQk/P1EW4n7h9CBNxQZl/P+HO6puhmW2lXzEH9kfTshx5Y4T7Ujh1N+ilulh2OpfLBhqWDpoTZ0q+rRZMO7qiCL4cUicgSy7YDzqxGwwuTXD2PBlhcwTnnR1x4i8DM2UZZDt6kP+YDQb8UQyKv8QTy0Mu8s/+Z9R0ZlJM4bugzJItCZLaMSIexW1Wdm3IrDGZ3dSD8YsCLKqkoer5jJs75ZJOkA10Xyz/PvPqYqcYnexVCPMNwxlnbEYAHWnB5fuctNFt1DsJKwabIX+9a6Lg+V1WXR+3coPpbeOocv7vVh5V/lyy0XZE9lwIQU4/6vcvLE2WoxL+i43uNHg5kWfKUnA7d78MIfaQuJ/PaZw== brent.groves@gmail.com\n"
        }
      ]
    }
  },
  ...
  "nodeResourceGroup": "MC_reports-aks_reports-aks_centralus",
 ...

az aks update --resource-group MyResourceGroup --name myManagedCluster --enable-aad --aad-admin-group-object-ids <id-1>,<id-2> [--aad-tenant-id <id>]

```

## Migrate legacy cluster to integration

If your cluster uses legacy Microsoft Entra integration, you can upgrade to AKS-managed Microsoft Entra integration through the az aks update command.

**Warning**\
Free tier clusters may experience API server downtime during the upgrade. We recommend upgrading during your nonbusiness hours. After the upgrade, the kubeconfig content changes. You need to run ``az aks get-credentials --resource-group <AKS resource group name> --name <AKS cluster name>`` to merge the new credentials into the kubeconfig file.

```bash
az aks update --resource-group myResourceGroup --name myManagedCluster --enable-aad --aad-admin-group-object-ids <id> [--aad-tenant-id <id>]
```
