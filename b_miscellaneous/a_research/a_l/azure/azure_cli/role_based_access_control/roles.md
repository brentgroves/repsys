# **[role based access control](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference)**

In Microsoft Entra ID, if another administrator or non-administrator needs to manage Microsoft Entra resources, you assign them a Microsoft Entra role that provides the permissions they need. For example, you can assign roles to allow adding or changing users, resetting user passwords, managing user licenses, or managing domain names.

This article lists the Microsoft Entra built-in roles you can assign to allow management of Microsoft Entra resources. For information about how to assign roles, see Assign Microsoft Entra roles to users. If you are looking for roles to manage Azure resources, see Azure built-in roles.

## **[All roles](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#all-roles)**

- **Application Administrator** Can create and manage all aspects of app registrations and enterprise apps. RoleDefinitionId:9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3

```bash
az rest --method get --url "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments?$filter=roleDefinitionId eq '9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3'"
```

![role](https://i.stack.imgur.com/UtzvF.png)

- **Global Administrator**

```bash
az rest --method get --url "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments" --query "value[?contains(roleDefinitionId,'62e90394-69f5-4237-9190-012177145e10')].{id:id,PrincipalId:principalId,RoleDefinitionId:roleDefinitionId}"

[
  {
    "PrincipalId": "9accfa89-9872-4b66-9d70-b75f2342f3ba",
    "RoleDefinitionId": "62e90394-69f5-4237-9190-012177145e10",
    "id": "lAPpYvVpN0KRkAEhdxReEIn6zJpymGZLnXC3XyNC87o-1"
  }
]

az ad user show --id "9accfa89-9872-4b66-9d70-b75f2342f3ba"
{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users/$entity",
  "businessPhones": [
    "12605644868"
  ],
  "displayName": "Brent Groves",
  "givenName": "Brent",
  "id": "9accfa89-9872-4b66-9d70-b75f2342f3ba",
  "jobTitle": null,
  "mail": "brentgroves@1hkt5t.onmicrosoft.com",
  "mobilePhone": null,
  "officeLocation": null,
  "preferredLanguage": null,
  "surname": "Groves",
  "userPrincipalName": "brentgroves@1hkt5t.onmicrosoft.com"
}

```
