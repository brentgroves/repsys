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
from pandas.tseries.offsets import MonthEnd

year = 2025
month = 10  # October

start_date = pd.Timestamp(year, month, 1)
end_date = start_date + MonthEnd(1)

daily_dates = pd.date_range(start=start_date, end=end_date, freq='D')

print(f"Days in {pd.Timestamp(year, month, 1).strftime('%B %Y')}:")
for day in daily_dates:
    print(day.strftime("%Y-%m-%d"))