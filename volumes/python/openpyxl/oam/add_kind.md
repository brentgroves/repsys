# Add kind

insert new kind column
if 2nd dash in machine_id column
  slice from 2nd dash to end of machine id
  save slice to kind column

## delete all sheets except oam

```python
# sheet 1 to 5
for i in range (4, -1,-1):
  sheet_to_delete = wb.worksheets[i]
  # Get a reference to the sheet named 'Sheet1'
  # sheet_to_remove = wb["Sheet1"]
  # Remove the sheet
  wb.remove(sheet_to_delete)
  print(i)

# sheet 1 to 5
for i in range (9, 0,-1):
  sheet_to_delete = wb.worksheets[i]
  # Get a reference to the sheet named 'Sheet1'
  # sheet_to_remove = wb["Sheet1"]
  # Remove the sheet
  wb.remove(sheet_to_delete)
  print(i)

# Save the modified workbook
wb.save("oam0.xlsx")
```

## insert new kind column

```python
import openpyxl

# Load the workbook
workbook = openpyxl.load_workbook("oam.xlsx")

# Select the active worksheet (or specify by name: workbook["Sheet1"])
# sheet = workbook.active
sheet = workbook["oam"]

# Insert one column at index 2 (before column B)
sheet.insert_cols(idx=6)

# Save the modified workbook
workbook.save("oam1.xlsx")
```
