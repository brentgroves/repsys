# Father's direction

I love you and will help you to have a loving heart!  I will give you courage and help you to bear each trial and endure every hardship my son.  Do not forget that you are part of a community and I want you to learn to love each person, creature, and even the land where you live.

The world's love is performance based, but my love is unconditional. The world's system promotes fear and says you must perform better than your neighbor.  I say help your neighbor and especially help the ones that are struggling. Do not worry about your own status.  Do not promote yourself instead think of others and help them in their work.

Good morning dear ones,
I hope everyone is doing well, staying healthy, and enjoying the wonderful spring weather we are having!  Please don't hesitate to reach out to me anytime at home or work. If any of the following is not what you wish please say so :-)

Sincerely yours,
Brent G.
260-564-4868

This is a markdown file and can be viewed in Visual Studio Code or any online viewer such as https://markdownlivepreview.com/

## Plan

The goal is to get Azure resource costs to be approximately $500 per month. Also to request a resource group named "repsys" in which the user "bGroves@linamar.com" is assigned the "Contributor" role.

- Create an Excel file showing the estimated monthly cost of all Azure resources.
- Contact IT and IS team to gather any resource needs I may be unaware of.
- Back up our Azure SQL work and data warehouse database schemas to an  on-premise SQL Server 2022 running in a Docker container.
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

## Backup / Restore Azure SQL MI

- Can not use sqlpackage to do this.
- **[T-SQL syntax not supported in Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/transact-sql-tsql-differences-sql-server?view=azuresql#transact-sql-syntax-not-supported-in-azure-sql-database)**

## **[Run SQL Server 2022 in docker](https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver16&preserve-view=true&tabs=cli&pivots=cs1-bash)**

On-premises reporting with **[Power BI Report Server](https://powerbi.microsoft.com/en-us/report-server/)**

**[How to embed a Power BI report in a web app](https://learn.microsoft.com/en-us/power-bi/collaborate-share/service-embed-secure)**
Licensing
To view the embedded report, you need either a Power BI Pro or Premium Per User (PPU) license. Or, the content needs to be in a workspace that's in a Power BI Premium capacity (EM or P SKU).

**[Why did Microsot make an on premise Power BI report Server](https://radacad.com/power-bi-report-server-power-bi-in-on-premises-world)**

**[How can you combine Python an PowerBI](https://realpython.com/power-bi-python/)**

**[The best open source alternatives to PowerBI](https://alternativeto.net/software/power-bi-for-office-365/?license=opensource)**

**[Metabase](https://alternativeto.net/software/metabase/about/)**
