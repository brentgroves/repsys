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
from datetime import datetime, timedelta

def get_row(df,row):
  print(f"row->{df.iloc[row]}")

def get_row_col(df,row,col):
  print(f"row={row},col={col}->{df.iloc[row,col]}")

def get_sheet_date(df,sheet_name):

  column_names_list = df.columns.tolist()
  # print(column_names_list[1])

  sheet_date= column_names_list[1]

  datetime_obj = pd.to_datetime(sheet_date, format='%Y/%m/%d')
  # print(f"'{sheet_date}' converted to: {datetime_obj}")

  dt_sheet_date = datetime_obj.replace(day=1)
  # print('Month: ', datetime_obj.month) # To Get month from date
  # print('Year: ', datetime_obj.year) # To Get month from year
  # print('Day: ', datetime_obj.day) # To Get month from year

  print(f"'{datetime_obj}' converted to: {dt_sheet_date}")
  return dt_sheet_date

def main():
    # Your main program logic goes here
    print("This is the main function.")
    sheet_name = "Aug. oil usage"
    # Call other functions or perform operations
    df=pd.read_excel('Oil adds to Machines.xlsx', sheet_name=sheet_name)
    dt_sheet_date = get_sheet_date(df,"Aug. oil usage")
    print(f"sheet_date' {dt_sheet_date}")
    # Define the number of days to add
    days_to_add = 7

    # Create a timedelta object
    delta = timedelta(days=days_to_add)

    # Add the timedelta to the datetime object
    future_datetime = dt_sheet_date + delta
    print(f"Datetime after adding {days_to_add} days: {future_datetime}")

    # get_row(df,1)
    get_row_col(df,1,3)

if __name__ == "__main__":
    main()