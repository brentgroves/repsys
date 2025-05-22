# current logged in user

az account show

```bash

# az account show
# {
#    "environmentName": "AzureCloud",
#    "homeTenantId": "Your tenant ID",
#    "id": "Subscriptio ID",
#    "isDefault": true,
#    "managedByTenants": [],
#    "name": "Subscription Name",
#    "state": "Enabled",
#    "tenantId": "tenant ID",
#    "user": {
#     "name": "user logged in email id or username",
#     "type": "user"
#    }
# }
az account show
{
  "environmentName": "AzureCloud",
  "homeTenantId": "ceadc058-fad7-4b6b-830b-00ac739654f0",
  "id": "6fdb2836-d884-43d9-806d-78e653dbe236",
  "isDefault": true,
  "managedByTenants": [],
  "name": "LinamarCorporation Special Projects EA",
  "state": "Enabled",
  "tenantDefaultDomain": "LinamarCorporation.onmicrosoft.com",
  "tenantDisplayName": "LinamarCorporation",
  "tenantId": "ceadc058-fad7-4b6b-830b-00ac739654f0",
  "user": {
    "name": "<bGroves@linamar.com>",
    "type": "user"
  }
}
```

## az ad user show

Show details for a Azure Active Directory user.

```bash
# list users with global admin role
az rest --method get --url "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments" --query "value[?contains(roleDefinitionId,'62e90394-69f5-4237-9190-012177145e10')].{id:id,PrincipalId:principalId,RoleDefinitionId:roleDefinitionId}"

# az ad user show --id myuser@contoso.com
az ad user show --id bGroves@linamar.com
{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users/$entity",
  "businessPhones": [],
  "displayName": "Brent Groves",
  "givenName": "Brent",
  "id": "175774d2-02a8-459c-9570-8ad0ec49ea7c",
  "jobTitle": "IS Administrator",
  "mail": "Brent.Groves@Linamar.com",
  "mobilePhone": null,
  "officeLocation": "Linamar",
  "preferredLanguage": null,
  "surname": "Groves",
  "userPrincipalName": "bGroves@linamar.com"
}

# az ad user show --id "9e3c912d-303c-4088-9c22-bfc2bdbc8430"
az ad user show --id "175774d2-02a8-459c-9570-8ad0ec49ea7c"
