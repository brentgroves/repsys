# Line Spending

Hi Team,

Structures Information Systems with the help of the Corporate Data Analytics team is currently creating a step-by-step process to analyze data using Microsoft Fabric and Power BI. We are currently working on Southfield's Oil consumption while creating a process for future reports. In the meantime, we can start the process to analyze line spending. We are new at this so please bear with us.

Thanks
Brent

Goal: How much are we spending on each line.

Step 1: Create a fact table.

This is the data that is needed to determine line spending. This could be a simple excel file with column headings of all the information we need to collect to calculate line spending. There is an example of a simple sales fact table below.

Suggest we collect and combine line data costs from each department. The cost can be pulled from anywhere: Plex, Vending machines, or even a simple Excel spreadsheet.

Next:  Create dimension tables.
The dimension tables contain information to filter on and are linked to the fact tables. One very important dimension table is the date table. We need a date table specifically designed so that we can do all the kinds line spending analysis we want to do. For example year over year, year, year to date, prior year, rolling totals, etc.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Fact Table Example

| Column Name   | Data Type | Description                                         |
|---------------|-----------|-----------------------------------------------------|
| Sales_ID      | Integer   | Primary key for the table.                          |
| Product_ID    | Integer   | Foreign key linking to the Product dimension table. |
| Store_ID      | Integer   | Foreign key linking to the Store dimension table.   |
| Date_ID       | Integer   | Foreign key linking to the Date dimension table.    |
| Sales_Amount  | Decimal   | The monetary value of the sale (a fact or measure). |
| Quantity_Sold | Integer   | The number of items sold (a fact or measure).       |

## Fabric references

- ![data flow](https://res.cloudinary.com/dwwq4fbhq/image/upload/v1761250282/data_flow.drawio_x2btyk.png)
- **[Fact tables](https://www.kimballgroup.com/2008/11/fact-tables/)**
- **[Power BI Semantic Model](https://www.datacamp.com/blog/what-are-power-bi-semantic-models?utm_cid=22660585401&utm_aid=181540420075&utm_campaign=230119_1-ps-other~dsa~tofu-blog_2-b2c_3-nam_4-prc_5-na_6-na_7-le_8-pdsh-go_9-nb-e_10-na_11-na&utm_loc=9057673-&utm_mtd=-c&utm_kw=&utm_source=google&utm_medium=paid_search&utm_content=ps-other~nam-en~dsa~tofu~blog~powerbi&gad_source=1&gad_campaignid=22660585401&gbraid=0AAAAADQ9WsGcNFpKZbOKJIpKPfcnhGQGU&gclid=Cj0KCQjw9czHBhCyARIsAFZlN8Re7jKwZcxi1AZ4U3YDqHXajxDb5zeFah3jT5yEl6nq4at16PqN61oaAgMJEALw_wcB)**
- **[Org Apps](https://www.youtube.com/watch?v=7W3_9J0emKM&t=124s)**
- **[Apache Spark](https://www.geeksforgeeks.org/java/components-of-apache-spark/)**
- **[Fabric Notebooks](https://www.youtube.com/watch?v=do8_gogFlLk)**
- **[Lakehouse and Delta Lake tables](https://learn.microsoft.com/en-us/fabric/data-engineering/lakehouse-and-delta-tables)**
- **[Delta Lake vs Delta Table](https://community.databricks.com/t5/data-engineering/deltalkake-vs-delta-table/td-p/5027)**
- **[](https://learn.microsoft.com/en-us/fabric/data-engineering/tutorial-lakehouse-introduction)**

## team

- Pat Baxter, General Manager
- Randy Kerrigan, Plant Controller - Indiana
Accounting
- Michael Percell, Manufacturing Engineering Manager
- Ron James, Quality Manager
- Jami Pyle, MP&L Manager
- Nancy Swank, Material Planner
- Dennis Brach, Maintenance Group Leader
- Tarek Mohamed, IT Supervisor - Data & Analytics
- Cody Hudson, Fabric Administrator
- Christian Trujillo, IT Structures Manager
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Hayley Rymer, IT Supervisor, Mills River
- Matthew Bump, Muscle Shoals, Engineering Supervisor II / IT
- Angelina Shadder, Muscle Shoals, Cyber Securtity, Desktop and Systems Support Technician
- Sam Jackson, Information Systems Developer, Southfield
- Brad D. Cook, Quality Engineer, Fruitport
- Jared Eikenberry, Quality Engineer, Fruitport
- Carl Stangland, Desktop and System Support Technician, Indiana
- Ricardo Baca, Sr. Manufacturing Engineer
