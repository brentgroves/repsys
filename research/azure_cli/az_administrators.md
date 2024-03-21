# **[locate Global Administrators](https://stackoverflow.com/questions/74546149/get-azure-ad-administrator-programatically)**

You can use below MS Graph query to get the list the users with Global Administrator role:

```bash
GET https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments?$filter=roleDefinitionId eq '62e90394-69f5-4237-9190-012177145e10'
```

## To call the above query from Azure CLI, you can use az rest command like below

**[Login](az_login.md)**

```bash
az rest --method get --url "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments" --query "value[?contains(roleDefinitionId,'62e90394-69f5-4237-9190-012177145e10')].{id:id,PrincipalId:principalId,RoleDefinitionId:roleDefinitionId}"
```

## From Azure Portal

You can find all Global Administrators by using the Azure portal.
Login to the Azure portal <https://portal.azure.com>.
Select Azure Active Directory in the left side.
Select Roles and administrators.
