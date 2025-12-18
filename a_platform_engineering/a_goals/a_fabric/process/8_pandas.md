# Publish Power BI report

Ricardo,
This is my first time to publish a Power BI report in the Linamar Fabric workspace, so please bear with me. I will keep you posted as to my progress.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Today

Used Python Pandas library to transform "Oil adds to Machines.xlsx" input to Fabric-OAM.xlsx which is like Power BI-OAM.xlsx but without duplicating sheets in "Oil adds to Machines.xlsx" and links to other worksheets. The Python script will automate the creation of the PBI Excel data source from the easy to update "Oil adds to Machines.xlsx" worksheet.

- added a date cell to each sheet in "Oil adds to Machines Fabric.xlsx" worksheet.
- used pandas.tseries.offsets for creation of monthly date ranges

## Next

Create rows for daily oil quantities for each machine,oil type from "Oil adds to Machines Fabric.xlsx" and store in Fabric-OAM along with date and machine info.xlsx

Please send me a copy of your PBI report.

## Upcoming

Transfer data into lakehouse.
