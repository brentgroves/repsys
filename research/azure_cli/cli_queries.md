# az cli **[example queries](https://github.com/MicrosoftDocs/azure-docs-cli/blob/main/docs-ref-conceptual/includes/query-azure-cli-examples.md)**

```bash
az account show --query "{tenantId:tenantId,subscriptionid:id}"

###Remove api permissions: disable default exposed scope first
default_scope=$(az ad app show --id $clientid | jq '.oauth2Permissions[0].isEnabled = false' | jq -r '.oauth2Permissions')
az ad app update --id $clientid --set oauth2Permissions="$default_scope"
az ad app update --id $clientid --set oauth2Permissions="[]"

```
