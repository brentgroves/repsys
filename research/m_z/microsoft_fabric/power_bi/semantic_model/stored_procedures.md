# AI: power bi semantic models with stored procedures

## reference

**[stored procedures](https://www.youtube.com/watch?v=N1En6_NB_dY)**
**[call sprocs from power bi](https://www.youtube.com/watch?v=-GS3Kxvxm7A&t=247s)**

Options:

1. Allow the ETL system call stored procedures to load and transform you data and use Power BI to connect to the ETL systems result sets and use **[star schema best practices](https://www.owox.com/blog/articles/star-schema-explained)**
2. Use Power BI direct query mode to retrieve only data needed for complete transformation. Don't know if this mode is compatible with Power Query M language and DAX functions

Power BI semantic models can indeed utilize stored procedures, especially when working with relational data sources like SQL Server. While Power BI's import mode is often favored for its performance benefits, using stored procedures can be valuable for complex data preparation logic, parameterization, and improved maintainability. DirectQuery mode is often necessary when passing dynamic parameters to stored procedures.
Here's a breakdown of how stored procedures integrate with Power BI semantic models:

Here's a breakdown of how stored procedures integrate with Power BI semantic models:

1. Stored Procedures in Relational Data Sources:
Power BI can connect to relational data sources, including those that utilize stored procedures.
Stored procedures can be executed within Power BI Desktop and Power BI Service to retrieve data.
Key benefit: Stored procedures can encapsulate complex logic, including temporary tables, cursors, and user-defined functions, which might be cumbersome to replicate in Power Query.
2. DirectQuery and Dynamic Parameters:
When you need to pass dynamic parameters (user inputs) to a stored procedure, DirectQuery mode is typically required.
This allows for interactive reports where user selections in the report UI are passed as parameters to the stored procedure in the database.
Example: You might have a stored procedure that filters data based on a date range selected by the user in the report.

3. Advantages of Using Stored Procedures:
Encapsulation:
Stored procedures can encapsulate complex data transformation logic, making the Power BI model cleaner and easier to maintain.
Parameterization:
They allow for dynamic data filtering and retrieval based on user input or other parameters.
Performance:
When execution plans are cached, stored procedures can offer better performance compared to repeated execution of similar queries.
Reusability:
Stored procedures can be reused across multiple reports and dashboards.
4. Import Mode Considerations:
While stored procedures can be used in both DirectQuery and Import modes, DirectQuery is often necessary for scenarios requiring dynamic parameters and user interaction.
If you're using Import mode and want to leverage stored procedures, you'll typically need to materialize the results of the stored procedure into a table within your Power BI model.
5. Example Scenario:
Create a stored procedure in your SQL Server database that filters data based on a date range.
Connect to the SQL Server database from Power BI Desktop.
Use the stored procedure as a data source for a table in your Power BI semantic model.
Optionally, create a slicer in your report to allow users to select the date range.
Use DirectQuery mode to pass the selected date range as a parameter to the stored procedure.
The stored procedure will filter the data based on the selected date range, and the results will be displayed in your report.
In essence, while Power BI's import mode is often favored for performance, using stored procedures, especially with dynamic parameters in DirectQuery mode, can be a powerful approach for complex data scenarios and improved maintainability, according to a Power BI blog.
