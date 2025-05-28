--  drop users

ALTER ROLE db_owner DROP MEMBER [sJackson@linamar.com];
DROP USER [sJackson@linamar.com];

ALTER ROLE db_owner DROP MEMBER [keyoung@linamar.com];
DROP USER [keyoung@linamar.com];

ALTER ROLE db_owner DROP MEMBER [brcook@linamar.com];
DROP USER [brcook@linamar.com];

ALTER ROLE db_owner DROP MEMBER [jeikenberry@linamar.com];
DROP USER [jeikenberry@linamar.com];

-- logins

CREATE LOGIN [sJackson@linamar.com] FROM EXTERNAL PROVIDER;
CREATE LOGIN [keyoung@linamar.com] FROM EXTERNAL PROVIDER;
CREATE LOGIN [brcook@linamar.com] FROM EXTERNAL PROVIDER;
CREATE LOGIN [jeikenberry@linamar.com] FROM EXTERNAL PROVIDER;

select sp.name as login,
  sp.sid,
  sp.type_desc as login_type,
  sl.password_hash,
  sp.create_date,
  sp.modify_date,
  case when sp.is_disabled = 1 then 'Disabled'
            else 'Enabled' end as status
from sys.server_principals sp
  left join sys.sql_logins sl
  on sp.principal_id = sl.principal_id
where sp.type not in ('G', 'R')
order by sp.name;


-- create user with MFA entraid authentication
CREATE USER [sJackson@linamar.com] FROM LOGIN [sJackson@linamar.com]
ALTER ROLE db_owner ADD MEMBER [sJackson@linamar.com];

CREATE USER [keyoung@linamar.com] FROM LOGIN [keyoung@linamar.com]
ALTER ROLE db_owner ADD MEMBER [keyoung@linamar.com];

CREATE USER [brcook@linamar.com] FROM LOGIN [brcook@linamar.com]
ALTER ROLE db_owner ADD MEMBER [brcook@linamar.com];

CREATE USER [jeikenberry@linamar.com] FROM LOGIN [jeikenberry@linamar.com]
ALTER ROLE db_owner ADD MEMBER [jeikenberry@linamar.com];

select name as username,
  create_date,
  modify_date,
  type_desc as type,
  authentication_type_desc as authentication_type
from sys.database_principals
where type not in ('A', 'G', 'R', 'X')
  and sid is not null
  and name != 'guest'
order by username;
