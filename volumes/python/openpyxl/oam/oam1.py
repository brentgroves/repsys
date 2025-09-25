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
workbook = openpyxl.load_workbook("oam.xlsx")

# Select the active worksheet (or specify by name: workbook["Sheet1"])
# sheet = workbook.active
sheet = workbook["oam"]

# Insert one column at index 2 (before column B)
sheet.insert_cols(idx=6)

# Save the modified workbook
workbook.save("oam1.xlsx")