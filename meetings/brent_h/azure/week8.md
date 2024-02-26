# Azure report system status

Good morning everyone,
I hope everyone is doing well this week and enjoying the spring weather :-)  This is the week 9 status of the Azure reporting system activity.  Please feel free to reach out to me anytime at home or work. If any of the following is not what you wish please say so :-)

Sincerely yours,
Brent G.
260-564-4868

This is a markdown file and can be viewed in Visual Studio Code or any online viewer such as https://markdownlivepreview.com/

## Plan

The goal is to get Azure resource costs to be approximately $500 per month. Also to request a resource group named "repsys" in which the user "bGroves@linamar.com" is assigned the "Contributor" role.

- Create an Excel file showing the estimated monthly cost of all Azure resources.
- Contact IT and IS team to gather any resource needs I may be unaware of.
- Back up our Azure SQL work and data warehouse database schemas to a  on-premise SQL Server 2022 running in a Docker container.
- Create a bash script and the Azure CLI to create all Azure resources.
- Conduct meetings as-needed with Brent H. Amir, Jarod, and Kevin.

## sample script

```bash
#!/usr/bin/env bash
pushd .
cd ~/src/repsys/research/azure_sql_server/linamar
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
echo "Creating $resourceGroup in $location..."
# https://learn.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az-group-create
az group create --name $resourceGroup --location "$location" --tags $tag
{
  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/repsys",
  "location": "eastus",
  "managedBy": null,
  "name": "repsys",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": {
    "create-and-configure-database": ""
  },
  "type": "Microsoft.Resources/resourceGroups"
}

# Add user to contributor role of resource
az role assignment create --assignee "bGroves@linamar.com" \
--role "Contributor" \
--scope "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/repsys"

# Verify role has been added
az role assignment list --resource-group repsys --assignee bGroves@linamar.com --output json --query '[].{principalName:principalName, roleDefinitionName:roleDefinitionName, scope:scope}'
popd
```

