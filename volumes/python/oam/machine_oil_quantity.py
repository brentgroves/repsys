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

def get_row(df,row):
  print(f"row->{df.iloc[row]}")

def get_row_col(df:pd.DataFrame,row:int,col:int)->float:
  # print(f"row={row},col={col}->{df.iloc[row,col]}")
  
  if df.isnull().iloc[row,col]:
    value =  0.00
  else:
    value =  df.iloc[row,col]
  return value

def get_sheet_date(df):

  column_names_list = df.columns.tolist()
  # print(column_names_list)

  sheet_date= column_names_list[1]

  datetime_obj = pd.to_datetime(sheet_date, format='%Y/%m/%d')
  # print(f"'{sheet_date}' converted to: {datetime_obj}")

  # make sure it is 1st day of month
  dt_sheet_date = datetime_obj.replace(day=1)
  # print('Month: ', datetime_obj.month) # To Get month from date
  # print('Year: ', datetime_obj.year) # To Get month from year
  # print('Day: ', datetime_obj.day) # To Get month from year

  # print(f"'{datetime_obj}' converted to: {dt_sheet_date}")
  return dt_sheet_date


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
  col=3
  tot=0.0
  line_id=get_row_col(df,row,2)
  machine_id=get_row_col(df,row,0)
  oil_type=get_row_col(df,row,1)

  for day in daily_dates:
      value=get_row_col(df,row,col)
      tot+=value
      print(f"date:{day.strftime("%Y-%m-%d")},line_id:{line_id},machine_id:{machine_id},oil_type:{oil_type},col={col},value={value}")
      col+=1
  # Get the month names from the DatetimeIndex
  month_name = daily_dates[1].month_name()
  # print("\nMonth name from DatetimeIndex:")
  # print(month_name)
  year = daily_dates[1].year    
  print(f"{month_name} {year} Total: {tot}")
  # print(f"{daily_dates[0].month_name} {daily_dates[0].year} Total: {tot}")

def main():
    # Your main program logic goes here
    print("This is the main function.")
    # Call other functions or perform operations
    df=pd.read_excel('OAMForMonth.xlsx',sheet_name=1)
    pd_sheet_datetime = get_sheet_date(df)
    print(f"sheet_date' {pd_sheet_datetime}")

    daily_dates = days_of_month_pandas(pd_sheet_datetime)

    # # day_of_month_quantity(df,daily_dates)
    row=2
    machine_oil_quantity(df,row,daily_dates)

if __name__ == "__main__":
    main()