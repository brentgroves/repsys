# SQL Server install

## references

<https://learn.microsoft.com/en-us/sql/linux/quickstart-sql-server-containers-azure?view=sql-server-ver16&tabs=kubectl>

## Create an SA password

1. Create an SA password in the Kubernetes cluster. Kubernetes can manage sensitive configuration information, like passwords as secrets.

2. To create a secret in Kubernetes named mssql that holds the value MyC0m9l&xP@ssw0rd for the MSSQL_SA_PASSWORD, run the following command. Remember to pick your own complex password:

The SA_PASSWORD environment variable is deprecated. Use MSSQL_SA_PASSWORD instead.

3. kubectl create secret generic mssql --from-literal=MSSQL_SA_PASSWORD="MyC0m9l&xP@ssw0rd"
