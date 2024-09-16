# **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

In this tutorial you will learn how to deploy and configure cert-manager on Azure Kubernetes Service (AKS) and how to deploy an HTTPS web server and make it available on the Internet. You will learn how to configure cert-manager to get a signed certificate from Let's Encrypt, which will allow clients to connect to your HTTPS website securely. You will configure cert-manager to use the Let's Encrypt DNS-01 challenge protocol with Azure DNS, using workload identity federation to authenticate to Azure.

## Part 1

In the first part of this tutorial you will learn the basics required to deploy an HTTPS website on an Azure Kubernetes cluster using cert-manager to create the SSL certificate for the web server. You will create a DNS domain for your website, create an Azure Kubernetes cluster, install cert-manager, create an SSL certificate and then deploy a web server which responds to HTTPS requests from clients on the Internet. But the SSL certificate in part 1 is only for testing purposes.

In part 2 you will learn how to configure cert-manager to use Let's Encrypt and Azure DNS to create a trusted SSL certificate which you can use in production.

## Configure the Azure CLI (az)

If your have not already done so, download and install the Azure CLI (az).

Set up the az command for interactive use:

```az init```

Log in, if you have not already done so:

```az login```

Set the default resource group and location:

You can modify **[aks_vars.sh](../../../../../azure/mobexglobal.com/aks/aks_vars.sh)**

```bash
export AZURE_DEFAULTS_GROUP=your-resource-group  # ❗ Your Azure resource group
export AZURE_DEFAULTS_LOCATION=eastus2   # ❗ Your Azure location.
```

ℹ️ You will need an az version >=2.40.0. Run az version to print the current version.

ℹ️ When you run az init, choose "Optimize for interaction" when prompted.

ℹ️ When you run az login, a web browser will be opened at <https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize>. Continue the login in the web browser and then return to your terminal.

📖 Read the Azure Command-Line Interface (CLI) documentation.

📖 Read CLI configuration values and environment variables for more ways to configure the az defaults.
