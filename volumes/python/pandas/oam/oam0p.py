#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "pandas",
#     "openpyxl"
# ]
# ///
# import openpyxl module
import pandas as pd

# df = pd.read_excel('oam.xlsx', sheet_name='Sheet1')
data = pd.read_excel('oam.xlsx', sheet_name='oam')

# Syntax: df = df.drop('ColumnName', axis=1)
# Pandas columns - first : means get all rows, then slice columns
# df.iloc[:, ::-1]    # all items in the array, reversed
# df.iloc[:, 1::-1]   # the first two items, reversed
# df.iloc[:, :-3:-1]  # the last two items, reversed
# df.iloc[:, -3::-1]  # everything except the last two items, reversed
# Drop column 'B'
df = data.drop(data.iloc[:,4:-1:-1], axis=1)
# print(df)

df.to_excel('oem1.xlsx', index=False)

# # sheet 0 to 4
# for i in range (4, -1,-1):
#   sheet_to_delete = wb.worksheets[i]
#   # Get a reference to the sheet named 'Sheet1'
#   # sheet_to_remove = wb["Sheet1"]
#   # Remove the sheet
#   wb.remove(sheet_to_delete)
#   print(i)

# # sheet 1 to 5
# for i in range (9, 1,-1):
#   sheet_to_delete = wb.worksheets[i]
#   # Get a reference to the sheet named 'Sheet1'
#   # sheet_to_remove = wb["Sheet1"]
#   # Remove the sheet
#   wb.remove(sheet_to_delete)
#   print(i)

# # Save the modified workbook
# wb.save("oam0.xlsx")