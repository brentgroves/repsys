# az cli **[example queries](https://github.com/MicrosoftDocs/azure-docs-cli/blob/main/docs-ref-conceptual/includes/query-azure-cli-examples.md)**

## references

<https://learn.microsoft.com/en-us/cli/azure/query-azure-cli?tabs=concepts%2Cbash>

```bash
az account show --query "{tenantId:tenantId,subscriptionid:id}"
az ad app list --show-mine --query "[].{DisplayName:displayName,AppId:appId,RedirectURI:web.redirectUris}"

# filter returns less data from the internet but remember to escape $
az rest --method get --url "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments?\$filter=roleDefinitionId eq '62e90394-69f5-4237-9190-012177145e10'" --query "value[].{id:id,PrincipalId:principalId,RoleDefinitionId:roleDefinitionId}"

# query uses JMESPath and sorts through set after it has been downloaded from the internet
az rest --method get --url "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments" --query "value[?contains(roleDefinitionId,'62e90394-69f5-4237-9190-012177145e10')].{id:id,PrincipalId:principalId,RoleDefinitionId:roleDefinitionId}"


az vm list --resource-group QueryDemo --query "[?contains(storageProfile.osDisk.managedDisk.storageAccountType,'SSD')].{Name:name, Storage:storageProfile.osDisk.managedDisk.storageAccountType}"

###Remove api permissions: disable default exposed scope first
default_scope=$(az ad app show --id $clientid | jq '.oauth2Permissions[0].isEnabled = false' | jq -r '.oauth2Permissions')
az ad app update --id $clientid --set oauth2Permissions="$default_scope"
az ad app update --id $clientid --set oauth2Permissions="[]"

```
