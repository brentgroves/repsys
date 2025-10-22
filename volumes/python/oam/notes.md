# Oil Adds Machine Notes

## Goal

Use the easily updated "Oil adds to Machines.xlsx" spreadsheet which has one row with machine/oil_type/line and oil quantity for each day of the month to update the Structures OAM data lake or warehouse table with a PySpark notebook.

## Warehouse Data Model

- created excel star schema diagram
- created CSV fact table
- no dim tables yet
- optional cost slowly changing dimension

## CSV creation overview

- Keep format of "Oil adds to Machines.xlsx" with these differences:
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

<https://builtin.com/articles/pandas-add-row-to-dataframe>

```bash
# ln -s /path/to/original/folder /path/to/shortcut/location/shortcut_name

ln -s /home/brent/src/repsys/volumes/python/oam /home/brent/oam
```
