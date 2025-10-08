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
from datetime import timedelta

  year = 2025
    month = 10  # October
Create a date range for the specified month:
Python

    start_date = datetime(year, month, 1)
    # The 'freq="D"' argument ensures daily frequency
    # The 'pd.Period(start_date).days_in_month' gets the correct number of days for the month
    date_range = pd.date_range(start=start_date, periods=pd.Period(start_date).days_in_month, freq='D')
Loop through the dates in the range:
Python

    for day in date_range:
        print(day.strftime("%Y-%m-%d"))