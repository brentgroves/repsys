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

# Define list of dictionaries
height_data=[{"Name":"Aditya","Height":179},
      {"Name":"Sameer","Height":181},
      {"Name":"Dharwish","Height":170},
      {"Name":"Joel","Height":167}]

weight_data=[{"Name":"Aditya","Weight":76},
      {"Name":"Sameer","Weight":68},
      {"Name":"Dharwish","Weight":69},
      {"Name":"Joel", "Weight":73}]

marks_data=[{"Name":"Aditya","Marks":79},
      {"Name":"Sameer","Marks":81},
      {"Name":"Dharwish","Marks":70},
      {"Name":"Joel","Marks":67}]

# Convert list of dictionaries to dataframe
height_df=pd.DataFrame(height_data)
weight_df=pd.DataFrame(weight_data)
marks_df=pd.DataFrame(marks_data)

writer = pd.ExcelWriter('excel_with_multiple_sheets.xlsx', engine='xlsxwriter')

height_df.to_excel(writer, sheet_name='height',index=False)
weight_df.to_excel(writer, sheet_name='weight',index=False)
marks_df.to_excel(writer, sheet_name='marks',index=False)
writer.close()