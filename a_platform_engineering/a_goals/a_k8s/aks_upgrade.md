# **[Upgrade an Azure Kubernetes Service (AKS) cluster](https://learn.microsoft.com/en-us/azure/aks/upgrade-aks-cluster?tabs=azure-cli)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

Part of the AKS cluster lifecycle involves performing periodic upgrades to the latest Kubernetes version. It's important you apply the latest security releases and upgrades to get the latest features. This article shows you how to check for and apply upgrades to your AKS cluster.

## Kubernetes version upgrades

When you upgrade a supported AKS cluster, you can't skip Kubernetes minor versions. You must perform all upgrades sequentially by major version number. For example, upgrades between 1.14.x -> 1.15.x or 1.15.x -> 1.16.x are allowed. 1.14.x -> 1.16.x isn't allowed. You can only skip multiple versions when upgrading from an unsupported version back to a supported version. For example, you can perform an upgrade from an unsupported 1.10.x to a supported 1.12.x if available.

When you perform an upgrade from an unsupported version that skips two or more minor versions, the upgrade has no guarantee of functionality and is excluded from the service-level agreements and limited warranty. If your version is significantly out of date, we recommend you recreate your cluster instead.

## Before you begin

- If you're using the Azure CLI, this article requires Azure CLI version 2.34.1 or later. Run az --version to find the version. If you need to install or upgrade, see Install Azure CLI.
- If you're using Azure PowerShell, this article requires Azure PowerShell version 5.9.0 or later. Run Get-InstalledModule -Name Az to find the version. If you need to install or upgrade, see Install Azure PowerShell.
- Performing upgrade operations requires the Microsoft.ContainerService/managedClusters/agentPools/write RBAC role. For more on Azure RBAC roles, see the Azure resource provider operations.
- Starting with 1.30 kubernetes version and 1.27 LTS versions the beta APIs will be disabled by default when you upgrade to them.

## Warning

An AKS cluster upgrade triggers a cordon and drain of your nodes. If you have a low compute quota available, the upgrade might fail. For more information, see increase quotas.

## Check for available AKS cluster upgrades

## Note

To stay up to date with AKS fixes, releases, and updates, see the **[AKS release tracker](https://learn.microsoft.com/en-us/azure/aks/release-tracker)**.

## **[Login](../../azure/mobexglobal.com/login.md)**

Check which Kubernetes releases are available for your cluster using the az aks get-upgrades command.

```bash
az aks get-upgrades --resource-group reports-aks --name reports-aks --output table
Name     ResourceGroup    MasterVersion    Upgrades
-------  ---------------  ---------------  ------------------------------------------------------------------
default  reports-aks      1.25.5           1.28.0, 1.28.3, 1.28.5, 1.28.9, 1.28.10, 1.28.11, 1.28.12, 1.28.13
```

## Troubleshoot AKS cluster upgrade error messages

The following example output means the appservice-kube extension isn't compatible with your Azure CLI version (a minimum of version 2.34.1 is required):

```The 'appservice-kube' extension is not compatible with this version of the CLI.
You have CLI core version 2.0.81 and this extension requires a min of 2.34.1.
Table output unavailable. Use the --query option to specify an appropriate query. Use --debug for more info.
```

## Upgrade an AKS cluster

During the cluster upgrade process, AKS performs the following operations:

- Add a new buffer node (or as many nodes as configured in **[max surge](https://learn.microsoft.com/en-us/azure/aks/upgrade-aks-cluster?tabs=azure-cli#customize-node-surge-upgrade)**) to the cluster that runs the specified Kubernetes version.
- **[Cordon and drain](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/)** one of the old nodes to minimize disruption to running applications. If you're using max surge, it cordons and drains as many nodes at the same time as the number of buffer nodes specified.
- For long running pods, you can configure the node drain timeout, which allows for custom wait time on the eviction of pods and graceful termination per node. If not specified, the default is 30 minutes. Minimum allowed timeout value is 5 minutes.
- When the old node is fully drained, it's reimaged to receive the new version and becomes the buffer node for the following node to be upgraded.
- Optionally, you can set a duration of time to wait between draining a node and proceeding to reimage it and move on to the next node. A short interval allows you to complete other tasks, such as checking application health from a Grafana dashboard during the upgrade process. We recommend a short timeframe for the upgrade process, as close to 0 minutes as reasonably possible. Otherwise, a higher node soak time affects how long before you discover an issue. The minimum soak time value is 0 minutes, with a maximum of 30 minutes. If not specified, the default value is 0 minutes.
- This process repeats until all nodes in the cluster are upgraded.
- At the end of the process, the last buffer node is deleted, maintaining the existing agent node count and zone balance.

AKS configures upgrades to surge with one extra node by default. A default value of one for the max surge settings enables AKS to minimize workload disruption by creating an extra node before the cordon/drain of existing applications to replace an older versioned node. You can customize the max surge value per node pool. When you increase the max surge value, the upgrade process completes faster, and you might experience disruptions during the upgrade process.

**Note**\
If no patch is specified, the cluster automatically upgrades to the specified minor version's latest GA patch. For example, setting --kubernetes-version to 1.28 results in the cluster upgrading to 1.28.9.

For more information, see **[Supported Kubernetes minor version upgrades in AKS](https://learn.microsoft.com/en-us/azure/aks/supported-kubernetes-versions#alias-minor-version)**.

To see what patch you're on, run the az aks show --resource-group myResourceGroup --name myAKSCluster command. The currentKubernetesVersion property shows the whole Kubernetes version.

```bash
az aks show --resource-group reports-aks --name reports-aks --output table
...
  "currentKubernetesVersion": "1.25.5",
...
```

## 1. Upgrade your cluster using the az aks upgrade command

```bash
az aks show --resource-group reports-aks --name reports-aks --output table
Name         Location    ResourceGroup    KubernetesVersion    CurrentKubernetesVersion    ProvisioningState    Fqdn
-----------  ----------  ---------------  -------------------  --------------------------  -------------------  --------------------------------------------------------------
reports-aks  centralus   reports-aks      1.29.8               1.29.8                      Succeeded            reports-ak-reports-aks-f7d0cf-acy9oemr.hcp.centralus.azmk8s.io

az aks get-upgrades --resource-group reports-aks --name reports-aks --output table
Name     ResourceGroup    MasterVersion    Upgrades
-------  ---------------  ---------------  --------------------------------------
default  reports-aks      1.29.8           1.30.0, 1.30.1, 1.30.2, 1.30.3, 1.30.4

az aks upgrade \
    --resource-group reports-aks \
    --name reports-aks \
    --kubernetes-version 1.30.4
Name     ResourceGroup    MasterVersion    Upgrades
-------  ---------------  ---------------  --------------------------------------
default  reports-aks      1.29.8           1.30.0, 1.30.1, 1.30.2, 1.30.3, 1.30.4

az aks show --resource-group reports-aks --name reports-aks --output table

The behavior of this command has been altered by the following extension: aks-preview
Name         Location    ResourceGroup    KubernetesVersion    CurrentKubernetesVersion    ProvisioningState    Fqdn
-----------  ----------  ---------------  -------------------  --------------------------  -------------------  --------------------------------------------------------------
reports-aks  centralus   reports-aks      1.30.4               1.30.4                      Succeeded            reports-ak-reports-aks-f7d0cf-acy9oemr.hcp.centralus.azmk8s.io

az aks get-upgrades --resource-group reports-aks --name reports-aks --output table
Table output unavailable. Use the --query option to specify an appropriate query. Use --debug for more info.

# No more updates available
```
