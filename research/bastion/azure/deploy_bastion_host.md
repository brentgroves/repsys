# Bastion Host

## references

<https://learn.microsoft.com/en-us/azure/bastion/tutorial-create-host-portal>

## Tutorial: Deploy Azure Bastion by using specified settings

This tutorial helps you deploy Azure Bastion from the Azure portal by using your own manual settings and a SKU (product tier) that you specify. The SKU determines the features and connections that are available for your deployment. For more information about SKUs, see Configuration settings - SKUs.

In the Azure portal, when you use the Configure manually option to deploy Bastion, you can specify configuration values such as instance counts and SKUs at the time of deployment. After Bastion is deployed, you can use SSH or RDP to connect to virtual machines (VMs) in the virtual network via Bastion using the private IP addresses of the VMs. When you connect to a VM, it doesn't need a public IP address, client software, an agent, or a special configuration.

The following diagram shows the architecture of Bastion.

![](https://learn.microsoft.com/en-us/azure/bastion/media/create-host/host-architecture.png)

In this tutorial, you deploy Bastion by using the Standard SKU. You adjust host scaling (instance count), which the Standard SKU supports. If you use a lower SKU for the deployment, you can't adjust host scaling.

After the deployment is complete, you connect to your VM via private IP address. If your VM has a public IP address that you don't need for anything else, you can remove it.

In this tutorial, you learn how to:

Deploy Bastion to your virtual network.
Connect to a virtual machine.
Remove the public IP address from a virtual machine.
