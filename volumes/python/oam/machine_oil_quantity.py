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
from pandas.tseries.offsets import MonthEnd

import datetime as sldt # dt.date = pandas...timestamp.date
# import datetime # works for datetime.date()
# from datetime import date # works for date()
from pandas.io.formats import style

def get_row(df,row):
  print(f"row->{df.iloc[row]}")

# The first line of the spreadsheet containing the date is not part of the dataframe. The second line containing the column headings is row 0 of the data frame.
def get_row_col(df:pd.DataFrame,row:int,col:int)->float:
  # print(f"row={row},col={col}->{df.iloc[row,col]}")
  
  if df.isnull().iloc[row,col]:
    value =  0.00
  else:
    value =  df.iloc[row,col]
  return value

  
def get_sheet_date(df)->pd.Timestamp:

  column_names_list = df.columns.tolist()
  # print(column_names_list)

  sheet_date= column_names_list[1]

  datetime_obj = pd.to_datetime(sheet_date, format='%Y/%m/%d')
  # print(f"'{sheet_date}' converted to: {datetime_obj}")

  # make sure it is 1st day of month
  ts_sheet_date = datetime_obj.replace(day=1)
  # print('Month: ', datetime_obj.month) # To Get month from date
  # print('Year: ', datetime_obj.year) # To Get month from year
  # print('Day: ', datetime_obj.day) # To Get month from year

  # print(f"'{datetime_obj}' converted to: {dt_sheet_date}")
  return ts_sheet_date


def days_of_month_pandas(pd_sheet_datetime)->pd.DatetimeIndex:
  # Create a date range for the month:
  # Use pd.date_range to generate a sequence of dates. The start parameter defines the first day of the month, and freq='D' ensures a daily frequency. The MonthEnd(1) offset from pandas.tseries.offsets is used to determine the last day of the month dynamically.
  start_date = pd.Timestamp(pd_sheet_datetime.year, pd_sheet_datetime.month, 1)
  # MonthEnd goes to the next date which is an end of the month.
  end_date = start_date + MonthEnd(1)

  daily_dates = pd.date_range(start=start_date, end=end_date, freq='D')
  return daily_dates
  # print(f"Days in {pd.Timestamp(pd_sheet_datetime.year, pd_sheet_datetime.month, 1).strftime('%B %Y')}:")
  # for day in daily_dates:
  #     print(day.strftime("%Y-%m-%d"))

def day_of_month_quantity(df: pd.DataFrame, daily_dates: pd.DatetimeIndex):
  print(f"days of month with values")
  # get_row_col(df,1,3)
  row=1
  col=3
  tot=0.0
  for day in daily_dates:
      value=get_row_col(df,row,col)
      tot+=value
      print(f"day: {day.strftime("%Y-%m-%d")},col={col},value={value}")
      col+=1
  # Get the month names from the DatetimeIndex
  month_name = daily_dates[1].month_name()
  # print("\nMonth name from DatetimeIndex:")
  # print(month_name)
  year = daily_dates[1].year    
  print(f"{month_name} {year} Total: {tot}")
  # print(f"{daily_dates[0].month_name} {daily_dates[0].year} Total: {tot}")

def machine_oil_quantity(df: pd.DataFrame, row: int, daily_dates: pd.DatetimeIndex):
  print(f"days of month with values")
  # get_row_col(df,1,3)
  # row=2
  col=3
  tot=0.0
  machine_id=get_row_col(df,row,0)
  oil_type=get_row_col(df,row,1)
  line_id=get_row_col(df,row,2)

  for day in daily_dates:
      value=get_row_col(df,row,col)
      tot+=value
      print(f"date:{day.strftime("%Y-%m-%d")},machine_id:{machine_id},oil_type:{oil_type},line_id:{line_id},col={col},value={value}")
      col+=1
  # Get the month names from the DatetimeIndex
  month_name = daily_dates[1].month_name()
  # print("\nMonth name from DatetimeIndex:")
  # print(month_name)
  year = daily_dates[1].year    
  print(f"{month_name} {year} Total: {tot}")
  # print(f"{daily_dates[0].month_name} {daily_dates[0].year} Total: {tot}")

def isValid(df:pd.DataFrame,row:int,col:int)->bool:
  # print(f"row={row},col={col}->{df.iloc[row,col]}")
  if df.isnull().iloc[row,col]:
    return False
  elif isinstance(df.iloc[row,col], (int, float)):
    return True
  else:
    return None

def isValid2(df:pd.DataFrame,row:int,col:int):
  data = [
      ['Alice',None,'New York'],
      ['Bob', 30, 'London'],
      ['Charlie', 22, 'Paris']
  ]
  df = pd.DataFrame(data, columns=['Name', 'Age', 'City'])
  print(df)

def isBlankLine(df:pd.DataFrame,row:int,col:int)->bool:

  if df.isnull().iloc[row,col]:
    return True
  else:
    return False

def isOilValueValid(df:pd.DataFrame,row:int,col:int):

  # print(f"row={row},col={col}->{df.iloc[row,col]}")
  if df.isnull().iloc[row,col]:
    return 1
  elif isinstance(df.iloc[row,col], (int, float)):
    return 2
  else:
    return 3

