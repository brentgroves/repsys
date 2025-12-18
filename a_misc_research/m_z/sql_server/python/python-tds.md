# **[Python TDS](https://python-tds.readthedocs.io/en/latest/)

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## Pytds - Microsoft SQL Server database adapter for Python

Pytds is the top to bottom pure Python TDS implementation, that means cross-platform, and no dependency on ADO or FreeTDS. It supports large parameters (>4000 characters), MARS, timezones, new date types (datetime2, date, time, datetimeoffset). Even though it is implemented in Python performance is comparable to ADO and FreeTDS bindings.

It also supports Python 3.

## Connection to Mirrored Servers

When MSSQL server is setup with mirroring you should connect to it using two parameters of pytds.connect(), one parameter is server this should be a main server and parameter failover_partner should be a mirror server. See also MSDN article.

## Table Valued Parameters

Here is example of using TVP:

with conn.cursor() as cur:
    cur.execute('CREATE TYPE dbo.CategoryTableType AS TABLE ( CategoryID int, CategoryName nvarchar(50) )')
    conn.commit()

    tvp = pytds.TableValuedParam(type_name='dbo.CategoryTableType', rows=rows_gen())
    cur.execute('SELECT * FROM %s', (tvp,))

## Using Binary Parameters

To use a parameter that is of a binary or varbinary type, you need to wrap the value with pytds.Binary(). This function accepts bytes objects so be sure to convert buffers or file-like objects to bytes first.

Examples of wrapping various kinds of bytes representations:

```python
pytds.Binary(b'')
pytds.Binary(b'\x00\x01\x02')
pytds.Binary(b'x' * 9000)
An example of how you might store an image from a file in a varbinary(MAX) field:

image=Image.open(image_path)
with io.BytesIO() as output:
    image.save(output, format="jpeg")
    image_data = pytds.Binary(output.getvalue())
with pytds.connect(dns='your connection info') as conn:
    with conn.cursor() as cur:
        cur.execute("insert into table_name (text_field, binary_field) values (%s, %s)", (image_name, image_data))
    conn.commit()
```

## Testing

To run tests you need to have tox installed. Also you would want to have different versions of Python, you can use pyenv to install those.

At a minimun you should set HOST environment variable to point to your SQL server, e.g.:

```export HOST=mysqlserver```
it could also specify SQL server named instance, e.g.:

```export HOST=mysqlserver\\myinstance```

By default tests will use SQL server integrated authentication using user sa with password sa and database test. You can specify different user name, password, database with SQLUSER, SQLPASSWORD, DATABASE environment variables.

To enable testing NTLM authentication you should specify NTLM_USER and NTLM_PASSWORD environment variables.

Once environment variables are setup you can run tests by running command:

tox
Test configuration stored in tox.ini file at the root of the repository.

## Windows New Technology LAN Manager (NTLM)

is a suite of security protocols offered by Microsoft to authenticate users’ identity and protect the integrity and confidentiality of their activity. At its core, NTLM is a single sign on (SSO) tool that relies on a challenge-response protocol to confirm the user without requiring them to submit a password.

Despite known vulnerabilities, NTLM remains widely deployed even on new systems in order to maintain compatibility with legacy clients and servers. While NTLM is still supported by Microsoft, it has been replaced by Kerberos as the default authentication protocol in Windows 2000 and subsequent Active Directory (AD) domains.
