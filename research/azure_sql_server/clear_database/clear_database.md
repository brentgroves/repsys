# Delete everything in Azure SQL database

## references

<https://stackoverflow.com/questions/34967878/how-to-drop-all-tables-and-reset-an-azure-sql-database>

<https://edspencer.me.uk/posts/2013-02-25-drop-all-tables-in-a-sql-server-database-azure-friendly/>

## Question

Is there a quick way to just drop/reset a Azure SQL DB to it's fresh, empty, virgin state and then re-publish with "execute code first migrations" to have it re-create the tables and re-seed the data?

Since there is not an API way to do this that I am aware of, we have used this script to leverage a T-SQL query to clear the database.

To delete each table (and maintain your EF migration histories if you want)

##

Since there is not an API way to do this that I am aware of, we have used this script to leverage a T-SQL query to clear the database.

To delete each table (and maintain your EF migration histories if you want)

<https://edspencer.me.uk/posts/2013-02-25-drop-all-tables-in-a-sql-server-database-azure-friendly/>
