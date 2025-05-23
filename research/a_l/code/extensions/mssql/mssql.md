# **[What is the MSSQL extension for Visual Studio Code?](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/mssql/mssql-extension-visual-studio-code?view=fabric&preserve-view=true)**

## In this article

- Install the MSSQL Extension in Visual Studio Code
- Modern UI
- Supported operating systems
- Offline installation
- Feedback and support
- Related content

The **[MSSQL extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql)** is designed to support developers in building applications that use Azure SQL (including Azure SQL Database, Azure SQL Managed Instance, and SQL Server on Azure VMs), SQL database in Fabric (preview) or SQL Server as backend databases. With a comprehensive suite of features for connecting to databases, designing and managing database schemas, exploring database objects, executing queries, and visualizing query plans, this extension transforms the SQL development experience within Visual Studio Code.

The latest enhancements to this extension are aimed at boosting productivity. Whether you're working with databases running locally or in the cloud, the extension equips you with advanced IntelliSense, efficient Transact-SQL script execution, and customizable options. As a result, you can enjoy a modern and streamlined SQL development workflow.

## Install the MSSQL Extension in Visual Studio Code

To get started with SQL development in Visual Studio Code, install the MSSQL extension:

Open Visual Studio Code.
Select the Extensions icon in the Activity Bar (press Cmd+Shift+X on macOS or Ctrl+Shift+X on Windows/Linux).
In the search bar, type mssql.
Find SQL Server (mssql) in the results and select it.
Select the Install button.

You'll know the extension is installed correctly when the MSSQL icon appears in the Activity Bar and the Connections view becomes available.

## Modern UI

The MSSQL extension for Visual Studio Code introduces the General Availability of its enhanced UI—designed to elevate the SQL development experience across SQL Server, Azure SQL, and SQL Database on Fabric.

This release delivers key improvements to:

- Connection Dialog
- Object Explorer
- Table Designer
- Query Results Pane
- Query Plan Visualizer
- These features are now seamlessly integrated and enabled by default—no setup required.

## Connection dialog

The Connection dialog allows you to quickly connect to databases hosted in Azure SQL (including Azure SQL Database, Azure SQL Managed Instance, and SQL Server on Azure VMs), SQL database in Fabric (preview) or SQL Server through a simple and intuitive interface. It provides multiple input options to cater to different scenarios:

Parameters: Enter individual connection details such as server name, database name, username, and password.

Connection String: Directly input a complete connection string for more advanced configurations.

Browse Azure: Browse available database instances and databases in your Azure account, with options to filter by subscription, resource group, and location.

In addition to creating new connections, the dialog now includes a Saved Connections and Recent Connections panel, making it easier to reconnect to previously used servers. You can efficiently edit and save your connections with an improved layout that offers better navigation and usability. The enhanced UI makes modifying connection details or switching databases smoother than ever.

![i1](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/mssql/media/mssql-extension-visual-studio-code/mssql-connection-dialog-parameters.png?view=fabric)

## Object Explorer (filtering)

The Object Explorer enables users to navigate their database objects, such as databases, tables, views, and programmability items. The enhanced filtering functionality makes it easier to locate specific objects within large and complex database hierarchies:

Apply Filters: Filter database objects by properties like name, owner, or creation date. Filters can be applied at multiple levels, including databases, tables, views, and programmability.

Edit Filters: Refine or update existing filters to further narrow the object list.

Clear Filters: Easily remove applied filters to view all objects within the hierarchy.

These filters provide flexibility and control, making it easier to quickly manage large databases and find relevant objects.

![i2](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/mssql/media/mssql-extension-visual-studio-code/object-explorer-filtering.png?view=fabric)

## Table Designer

The Table Designer offers a new UI for creating and managing tables for your databases, with advanced capabilities to customize every aspect of the table's structure:

Columns: Add new columns, set data types, define nullability, and specify default values. You can also designate a column as a primary key or identity column directly within the interface.

Primary Key: Easily define one or more columns as the primary key for your table, ensuring each row is uniquely identifiable.

Indexes: Create and manage indexes to improve query performance by adding additional columns as indexes for faster data retrieval.

Foreign Keys: Define relationships between tables by adding foreign keys referencing primary keys in other tables, ensuring data integrity across tables.

Check Constraints: Set up rules to enforce specific conditions on the data being entered, such as value ranges or patterns.

Advanced Options: Configure more sophisticated properties and behaviors, such as system versioning and memory optimized tables.

Within the designer, the Script As Create panel provides an automatically generated T-SQL script that reflects your table design. You have the following options:

Publish: Apply your changes directly to the database by selecting Publish. This action is powered by DacFX (Data-tier Application Framework), which ensures the smooth and reliable deployment of your schema updates.

Copy script: You can copy the generated T-SQL script from the preview panel for manual execution or open it directly in the editor for further adjustments and modifications as needed.

