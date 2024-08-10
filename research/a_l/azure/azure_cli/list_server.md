```bash
az sql server list --output json --query '[].{administratorLogin:administratorLogin,fullyQualifiedDomainName:fullyQualifiedDomainName,location:location,id:id,name:name,version:version}'
```
