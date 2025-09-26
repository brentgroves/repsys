#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "pandas",
# ]
# ///
import pandas as pd

df = pd.read_excel('oam0.xlsx')

# Select the active worksheet (or specify by name: workbook["Sheet1"])
# sheet = workbook.active
sheet = workbook["oam"]

# Insert a new column named 'New_Column' with default values (e.g., None or 0)
# at a specific position (e.g., index 1, after the first column)
df.insert(loc=6, column='New_Column', value=None)

df.to_excel('oem1panda.xlsx', index=False)
# index=False prevents writing the DataFrame index as a column in the Excel file.
