#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "openpyxl",
# ]
# ///
# import openpyxl module
import openpyxl 

wb = openpyxl.load_workbook("sample.xlsx") 

sheet = wb.active 

data = (
    (1, 2, 3),
    (4, 5, 6)
)

for row in data:
    sheet.append(row)

wb.save('sample.xlsx')