![i2](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/mssql/media/mssql-extension-visual-studio-code/table-designer.png?view=fabric)

## Query Results pane

The MSSQL extension for Visual Studio Code provides an enhanced query results experience, helping you efficiently visualize and understand your data output. The query results display within the bottom panel of Visual Studio Code, which also hosts the integrated terminal, output, debug console, and other tools, creating a unified interface for easy access.

 Tip

You can now open query results in a new tab for an expanded view, similar to the previous experience.

Key features of the Query Results pane include:

Grid View: Displays query results in a familiar grid format, allowing for easy inspection of the data. You now have the option to display results in a New Tab for a clearer, more organized view

Copy Options: Right-click within the results grid to access options like Select All, Copy, Copy with Headers, and Copy Headers, making it convenient to transfer data for other uses.

Save Query Results: Includes the ability to save query results to multiple formats such as JSON, Excel, and CSV, allowing you to work with the data outside of Visual Studio Code.

Inline Sorting: You can sort the data by selecting the column headers directly in the query results view. Sorting can be done in ascending or descending order to make it easier to analyze specific subsets of the data.

Estimated Plan: The Estimated Plan button is located in the query toolbar, next to the Run Query button. It appears as a flowchart icon and allows you to generate an estimated execution plan without executing the query itself. This feature provides valuable insight into query performance, helping identify potential bottlenecks and inefficiencies before running the actual query.

Enable Actual Plan: A new button labeled Enable Actual Plan, located right after Estimated Plan button in the upper right corner of the results pane, lets you view the actual query plan for executed queries. This addition provides deeper insight into query performance and helps identify bottlenecks and inefficiencies.

This updated query results experience is designed to offer flexibility and improved workflow integration, empowering developers to work more effectively with their data.

![i3](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/mssql/media/mssql-extension-visual-studio-code/query-results-vscode.png?view=fabric#lightbox)

You can customize the query results behavior using the mssql.openQueryResultsInTabByDefault setting. When set to true, query results open in a new tab by default, helping declutter your workspace

## Query Plan Visualizer

The Query Plan Visualizer in the MSSQL extension for Visual Studio Code allows developers to analyze SQL query performance by displaying detailed execution plans. This tool provides insights into how SQL queries are executed, helping developers identify bottlenecks and optimize their queries.

Key features and capabilities include:

Node Navigation: Each step in the execution plan is represented as a node, allowing you to interact with the plan in various ways. You can select nodes to view tooltips or detailed information about specific operations. Additionally, you can collapse or expand node trees to simplify the view and focus on key areas of the query plan.
Zoom Controls: The visualizer offers flexible zoom options to help you analyze the plan in detail. You can zoom in or out to adjust the level of detail, use the "zoom to fit" feature to resize the view and fit the entire plan on your screen, or set custom zoom levels to examine specific elements precisely.
Metrics and Highlighting: The metrics toolbar allows you to analyze key performance indicators and highlight expensive operations. You can select metrics such as Actual Elapsed Time, Cost, Subtree Cost, or Number of Rows Read from the dropdown list to identify bottlenecks and use these metrics to search for specific nodes within the query plan for deeper analysis.
The right-hand sidebar provides quick access to additional actions:

Save Plan: Save the current execution plan for future reference.
Open XML: Open the XML representation of the query plan to inspect details at the code level.
Open Query: View the query that generated the execution plan directly from the toolbar.
Toggle Tooltips: Enable or disable tooltips for additional details on each node.
Properties: View the properties of each node in the execution plan, with options to sort by importance or alphabetically.

![i4](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/mssql/media/mssql-extension-visual-studio-code/query-plan-visualizer-vscode.png?view=fabric)

## Supported operating systems

Currently, this extension supports the following operating systems:

Windows (x64 | x86 | Arm64)
macOS (x64 | Arm64)
Linux Arm64
Ubuntu 18.04, 20.04, 22.04
Debian 10, 11, 12
CentOS 7, 8 / Oracle Linux 7, 8
Red Hat Enterprise Linux (RHEL): 8, 9
Fedora 35,36
OpenSUSE Leap 15

## Offline installation

The extension can download and install a required SqlToolsService package during activation. You can still use the extension for machines with no Internet access by choosing the Install from VSIX... option in the Extension view and installing a bundled release from our Releases page. Each operating system has a .vsix file with the required service included. Pick the file for your OS, download, and install it to get started. We recommend you choose a full release and ignore any alpha or beta releases, as these are our daily builds used in testing.

Feedback and support
If you have any feedback or comments, create a GitHub issue at <https://github.com/microsoft/vscode-mssql/issues>.

Related content
**[Quickstart: Connect to and query a database with the MSSQL extension for Visual Studio Code](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/mssql/connect-database-visual-studio-code?view=fabric)**
Learn more about Visual Studio Code
Learn more about contributing to the mssql extension
What is the local development experience for Azure SQL Database?
