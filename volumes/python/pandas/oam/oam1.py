#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "openpyxl",
#     "xlsxwriter",
#     "pandas",
# ]
# ///
import pandas as pd
from openpyxl import load_workbook

# Step 1: Read all sheets from the existing Excel file.
# Store the dataframes in a dictionary where keys are the sheet names.
file_path = 'oam0.xlsx'
all_sheets_dict = pd.read_excel(file_path, sheet_name=None)
ExcelWriter(filename,engine=None, mode='w',if_sheet_exists=None)
Code language: Python (python)

# Step 2: Modify the desired sheet's DataFrame.
# For this example, we'll modify 'Sheet1'.
df_to_modify = all_sheets_dict['oam']
# df_to_modify['New_Column'] = range(len(df_to_modify))

# Insert a new column named 'New_Column' with default values (e.g., None or 0)
# at a specific position (e.g., index 1, after the first column)
# df.insert(loc=6, column='New_Column', value="default")

# df.to_excel('oem1.xlsx', index=False)
# index=False prevents writing the DataFrame index as a column in the Excel file.

# Step 3: Write the updated DataFrame back to the specific sheet using ExcelWriter.
# Use 'append' mode and the 'openpyxl' engine.
with pd.ExcelWriter(
    file_path,
    engine='openpyxl',
    mode='a', # 'a' is for append mode
    if_sheet_exists='replace' # 'replace' overwrites the existing sheet
) as writer:
    df_to_modify.to_excel(writer, sheet_name='oam', index=False)

print(f"Sheet 'oam' in {file_path} has been updated and saved.")