def main():
    df=pd.read_excel('OAMForMonth.xlsx',sheet_name=1)
    ts_sheet_datetime = get_sheet_date(df)
    print(f"sheet_date' {ts_sheet_datetime}")

    # Rename all 35 columns the sheet date. get_sheet_date will not work after this because it relies on the columns data to work.
    df.columns = ['c1','c2','c3','c4','c5','c6','c7','c8','c9','c10',
                  'c11','c12','c13','c14','c15','c16','c17','c18','c19','c20',
                  'c21','c22','c23','c24','c25','c26','c27','c28','c29','c30',
                  'c31','c32','c33','c34','c35']

    # column_names_index = df.columns
    # print(column_names_index)
    # column_names_list = df.columns.tolist()
    # print(column_names_list)

    # After renaming the columns, the sheet date is not accessible.
    # print(f'get_row_col(df,0,0)={get_row_col(df,0,0)}\nget_row_col(df,0,1)={get_row_col(df,0,1)}')

    # remove date row. it does not represent the column names so we don't need it.
    print(df.head(5))
    df_dropped_header_row = df.drop(0)
    # verify header row is dropped and column headings are good.
    # print(df_dropped_header_row.head(5))
    # print(df_dropped_header_row.tail(5))

    # Drop rows with null values in column 'c1'
    df_cleaned = df_dropped_header_row.dropna(subset=['c1'])
    print(df_cleaned.head(15))
    print(df_cleaned.tail(15))

    ## mispellings of machine names

    To check if values in a Pandas DataFrame column exist within a given list, 
    the Series.isin() method is the most efficient and recommended approach.
Here's how to use it:
    # Remove blank lines from dataframe
    # for row in range(1, len(df)-1):
    #   # skip blank lines
    #   col=0
    #   machine_id = get_row_col(df,row,col)
    #   if machine_id == 0.0:
    #     print(f"machine_id is null in row={row}")
    #     # don't include in new dataframe
    #   else:
    #   # row=29
    #     col=3
    #     oil_type=get_row_col(df,row,1)
    #     line_id=get_row_col(df,row,2)
    #     for day in daily_dates:
    #       value=isValid3(df,row,col)
    #       if value == 1:
    #           # print(f"Null: date:{day.strftime("%Y-%m-%d")},machine_id:{machine_id},oil_type:{oil_type},line_id:{line_id},col={col},val={value}")
    #           i=1
    #       elif value == 2:
    #           # print(f"OK: date:{day.strftime("%Y-%m-%d")},machine_id:{machine_id},oil_type:{oil_type},line_id:{line_id},col={col},value={value}")
    #           i=2
    #       elif value == 3:
    #           print(f"Other: date:{day.strftime("%Y-%m-%d")},machine_id:{machine_id},oil_type:{oil_type},line_id:{line_id},col={col},value={df.iloc[row,col]}")
    #       col+=1


    # daily_dates = days_of_month_pandas(pd_sheet_datetime)

 
    # print("Checking for non-numeric oil quantities...")
    # # Find all non-numeric oil quantities
    # # day_of_month_quantity(df,daily_dates)
    # row=1
    # for row in range(1, len(df)-1):
    #   # skip blank lines
    #   col=0
    #   machine_id = get_row_col(df,row,col)
    #   if machine_id == 0.0:
    #     print(f"machine_id is null in row={row}")
    #   else:
    #   # row=29
    #     col=3
    #     oil_type=get_row_col(df,row,1)
    #     line_id=get_row_col(df,row,2)
    #     for day in daily_dates:
    #       value=isValid3(df,row,col)
    #       if value == 1:
    #           # print(f"Null: date:{day.strftime("%Y-%m-%d")},machine_id:{machine_id},oil_type:{oil_type},line_id:{line_id},col={col},val={value}")
    #           i=1
    #       elif value == 2:
    #           # print(f"OK: date:{day.strftime("%Y-%m-%d")},machine_id:{machine_id},oil_type:{oil_type},line_id:{line_id},col={col},value={value}")
    #           i=2
    #       elif value == 3:
    #           print(f"Other: date:{day.strftime("%Y-%m-%d")},machine_id:{machine_id},oil_type:{oil_type},line_id:{line_id},col={col},value={df.iloc[row,col]}")
    #       col+=1

    # val = get_row_col(df,row,col)
    # print(f"row={row},col={col},val={val}")


    # for row in range(1, len(df)-1):
    # for row in range(1, 9):
    # for row in range(29, 30):
    #   # If the first column is not a machine name then skip that row
    #   val = get_row_col(df,row,col)
    #   if val!=0.0:
    #     machine_oil_quantity(df,row,daily_dates)

# How many rows in the dataframe
    # num_rows = len(df)
    # print(num_rows)

# How to handle blank lines. Line 7 is blank
    # The first line of the spreadsheet containing the date is not part of the dataframe. The second line containing the column headings is row 0 of the data frame.
    # row=7
    # col=0
    # val = get_row_col(df,row,col)
    # print(f"row={row},col={col},val={val}")
if __name__ == "__main__":
    main()