# Azure SDK for GoLang

## references

<https://github.com/rchaganti/azure-go>
<https://ravichaganti.com/blog/2023-07-13-getting-started-with-azure-sdk-for-go/>

## Getting Started with Azure SDK for Go

Microsoft Azure provides vast services from basic computing to AI/ML. Azure Resource Manager (ARM) is our entry point to access and manage these services and provides a consistent management layer (APIs) that enables you to work with resources in Azure.

![alt](https://ravichaganti.com/images/arm-arch.png)

Source: **[Azure Resource Manager overview - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview)**

Any resource management request lands at the ARM, get authenticated, and enacted. As the diagram above indicates, there are many ways to interact with ARM. You can choose one or more ways to create and manage your Azure resources based on your preference. Azure Portal provides a click-to-manage experience which is good for managing fewer resources. You can use REST API to access the ARM management API layer directly and perform the CRUD operations against Azure resources. Azure PowerShell and Azure CLI allow you to automate the management tasks at the command-line. These are my preferred methods for working with Azure. These two methods use Azure SDKs to interact with the ARM APIs. Microsoft provides SDKs for different programming languages.

Any resource management request lands at the ARM, get authenticated, and enacted. As the diagram above indicates, there are many ways to interact with ARM. You can choose one or more ways to create and manage your Azure resources based on your preference. Azure Portal provides a click-to-manage experience which is good for managing fewer resources. You can use REST API to access the ARM management API layer directly and perform the CRUD operations against Azure resources. Azure PowerShell and Azure CLI allow you to automate the management tasks at the command-line. These are my preferred methods for working with Azure. These two methods use Azure SDKs to interact with the ARM APIs. Microsoft provides **[SDKs for different programming languages](https://azure.github.io/azure-sdk/releases/latest/)**.

I will write about Azure SDK for Go and my experience working with it in this series of articles. Microsoft has excellent documentation to get you started. This series of articles is about my notes and experiments as I learn to use **[Azure SDK for Go](https://learn.microsoft.com/en-us/azure/developer/go/overview)**.

Several packages are available as a part of the Azure SDK for Go. These packages are classified into two categories – management plane and data plane. The management plane packages are used to manage Azure resources. The data plane packages are used to interact with Azure resources. For example, the armresources package can be used to create resources and is a management plane package. Whereas the azcontainerregistry package, a data plane package, can be used to manage images in an Azure Container Registry. The minimum Go version you need for using these packages is 1.18.

All code samples presented in this series will be available at **[rchaganti/azure-go: Learning Azure SDK for Go (github.com)](https://github.com/rchaganti/azure-go)**

## The Development Container

To help you start with Azure SDK for Go, I suggest using a development environment that can be easily built or rebuilt. I will use a VS code dev container for all examples in this series of articles. Here is the devcontainer.json I am using.

```json
{
 "image": "mcr.microsoft.com/vscode/devcontainers/base",
 "customizations": {
  "vscode": {
   "settings": {},
   "extensions": [
    "golang.go",
    "ms-vscode.azure-account"
   ]
  }
 },
 "features": {
  "ghcr.io/devcontainers/features/go:1": {
              "version": "latest"
  },
  "azure-cli": {
   "version": "latest"
  }
 },
 "remoteUser": "vscode"
}
```

This dev container gives you the Go development environment along with Azure CLI. You will also get the Go and Azure account VS Code extensions.

## The First Step

Once the development environment is ready, you can create a project to implement the management or the data plane operations using the Azure SDK for Go.

```bash
pushd .
cd /src/repsys/volumes/go/tutorials/azure_sdk
mkdir 01-azstart
cd 01-azstart
go mod init azstart
touch main.go
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/azure_sdk/01-azstart
dirs -v
pushd +(count from end)
```

The above set of commands creates a directory and initializes a Go module called azstart. Once this folder structure is ready, you can download your project’s necessary Azure Go packages. This can be done using the go get command. For this quick start, you’ll need the azidentity and armresources packages.

```bash
go get -u "github.com/Azure/azure-sdk-for-go/sdk/azidentity"
go get -u "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/resources/armresources"
```

You must use go get and not just do a go mod tidy. There may be intellisense issues within VS Code otherwise.

Within main.go program; you can place the following code. This program lists all resource groups in an Azure subscription. Don’t bother about all the details for now. In the subsequent parts of this series, you will learn about different authentication methods and using different packages from the Azure SDK for Go.

```go
package main

import (
 "context"
 "encoding/json"
 "fmt"
 "log"

 "github.com/Azure/azure-sdk-for-go/sdk/azidentity"
 "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/resources/armresources"
)

const subscriptionID = "5073ff70820"

func main() {
 cred, err := azidentity.NewAzureCLICredential(nil)
 if err != nil {
  log.Fatal(err)
 }
 rcFactory, err := armresources.NewClientFactory(subscriptionID, cred, nil)
 if err != nil {
  log.Fatal(err)
 }
 rgClient := rcFactory.NewResourceGroupsClient()

 ctx := context.Background()
 resultPager := rgClient.NewListPager(nil)

 resourceGroups := make([]*armresources.ResourceGroup, 0)
 for resultPager.More() {
  pageResp, err := resultPager.NextPage(ctx)
  if err != nil {
   log.Fatal(err)
  }
  resourceGroups = append(resourceGroups, pageResp.ResourceGroupListResult.Value...)
 }

 jsonData, err := json.MarshalIndent(resourceGroups, "\t", "\t")
 if err != nil {
  log.Fatal(err)
 }

 fmt.Println(string(jsonData))

}
```

The NewAzureCLICredential method in the azidentity package enables you to access locally available Azure credentials within your Go program. You will learn more about this in the next article.

If you are using the VS Code dev environment provided at the beginning of this article, you will have Azure CLI within the environment. Before you run this program, you must use az login to authenticate with the Azure cloud.

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/azure_sdk
source ./vars.sh
# https://linuxize.com/post/bash-printf-command/

printf "subscription=%s \
\nlocation=%s \
\nresourceGroup=%s \
\ntag=%s \
\nserver=%s \
\ndatabase=%s \
\nlogin=%s \
\npassword=%s \
\nstartIp=%s \
\nendIp=%s" \
$subscription $location $resourceGroup \
$tag $server $database $login \
$password $startIp $endIp
az account set -s $subscription # ...or use 'az login'
echo "Using resource group $resourceGroup with login: $login, password: $password..."
cd 01-azstart
go run . | jq '.[].id'

```

<https://ravichaganti.com/blog/azure-sdk-for-go-authentication-methods-for-local-dev-environment/>
