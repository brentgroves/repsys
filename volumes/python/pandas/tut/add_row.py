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
writer = pd.ExcelWriter('excel_with_multiple_sheets-4.xlsx',
           mode='a',engine="openpyxl",if_sheet_exists="replace")
df=pd.read_excel('excel_with_multiple_sheets.xlsx', sheet_name="weight")
newRow= {"Name":"Elon","Weight":77}
new_row=pd.DataFrame([newRow])
df=pd.concat([df,new_row],ignore_index=True)

# Write the pandas dataframe to the excel file
df.to_excel(writer, sheet_name='weight',index=False)
writer.close()