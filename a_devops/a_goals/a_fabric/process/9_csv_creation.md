# Create Fabric Org App to run Oil Adds Machine report

Ricardo,
This is my first time to use the Linamar Fabric workspace Org App feature to publish a Power BI report with a data lake data source, so please bear with me. I will keep you posted as to my progress.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Goal

Use the easily updated "Oil adds to Machines.xlsx" spreadsheet which has one row with machine/oil_type/line and oil quantity for each day of the month to update the Structures OAM data lake table with a PySpark notebook.

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

Complete CSV creation notebook.
