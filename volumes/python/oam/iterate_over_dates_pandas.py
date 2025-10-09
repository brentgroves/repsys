#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "openpyxl",
#     "xlsxwriter",
#     "pandas",
# ]
# ///
# import datetime module
import pandas as pd
# The pandas.tseries module in the pandas library provides a robust and comprehensive set of tools for working with time series data. It is a fundamental part of pandas' strength in handling date and time-related operations.
from pandas.tseries.offsets import MonthEnd

year = 2025
month = 10  # October

# Create a date range for the month:
# Use pd.date_range to generate a sequence of dates. The start parameter defines the first day of the month, and freq='D' ensures a daily frequency. The MonthEnd(1) offset from pandas.tseries.offsets is used to determine the last day of the month dynamically.


start_date = pd.Timestamp(year, month, 1)
# MonthEnd goes to the next date which is an end of the month.
end_date = start_date + MonthEnd(1)

daily_dates = pd.date_range(start=start_date, end=end_date, freq='D')

print(f"Days in {pd.Timestamp(year, month, 1).strftime('%B %Y')}:")
for day in daily_dates:
    print(day.strftime("%Y-%m-%d"))