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
writer = pd.ExcelWriter('excel_with_multiple_sheets-7.xlsx',
           mode='a',engine="openpyxl",if_sheet_exists="replace")
df=pd.read_excel('excel_with_multiple_sheets-7.xlsx', sheet_name="weight")
# ,index=False
# Creating a new DataFrame
new_df = pd.DataFrame({'New_Column': [20, 30, 40, 50]})
df = pd.concat([df.iloc[:, :1], new_df, df.iloc[:, 1:]], axis=1)

# Displaying the modified DataFrame
print(df)
# df["Weight_lbs"]=df["Weight"]*2.20462
# df["Age"]=[25,22,24,27,49]

# Declare a list that is to be converted into a column
# address = ['NewYork', 'Chicago', 'Boston', 'Miami']
# address = [25,22,24,27]
# # Using 'Address' as the column name
# # and equating it to the list
# df['Age'] = address

# Insert a new column named 'New_Column' with default values (e.g., None or 0)
# at a specific position (e.g., index 1, after the first column)
# df.insert(loc=2, column='New_Column', value="default")

# print(df)

# Write the pandas dataframe to the excel file
df.to_excel(writer, sheet_name='weight',index=False)
writer.close()