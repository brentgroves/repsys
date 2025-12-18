# Delta Tables

Hi Team,

The delta table concept is useful for reports that are impossible to write using the static data in a database.

- A database keeps track of your inventory, but how do we report on how many items we had last week?

Delta Tables record all the changes made to your data, so you can see what your data looked like at any point in the past.

- With delta tables, we can report on today's inventory versus last month's.

We can report on inventory changes in time by running ETL scripts to put daily counts in the data warehouse, but the delta table was made for this task.

The automated ETL system is essential to populating delta tables. We can use it to collect data we want to analyze changes in. We will not find an exact equation for predicting, but we can find direction fields and solution curves.

Team:

Kevin Young, Information Systems Manager
Sam Jackson, Information Systems Developer, Southfield
Brad D. Cook, Quality Engineer, Fruitport
Jared Eikenberry, Quality Engineer, Fruitport

## referencs

- **[databricks](https://learn.microsoft.com/en-us/azure/databricks/sql/)**

- **[Delta Tables](https://www.reddit.com/r/dataengineering/comments/uu09mj/what_is_a_delta_table/)**

- **[SQL database in Microsoft Fabric (Preview)](https://learn.microsoft.com/en-us/fabric/database/sql/overview)**
