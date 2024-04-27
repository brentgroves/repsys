# Clean up resources

Use the following command to remove the resource group and all resources associated with it using the az group delete command - unless you have an ongoing need for these resources. Some of these resources may take a while to create, as well as to delete.

Azure CLI

```bash
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

# Verify all resources in repsys resource group
az resource list --resource-group $resourceGroup --output json --query '[].{name:name,type:type,id:id}'

# Delete all resources in repsys resource group
az group delete --name $resourceGroup
```