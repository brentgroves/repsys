# Delta Tables

Hi Team,

I thought you might find the delta table concept useful for reports that are impossible to write using the data in Plex.

- A database keeps track of your inventory, but how do we report on how many items we had last week?

Delta Tables keep a record of all the changes made to your data, so you can see what your data looked like at any point in the past.

- With delta tables, we can report on today's inventory versus last month's.

We can report on inventory changes in time by running ETL scripts to put daily counts in the data warehouse, but the delta table was made for this task.

Team:

Kevin Young, Information Systems Manager
Sam Jackson, Information Systems Developer, Southfield
Brad D. Cook, Quality Engineer, Fruitport
Jared Eikenberry, Quality Engineer, Fruitport

## referencs

- **[databricks](https://learn.microsoft.com/en-us/azure/databricks/sql/)**

- **[Delta Tables](https://www.reddit.com/r/dataengineering/comments/uu09mj/what_is_a_delta_table/)**

- **[SQL database in Microsoft Fabric (Preview)](https://learn.microsoft.com/en-us/fabric/database/sql/overview)**
