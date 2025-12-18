# Create Fabric Org App to run Oil Adds Machine report

Ricardo,
This is my first time to use the Linamar Fabric workspace Org App feature to publish a Power BI report with a data lake data source, so please bear with me. I will keep you posted as to my progress.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Goal

Use the easily updated "Oil adds to Machines.xlsx" spreadsheet which has one row with machine/oil_type/line and oil quantity for each day of the month to update the Structures OAM data lake table with a PySpark notebook.

Secondary goal: Document the Fabric/PowerBI/Datalake process and record it for the team.

## **[Design MICROSOFT FABRIC Data Project with Medallion Architecture | Lakehouse + Spark + Power BI](https://www.youtube.com/watch?v=qG65DUcSjws)**

The next step in the medallion process is to convert the CSV file to a parquet file.

Benefits of using Parquet:

- **Improved Query Performance:** Columnar storage and predicate pushdown lead to faster query execution, especially for analytical workloads.
- **Reduced Storage Space:** Efficient compression and binary storage result in smaller file sizes and lower storage costs.
- **Enhanced Data Processing Efficiency:** Optimized for big data frameworks, Parquet facilitates faster data loading and processing.
- **Flexibility with Schema Evolution:** Allows for adaptability in data schemas without disrupting existing data.

## CSV creation overview

- Keep format of "Oil adds to Machines.xlsx" with these differences:
  - Rename to "OAMForMonth.xlsx"
  - Record only one months worth of oil adds.
  - Add date to top of the single sheet.
- Copy "OAMForMonth.xlsx" to Fabric data lake folder.
- Generate "OAMDataLakeSync.csv" using Notebook.
- Import monthly OAM data into data lake table using Notebook.
  - Read "OAMDataLakeSync.csv"
    - For each row
      - If date/machine/oil_type/line record exists in DataLake delete it.
      - Insert date/machine/oil_type/line record into DataLake table.

## Next

Further clean and refine silver layer data.

## Fabric Team

- Tarek Mohamed, IT Supervisor - Data & Analytics
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
- Beth Schaus, Accounting Finance
- Cody Hudson, Accounting Associate
- Katerina Lallouet, HR Manager, Corporate
- Vicente Ontiveros, Director, Program Management
Engineering, McLaren
