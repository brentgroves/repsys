# Create Login

<https://www.sqlnethub.com/blog/creating-azure-sql-database-logins-and-users/>
CREATE LOGIN kors
WITH PASSWORD = 't`8V8Uj\/*ht>;M6';

CREATE USER [kors]
FROM LOGIN [kors]
WITH DEFAULT_SCHEMA=myDW;
ALTER ROLE db_owner ADD MEMBER [kors];

## Changing the password of a login when logged in as the login

If you are attempting to change the password of the login that you're currently logged in with and you do not have the ALTER ANY LOGIN permission you must specify the OLD_PASSWORD option.

ALTER LOGIN kors WITH PASSWORD = 'WeDontSharePasswords1!' OLD_PASSWORD = 't`8V8Uj\/*ht>;M6';

Add the Login to the ##MS_DatabaseManager##, ##MS_LoginManager## and ##MS_DatabaseConnector## server level roles using the ALTER SERVER ROLE statement.

ALTER SERVER ROLE  MS_DatabaseManager  ADD MEMBER login;  

CREATE LOGIN test
WITH PASSWORD = 'Spirit1$!';
CREATE USER [test]
FROM LOGIN [test]
WITH DEFAULT_SCHEMA=myDW;
ALTER ROLE db_owner ADD MEMBER [test];
