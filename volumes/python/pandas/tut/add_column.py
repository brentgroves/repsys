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
writer = pd.ExcelWriter('excel_with_multiple_sheets-6.xlsx',
           mode='a',engine="openpyxl",if_sheet_exists="replace")
df=pd.read_excel('excel_with_multiple_sheets.xlsx', sheet_name="weight")
df["Weight_lbs"]=df["Weight"]*2.20462
# df["Age"]=[25,22,24,27,49]

# Declare a list that is to be converted into a column
address = ['NewYork', 'Chicago', 'Boston', 'Miami']
address = [25,22,24,27]
# Using 'Address' as the column name
# and equating it to the list
df['Age'] = address

# print(df)

# Write the pandas dataframe to the excel file
df.to_excel(writer, sheet_name='weight',index=False)
writer.close()