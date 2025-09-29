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

# data = {'name': ['Alice', 'Bob', 'Charlie'], 'age': [25, 30, 35]}
# df = pd.DataFrame(data)
# df_indexed = df.set_index('name')
# print(df_indexed)
# Define a list of lists
data=[["Aditya",179],
      ["Sameer",181],
      ["Dharwish",170],
      ["Joel",167]]

# Define column names
column_names=["Name", "Height"]

# Create a pandas dataframe using the list of lists
df=pd.DataFrame(data, columns=column_names)

writer = pd.ExcelWriter('excel_with_list.xlsx', engine='xlsxwriter')

# df.to_excel(writer, sheet_name='first_sheet',index=False)
# Add the pandas dataframe to the excel file as sheet
# df.to_excel(writer, sheet_name='first_sheet',index=False)
df.to_excel(writer, sheet_name='first_sheet',index=False, startrow=3, startcol=3)

writer.close()

