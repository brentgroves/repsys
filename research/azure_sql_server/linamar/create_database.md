# Create database

## references

<https://learn.microsoft.com/en-us/azure/azure-sql/database/scripts/create-and-configure-database-cli?view=azuresql>

```bash
# Create a single database and configure a firewall rule
# Variable block
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

# Verify resource group
az group show --resource-group $resourceGroup

# Add user to contributor role of resource
az role assignment create --assignee "bGroves@linamar.com" \
--role "Contributor" \
--scope "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/repsys"

# Verify role has been added
az role assignment list --resource-group repsys --assignee bGroves@linamar.com --output json --query '[].{principalName:principalName, roleDefinitionName:roleDefinitionName, scope:scope}'
az role assignment list --assignee bgroves@mobexglobal.com --output json --query '[].{principalName:principalName, roleDefinitionName:roleDefinitionName, scope:scope}'


echo "Creating $server in $location..."
# https://learn.microsoft.com/en-us/cli/azure/sql/server?view=azure-cli-latest#az-sql-server-create
# requirements: SQL authentication
az sql server create --name $server --resource-group $resourceGroup --location "$location" --admin-user $login --admin-password $password
{
  "administratorLogin": "mgadmin",
  "administratorLoginPassword": null,
  "administrators": null,
  "externalGovernanceStatus": "Disabled",
  "federatedClientId": null,
  "fullyQualifiedDomainName": "repsys.database.windows.net",
  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/repsys/providers/Microsoft.Sql/servers/repsys",
  "identity": null,
  "isIPv6Enabled": null,
  "keyId": null,
  "kind": "v12.0",
  "location": "eastus",
  "minimalTlsVersion": "None",
  "name": "repsys",
  "primaryUserAssignedIdentityId": null,
  "privateEndpointConnections": [],
  "publicNetworkAccess": "Enabled",
  "resourceGroup": "repsys",
  "restrictOutboundNetworkAccess": "Disabled",
  "state": "Ready",
  "tags": null,
  "type": "Microsoft.Sql/servers",
  "version": "12.0",
  "workspaceFeature": null
}
az sql server list --output json --query '[].{administratorLogin:administratorLogin,fullyQualifiedDomainName:fullyQualifiedDomainName,location:location,id:id,name:name,version:version}'
[
  {
    "administratorLogin": "mgadmin",
    "fullyQualifiedDomainName": "repsys.database.windows.net",
    "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/repsys/providers/Microsoft.Sql/servers/repsys",
    "location": "eastus",
    "name": "repsys",
    "version": "12.0"
  }
]

# https://learn.microsoft.com/en-us/answers/questions/995338/sql-azure-version
# Azure SQL Database has its version number that is not related to SQL Server version numbers. However it runs the latest features and updates that run the latest version of SQL Server. 

echo "Configuring firewall..."
az sql server firewall-rule create --resource-group $resourceGroup --server $server -n AllowWorkIp --start-ip-address $startIp --end-ip-address $endIp

az sql server firewall-rule create --resource-group $resourceGroup --server $server -n AllowHomeIp --start-ip-address 64.184.119.118 --end-ip-address 64.184.119.118

{
  "endIpAddress": "64.184.36.240",
  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/repsys/providers/Microsoft.Sql/servers/repsys/firewallRules/AllowYourIp",
  "name": "AllowWorkIp",
  "resourceGroup": "repsys",
  "startIpAddress": "64.184.36.240",
  "type": "Microsoft.Sql/servers/firewallRules"
}

az sql server firewall-rule list --resource-group repsys --server repsys --output json --query '[].{name:name,id:id,starIpAddress:startIpAddress,endIpAddress:endIpAddress}'

echo "Creating $database on $server..."
# https://learn.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-create
# az sql db list-editions -l eastus --service-objective S1 --show-details max-size

# Create a Standard 20 DTU database
az sql db create -g $resourceGroup -s $server -n $database --edition Standard --capacity 20 --backup-storage-redundancy Geo --max-size 20GB

{
  "autoPauseDelay": null,
  "availabilityZone": "NoPreference",
  "catalogCollation": "SQL_Latin1_General_CP1_CI_AS",
  "collation": "SQL_Latin1_General_CP1_CI_AS",
  "createMode": null,
  "creationDate": "2024-02-21T23:29:22.433000+00:00",
  "currentBackupStorageRedundancy": "Geo",
  "currentServiceObjectiveName": "S1",
  "currentSku": {
    "capacity": 20,
    "family": null,
    "name": "Standard",
    "size": null,
    "tier": "Standard"
  },
  "databaseId": "850684a6-e516-4857-8f09-747fd1b81a6e",
  "defaultSecondaryLocation": "westus",
  "earliestRestoreDate": null,
  "edition": "Standard",
  "elasticPoolId": null,
  "elasticPoolName": null,
  "encryptionProtector": null,
  "encryptionProtectorAutoRotation": null,
  "failoverGroupId": null,
  "federatedClientId": null,
  "freeLimitExhaustionBehavior": null,
  "highAvailabilityReplicaCount": null,
  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/repsys/providers/Microsoft.Sql/servers/repsys/databases/rsdw",
  "identity": null,
  "isInfraEncryptionEnabled": false,
  "keys": null,
  "kind": "v12.0,user",
  "ledgerOn": false,
  "licenseType": null,
  "location": "eastus",
  "longTermRetentionBackupResourceId": null,
  "maintenanceConfigurationId": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default",
  "managedBy": null,
  "manualCutover": null,
  "maxLogSizeBytes": null,
  "maxSizeBytes": 21474836480,
  "minCapacity": null,
  "name": "rsdw",
  "pausedDate": null,
  "performCutover": null,
  "preferredEnclaveType": null,
  "readScale": "Disabled",
  "recoverableDatabaseId": null,
  "recoveryServicesRecoveryPointId": null,
  "requestedBackupStorageRedundancy": "Geo",
  "requestedServiceObjectiveName": "S1",
  "resourceGroup": "repsys",
  "restorableDroppedDatabaseId": null,
  "restorePointInTime": null,
  "resumedDate": null,
  "sampleName": null,
  "secondaryType": null,
  "sku": {
    "capacity": 20,
    "family": null,
    "name": "Standard",
    "size": null,
    "tier": "Standard"
  },
  "sourceDatabaseDeletionDate": null,
  "sourceDatabaseId": null,
  "sourceResourceId": null,
  "status": "Online",
  "tags": null,
  "type": "Microsoft.Sql/servers/databases",
  "useFreeLimit": null,
  "zoneRedundant": false
}

az sql db list --resource-group repsys --server repsys --output json --query '[].{currentSku:currentSku,id:id,databaseId:databaseId,maxSizeBytes:maxSizeBytes}'
# Verify all resources in repsys resource group
az resource list --resource-group $resourceGroup --output json --query '[].{name:name,type:type,id:id}'
[
  {
    "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/repsys/providers/Microsoft.Sql/servers/repsys",
    "name": "repsys",
    "type": "Microsoft.Sql/servers"
  },
  {
    "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/repsys/providers/Microsoft.Sql/servers/repsys/databases/master",
    "name": "repsys/master",
    "type": "Microsoft.Sql/servers/databases"
  },
  {
    "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/repsys/providers/Microsoft.Sql/servers/repsys/databases/rsdw",
    "name": "repsys/rsdw",
    "type": "Microsoft.Sql/servers/databases"
  }
]

az sql db restore --dest-name MyDest --edition GeneralPurpose --name MyAzureSQLDatabase --resource-group MyResourceGroup --server myserver --subscription MySubscription --time "2018-05-20T05:34:22" --backup-storage-redundancy Geo

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

```

<https://portal.azure.com/#home>
