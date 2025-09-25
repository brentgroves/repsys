#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "openpyxl",
# ]
# ///
# import openpyxl module
import openpyxl

# Load the workbook
wb = openpyxl.load_workbook("oam.xlsx")

# Example: numbers from 2 to 6
# for i in range(2, 7):

# sheet 1 to 5
for i in range (5, -1,-1):
  sheet_to_delete = wb.worksheets[i]
  # Get a reference to the sheet named 'Sheet1'
  # sheet_to_remove = wb["Sheet1"]
  # Remove the sheet
  wb.remove(sheet_to_delete)
  print(i)

# sheet 1 to 5
for i in range (8, 0,-1):
  sheet_to_delete = wb.worksheets[i]
  # Get a reference to the sheet named 'Sheet1'
  # sheet_to_remove = wb["Sheet1"]
  # Remove the sheet
  wb.remove(sheet_to_delete)
  print(i)

# Save the modified workbook
wb.save("oam0.xlsx")