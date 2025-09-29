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

# Read existing excel file into ExcelWriter in Append Mode
writer = pd.ExcelWriter('excel_with_multiple_sheets-2.xlsx',mode='a',engine="openpyxl")

data=[{"Name":"Aditya","Age":25},
      {"Name":"Sameer","Age":26},
      {"Name":"Dharwish","Age":24},
      {"Name":"Joel","Age":27}]

#convert list of dictionaries to dataframe
df=pd.DataFrame(data)

# Write the pandas dataframe to the excel file
df.to_excel(writer, sheet_name='age',index=False)

# Make sure to properly close the file
writer.close()