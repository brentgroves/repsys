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

def get_sheet_date():
  df=pd.read_excel('Oil adds to Machines.xlsx', sheet_name="Aug. oil usage")

  column_names_list = df.columns.tolist()
  print(column_names_list[1])

  sheet_date= column_names_list[1]

  datetime_obj = pd.to_datetime(sheet_date, format='%Y/%m/%d')
  print(f"'{sheet_date}' converted to: {datetime_obj}")

  print('Month: ', datetime_obj.month) # To Get month from date
  print('Year: ', datetime_obj.year) # To Get month from year
  print('Day: ', datetime_obj.day) # To Get month from year

  dt_modified = datetime_obj.replace(day=1)
  print(f"'{datetime_obj}' converted to: {dt_modified}")

def main():
    # Your main program logic goes here
    print("This is the main function.")
    # Call other functions or perform operations
    get_sheet_date()

if __name__ == "__main__":
    main()