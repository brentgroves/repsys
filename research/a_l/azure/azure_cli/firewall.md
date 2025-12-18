# **[Firewall rule](https://learn.microsoft.com/en-us/azure/azure-sql/database/firewall-configure?view=azuresql)**

## **[list rules](https://learn.microsoft.com/en-us/cli/azure/sql/server/firewall-rule#az-sql-server-firewall-rule-list)**

az sql server firewall-rule list [--ids]
                                 [--resource-group]
                                 [--server]
                                 [--subscription]

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

az sql server firewall-rule list -g $resourceGroup -s $server
[
  {
    "endIpAddress": "64.184.119.118",
    "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/repsys/providers/Microsoft.Sql/servers/repsys/firewallRules/AllowHomeIp",
    "name": "AllowHomeIp",
    "resourceGroup": "repsys",
    "startIpAddress": "64.184.119.118",
    "type": "Microsoft.Sql/servers/firewallRules"
  },
  {
    "endIpAddress": "64.184.36.240",
    "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/repsys/providers/Microsoft.Sql/servers/repsys/firewallRules/ClientIPAddress_2024-2-21_18-35-7",
    "name": "ClientIPAddress_2024-2-21_18-35-7",
    "resourceGroup": "repsys",
    "startIpAddress": "64.184.36.240",
    "type": "Microsoft.Sql/servers/firewallRules"
  }
]
```

## Create a firewall rule

```bash
az sql server firewall-rule create -g $resourceGroup -s $server -n AllowAlbion --start-ip-address 1.2.3.4 --end-ip-address 5.6.7.8
```
