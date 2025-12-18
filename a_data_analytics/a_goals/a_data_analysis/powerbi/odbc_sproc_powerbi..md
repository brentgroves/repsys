Here's a step-by-step breakdown:

1. Configure an ODBC Data Source:
Install the ODBC driver:
.
Ensure you have the correct ODBC driver for your database system installed on your machine according to Devart.
Create a System DSN:
.
Create a System Data Source Name (DSN) in the ODBC Data Source Administrator.
Configure the DSN:
.
Specify the database server, database name, and authentication details (e.g., username/password or Windows authentication).
2. Connect to the Data Source in Power BI:
Get Data: In Power BI Desktop, select "Get Data" and then choose "ODBC".
Select the DSN: Choose the System DSN you created in the previous step.
Provide Credentials: Enter the username and password if required.
3. Execute the Stored Procedure:
Use Odbc.Query: In Power Query Editor, select "New Source" and then "Blank Query".
Edit the Query: Open the "Advanced Editor" and paste the following code, replacing the placeholders with your connection string and stored procedure details:
Code

let
    Source = Odbc.Query("connection string", "EXEC your_stored_procedure_name")
in
    Source
Replace Placeholders:
connection string: Replace this with your ODBC connection string. You can find this in the DSN configuration or by using the Odbc.DataSource function.
your_stored_procedure_name: Replace this with the name of your stored procedure.
Optional SQL Statement:
If your stored procedure requires parameters, you can pass them within the EXEC statement, for example: EXEC your_stored_procedure_name @param1 = value1, @param2 = value2.
4. Load and Transform the Data:
Load the results: If the query executes successfully, Power BI will display the results in the Query Editor.
Transform the data: Use Power Query to further transform and shape the data as needed.
Load to Power BI: Once you've finished transforming the data, you can load it into Power BI for visualization.
Key Considerations:
Query Folding:
While the standard ODBC connector doesn't support DirectQuery, some data sources and drivers might offer query folding capabilities for optimized performance.
DirectQuery:
If you need to use DirectQuery mode with a stored procedure, you might need to explore custom connectors or specific drivers that support this functionality.
Performance:
Ensure that your stored procedures are optimized for performance, as slow stored procedures can impact the refresh time of your Power BI reports.
Error Handling:
Implement appropriate error handling in your stored procedures and Power BI queries to gracefully manage potential issues

## e tables

from accounting_v_account_e  a -- 36,636
join accounting_v_category_type act -- This is the value used by the new method of configuring plex accounts.
on a.category_type=act.category_type  -- 36,636
-- Category numbers linked to an account by the a category_account record will no longer be supported by Plex
left outer join accounting_v_category_account_e ca  --
on a.plexus_customer_no=ca.plexus_customer_no
and a.account_no=ca.account_no
where a.plexus_customer_no=123681  -- 4204

where a.plexus_customer_no in
(
 select tuple from #list
)
)
