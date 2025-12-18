# **[Contained database users](https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-configure?view=azuresql&tabs=azure-portal#contained-database-users)**

To create a contained database user for a Microsoft Entra user, enter the user principal name of the identity:

```bash
az ad user list --display-name "Brent Groves"
# id is sid in az sql server ad-admin list
"id": "175774d2-02a8-459c-9570-8ad0ec49ea7c",
"userPrincipalName": "bGroves@linamar.com"
az ad user list --display-name "Sam Jackson"
"userPrincipalName": "sJackson@linamar.com"
"id": "81164f77-0753-46ed-88d3-2589f6c8dbf9"
# 0x774F1681-5307-ED46-88D3-2589F6C8DBF9
az ad user list --display-name "Kevin Young"
"userPrincipalName": "keyoung@linamar.com"
"id": "8b3b77de-f636-4f14-924a-691517bacea9"
az ad user list --display-name "Brad D. Cook"
"id": "16818af3-5b9d-4ba4-9640-3b94edfb11cf"
"userPrincipalName": "brcook@linamar.com"
az ad user list --display-name "Jared Eikenberry"
"id": "19090977-9acc-4cd1-9a36-edfeeded35ed"
"userPrincipalName": "jeikenberry@linamar.com"
```

```sql
CREATE USER [sJackson@linamar.com] FROM EXTERNAL PROVIDER;
ALTER ROLE db_owner ADD MEMBER [sJackson@linamar.com];  

CREATE USER [keyoung@linamar.com] FROM EXTERNAL PROVIDER;
ALTER ROLE db_owner ADD MEMBER [keyoung@linamar.com];  

CREATE USER [brcook@linamar.com] FROM EXTERNAL PROVIDER;
ALTER ROLE db_owner ADD MEMBER [brcook@linamar.com];  

CREATE USER [jeikenberry@linamar.com] FROM EXTERNAL PROVIDER;
ALTER ROLE db_owner ADD MEMBER [jeikenberry@linamar.com];  

```
