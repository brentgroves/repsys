# **[List Azure SQL db](https://learn.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-list)**

## reference

- **[create Azure SQL db](https://learn.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-create)**

## List Azure SQL db with az CLI

```bash
az sql db list [--elastic-pool]
               [--ids]
               [--resource-group]
               [--server]
               [--subscription]
```

## Examples

List databases on a server or elastic pool. (autogenerated)

```bash
az login
# A web browser has been opened at <https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize>. Please continue the login in the web browser. If no web browser is available or if the web browser fails to open, use device code flow with `az login --use-device-code`.
# The following tenants don't contain accessible subscriptions. Use 'az login --allow-no-subscriptions' to have tenant level access.
# ceadc058-fad7-4b6b-830b-00ac739654f0 'LinamarCorporation'
# No subscriptions found for <bGroves@linamar.com>.

pushd .
cd ~/src/azure/sql_db
source ./mobex_vars.sh
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

az sql db list --resource-group $resourceGroup --server $server --output json --query '[].{currentSku:currentSku}
databaseId
id
az sql server list --output json --query '[].{administratorLogin:administratorLogin,fullyQualifiedDomainName:fullyQualifiedDomainName,location:location,id:id,name:name,version:version}'

```