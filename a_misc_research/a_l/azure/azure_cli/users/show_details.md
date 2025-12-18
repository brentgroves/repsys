# **[Show details for a Azure Active Directory user](https://learn.microsoft.com/en-us/cli/azure/ad/user?view=azure-cli-latest#az-ad-user-show)**

az ad user show
Show details for a Azure Active Directory user.

```bash
# list users with global admin role
az rest --method get --url "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments" --query "value[?contains(roleDefinitionId,'62e90394-69f5-4237-9190-012177145e10')].{id:id,PrincipalId:principalId,RoleDefinitionId:roleDefinitionId}"

az ad user show --id bGroves@linamar.com
81164F77-0753-46ED-88D3-2589F6C8DBF9
81164f77-0753-46ed-88d3-2589f6c8dbf9
az ad user show --id "9e3c912d-303c-4088-9c22-bfc2bdbc8430"
{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users/$entity",
  "businessPhones": [],
  "displayName": "Jared Davis",
  "givenName": "Jared",
  "id": "9e3c912d-303c-4088-9c22-bfc2bdbc8430",
  "jobTitle": "IT Manager",
  "mail": "jdavis@mobexglobal.com",
  "mobilePhone": null,
  "officeLocation": null,
  "preferredLanguage": null,
  "surname": "Davis",
  "userPrincipalName": "jdavis@mobexglobal.com"
}

az ad user show --id "095b2d59-e533-4180-a71f-c6093615bb88"


```
