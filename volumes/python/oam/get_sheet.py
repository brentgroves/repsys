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

df=pd.read_excel('Oil adds to Machines.xlsx', sheet_name="Aug. oil usage")

# Get the column names
# column_names = df.columns
# print(column_names)

column_names_list = df.columns.tolist()
print(column_names_list[1])

single_cell_value= column_names_list[1]

# pd.to_datetime(single_cell_value, format='%d %b %Y', errors='coerce').dt.date
# Example with a different format including time
# date_string2 = '2024/07/15 14:30:00'
datetime_obj2 = pd.to_datetime(single_cell_value, format='%Y/%m/%d')
print(f"'{single_cell_value}' converted to: {datetime_obj2}")
# print(single_cell_value)

# datetime_object = pd.to_datetime(single_cell_value)
# print(datetime_object)
# cell_value = df.iat[0, 1] # Row index 1, Column index 1
# print(f"Value at index [1, 1]: {cell_value}")
# print(df)

# df["Weight_lbs"]=df["Weight"]*2.20462
# # df["Age"]=[25,22,24,27,49]

# # Declare a list that is to be converted into a column
# address = ['NewYork', 'Chicago', 'Boston', 'Miami']
# address = [25,22,24,27]
# # Using 'Address' as the column name
# # and equating it to the list
# df['Age'] = address

# # print(df)

# # Write the pandas dataframe to the excel file
# df.to_excel(writer, sheet_name='weight',index=False)
# writer.close()