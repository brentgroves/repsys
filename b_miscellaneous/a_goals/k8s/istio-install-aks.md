# **[Azure](../../azure/mobexglobal.com/aks/install_istio_add_on_azure.md)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[Azure](https://preliminary.istio.io/latest/docs/setup/platform-setup/azure/)**

Azure offers a managed control plane add-on for the Azure Kubernetes Service (AKS), which you can use instead of installing Istio manually. Please refer to **[Deploy Istio-based service mesh add-on for Azure Kubernetes Service](https://learn.microsoft.com/azure/aks/istio-deploy-addon)** for details and instructions.

## AKS

You can create an AKS cluster via numerous means such as the az cli, the Azure portal, az cli with Bicep, or Terraform

For the az cli option, complete az login authentication OR use cloud shell, then run the following commands below.
