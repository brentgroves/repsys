# Structures Microsoft Fabric Process Control Status

Hi Team,

We are working to use PLC data being collected and dimensional data we are in the process of collecting to generate Power BI dashboards and notebooks to help with process control.

Brent
Structures - Information Systems

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Goal

Make Power BI and Notebooks from Microsoft Fabric Data Lake Medallion Workflow to help with process control.

## Process

- PLC data is being collected by KepServerEx into a SQL server database.
- dimensial gage data will be collected by Mach2 and KepServerEx with a serial device server attached to the Marposs gages.
- Mach2 will insert this data directly into the Plex ERP.
- While the SQL server data will be used by Microsoft Fabric to report on our process capability by generating Cp, Cpk, Pp, Ppk Power Bi dashboards and Notebooks.

## Variables

- feature dimension
- tool(s) count/tool life

1. collect data

    ![collect data](https://www.1factory.com/assets/img/the-objective-of-process-capability-analysis-1factory.png)

2. clean and transform data

    ![Medallian process](https://miro.medium.com/v2/resize:fit:786/format:webp/1*pRD0YDKxkwCiQ6S5bVv9cw.png)

3. Make Power BI dashboards and Notebooks from the Structures gold data lake.

![cpk](https://res.cloudinary.com/dwwq4fbhq/image/upload/v1763816623/visual-cp-cpk-1factory_csv13k.png)

## Power BI workflow

Once our data is collected, cleaned, and tranformed using the Microsoft Fabric Data Lake Medallion Workflow we then can create Power BI dashboards and reports using this Power BI workflow.

![i](https://res.cloudinary.com/dwwq4fbhq/image/upload/v1761677540/powerbi_workflow_qpbrid.jpg)

## what is a Microsoft Fabric data lake

The data lake is a high performance parquet file combined with a delta table transaction log.

**[A delta table is a table format that brings ACID (atomicity, consistency, isolation, durability) transactions to data lakes, storing data as Parquet files with a transactional log to track changes. This open-source format enables features like time travel, schema enforcement, and efficient updates, and is compatible with systems like Apache Spark.](https://www.youtube.com/watch?v=SE_Aop70gfE)**

Benefits of using Parquet:

- **Improved Query Performance:** Columnar storage and predicate pushdown lead to faster query execution, especially for analytical workloads.
- **Reduced Storage Space:** Efficient compression and binary storage result in smaller file sizes and lower storage costs.
- **Enhanced Data Processing Efficiency:** Optimized for big data frameworks, Parquet facilitates faster data loading and processing.
- **Flexibility with Schema Evolution:** Allows for adaptability in data schemas without disrupting existing data.

## Fabric Team

- Tarek Mohamed, IT Supervisor - Data & Analytics
- Christian Trujillo, IT Structures Manager
- Jared Davis, IT Manager
- Kevin Young, Information Systems Manager
- Sam Jackson, Information Systems Developer, Southfield
- Pat Baxter, General Manager
- Ron James, Quality Manager, Quality
- Michael Percell, Manufacturing Engineering Manager
- Jami Pyle, MP&L Manager
- Matthew Bump, Muscle Shoals, Engineering Supervisor II / IT
- Angelina Shadder, Muscle Shoals, Cyber Securtity, Desktop and Systems Support Technician
- Brad D. Cook, Quality Engineer, Fruitport
- Jared Eikenberry, Quality Engineer, Fruitport
- Carl Stangland, Desktop and System Support Technician, Indiana
- Ricardo Baca, Sr. Manufacturing Engineer
- Beth Schaus, Accounting Finance
- Cody Hudson, Accounting Associate
- Katerina Lallouet, HR Manager, Corporate
- Vicente Ontiveros, Director, Program Management
Engineering, McLaren
- Jose Pardo, Maintainence Manager
- Mikael Boire, Operation Manager
- Nancy Swank, Material Planner
- Erin Williams, Manufacturing Engineer, Engineering
- April Sumner, Quality Engineer
- Skippie Muehlfeld, Controls Engineer
- Josh Williams, Program Manager, Engineering
- Dennis Brach, Maintenance Manager
