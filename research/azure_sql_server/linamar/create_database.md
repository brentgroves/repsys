# Create database

## references

<https://learn.microsoft.com/en-us/azure/azure-sql/database/scripts/create-and-configure-database-cli?view=azuresql>

```bash
# Create a single database and configure a firewall rule
# Variable block
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
az group create --name $resourceGroup --location "$location" --tags $tag
echo "Creating $server in $location..."
# https://learn.microsoft.com/en-us/cli/azure/sql/server?view=azure-cli-latest#az-sql-server-create
# requirements: SQL authentication
az sql server create --name $server --resource-group $resourceGroup --location "$location" --admin-user $login --admin-password $password

{
  "administratorLogin": "bgroves@mobexglobal.com",
  "administratorLoginPassword": null,
  "administrators": null,
  "externalGovernanceStatus": "Disabled",
  "federatedClientId": null,
  "fullyQualifiedDomainName": "mgsqlsvr.database.windows.net",
  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/kors/providers/Microsoft.Sql/servers/mgsqlsvr",
  "identity": null,
  "isIPv6Enabled": null,
  "keyId": null,
  "kind": "v12.0",
  "location": "eastus",
  "minimalTlsVersion": "None",
  "name": "mgsqlsvr",
  "primaryUserAssignedIdentityId": null,
  "privateEndpointConnections": [],
  "publicNetworkAccess": "Enabled",
  "resourceGroup": "kors",
  "restrictOutboundNetworkAccess": "Disabled",
  "state": "Ready",
  "tags": null,
  "type": "Microsoft.Sql/servers",
  "version": "12.0",
  "workspaceFeature": null
}

# Can I drop my tenant and create Azure SQL database on dev tenant? No this is not supported
# https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/role-based-access-control/role-assignments-list-cli.md
az role assignment list --all --assignee bgroves@mobexglobal.com --output json --query '[].{principalName:principalName, roleDefinitionName:roleDefinitionName, scope:scope}'
[
  {
    "principalName": "bgroves@mobexglobal.com",
    "roleDefinitionName": "Contributor",
    "scope": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a"
  }
]
Add contributor role to repsys resource group.
echo "Configuring firewall..."
az sql server firewall-rule create --resource-group $resourceGroup --server $server -n AllowYourIp --start-ip-address $startIp --end-ip-address $endIp
# https://learn.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-create
echo "Creating $database on $server..."
# Create a Standard SO 10 DTU database
az sql db create -g $resourceGroup -s $server -n $database --edition Standard --service-objective S1 --backup-storage-redundancy Geo --max-size 20GB

az sql db list-editions -l westus --service-objective P1 --show-details max-size

az sql db update -g mygroup -s myserver -n mydb --edition Standard --capacity 10 --max-size 250GB

# create basic db
az sql db create --resource-group $resourceGroup --server $server --name $database --sample-name AdventureWorksLT --edition GeneralPurpose --family Gen5 --capacity 2 --zone-redundant true # zone redundancy is only supported on premium and business critical service tiers

az sql db restore --dest-name MyDest --edition GeneralPurpose --name MyAzureSQLDatabase --resource-group MyResourceGroup --server myserver --subscription MySubscription --time "2018-05-20T05:34:22" --backup-storage-redundancy Geo
```

<https://portal.azure.com/#home>