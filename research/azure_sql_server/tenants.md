# My Azure tenant

<brent.groves@outlook.com>
Feb 9, 24:Spirit1$!
myDW/kors/t`8V8Uj\/*ht>;M6

an Azure data factory and SQL server it also had a 1 node aks but I deleted it because it was a couple hundred dollars per month.

## Azure development account

### Azure dev app

1da83025-d512-4625-bb74-4a1299952236
QFf8Q~W2W5VjfCYep6lw6pItIBzt7r8nVbyJxbeE

<https://developer.microsoft.com/>  

this is a moch company setup with many users.  

brentgroves  
<brentgroves@1hkt5t.onmicrosoft.com>  
<AlexW@1hkt5t.onmicrosoft.com>  
EAxejwisiakJip3  
domain:1hkt5t.onmicrosoft.com  

## Note

Both server names are identical for different tenants and subscriptions.  Maybe the API gateway takes care of this routing.

## mobex global

mgdw/mgadmin/WeDontSharePasswords1!
Server=tcp:mgsqlsrv.database.windows.net,1433;Initial Catalog=mgdw;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;

## <brent.groves@outlook.com>

myDW/kors/t`8V8Uj\/*ht>;M6
Server=tcp:mgsqlserver.database.windows.net,1433;Initial Catalog=myDW;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;

sqlpackage /a:export /ssn:tcp:mgsqlsrv.database.windows.net,1433 /sdn:myDW /p:TableData=Kors.email_hours /su:kors /sp:'t`8V8Uj\/*ht>;M6' /tf:/home/brent/backups/mydw/email_hours.bacpac /p:VerifyExtraction=false

```bash
*use the following T-SQL command to get your server name:
PRINT @@SERVERNAME
Abbreviations:
/Action: /a
/SourceServerName: /ssn
/SourceDatabaseName: /sdn
/SourceUser:         /su
/SourcePassword: /sp
/TargetFile:         /tf
/Properties:         /p
```

sqlpackage /a:export /ssn:tcp:mgsqlsrv.database.windows.net /sdn:mgdw /p:TableData=AlbSPS.Import /su:mgadmin /sp:WeDontSharePasswords1! /tf:/home/brent/backups/mgsqlsvr/mgdw.bacpac /p:VerifyExtraction=false
