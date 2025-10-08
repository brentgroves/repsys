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
# from datetime import datetime, timedelta
import datetime as sldt # dt.date = pandas...timestamp.date
# import datetime # works for datetime.date()
# from datetime import date # works for date()

def get_row(df,row):
  print(f"row->{df.iloc[row]}")

def get_row_col(df,row,col):
  print(f"row={row},col={col}->{df.iloc[row,col]}")
  
  if df.isnull().iloc[row,col]:
    value =  0.00
  else:
    value =  df.iloc[row,col]
  return value

def get_sheet_date(df,sheet_name):

  column_names_list = df.columns.tolist()
  # print(column_names_list[1])

  sheet_date= column_names_list[1]

  datetime_obj = pd.to_datetime(sheet_date, format='%Y/%m/%d')
  # print(f"'{sheet_date}' converted to: {datetime_obj}")

  # make sure it is 1st day of month
  dt_sheet_date = datetime_obj.replace(day=1)
  # print('Month: ', datetime_obj.month) # To Get month from date
  # print('Year: ', datetime_obj.year) # To Get month from year
  # print('Day: ', datetime_obj.day) # To Get month from year

  print(f"'{datetime_obj}' converted to: {dt_sheet_date}")
  return dt_sheet_date

def days_of_month_loop(pd_sheet_datetime):
  start_date = sldt.date(pd_sheet_datetime.year, pd_sheet_datetime.month, 1)

  # Calculate the last day of the month

  if pd_sheet_datetime.month == 12:
      end_date = sldt.date(pd_sheet_datetime.year + 1, 1, 1) - sldt.timedelta(days=1)
  else:
      end_date = sldt.date(pd_sheet_datetime.year, pd_sheet_datetime.month + 1, 1) - sldt.timedelta(days=1)

  current_date = start_date
  print(f"end_date={end_date}")

  while current_date <= end_date:
      print(current_date)
      current_date += sldt.timedelta(days=1)
    
    # print('Month: ', dt.month) # To Get month from date
    # print('Year: ', dt.year) # To Get month from year

def main():
    # Your main program logic goes here
    print("This is the main function.")
    sheet_name = "Aug. oil usage"
    # Call other functions or perform operations
    df=pd.read_excel('Oil adds to Machines.xlsx', sheet_name=sheet_name)
    pd_sheet_datetime = get_sheet_date(df,"Aug. oil usage")
    print(f"sheet_date' {pd_sheet_datetime}")

    days_of_month_loop(pd_sheet_datetime)


    # Define the number of days to add
    # days_to_add = 7

    # # Create a timedelta object
    # delta = timedelta(days=days_to_add)

    # # Add the timedelta to the datetime object
    # future_datetime = dt_sheet_date + delta
    # print(f"Datetime after adding {days_to_add} days: {future_datetime}")

    
    # # get_row(df,1)
    # value = get_row_col(df,1,3) # 0.00
    # print(f"col 3 value is {value}")
    # value = get_row_col(df,1,4) # blank
    # print(f"col 4 value is {value}")
    # value = get_row_col(df,1,12) # 5
    # print(f"col 12 value is {value}")

if __name__ == "__main__":
    main()