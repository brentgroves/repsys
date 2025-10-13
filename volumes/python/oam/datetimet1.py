#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "openpyxl",
#     "xlsxwriter",
#     "pandas",
#     "IPython"
# ]
# ///
import pandas as pd
# from datetime import datetime, timedelta
from pandas.tseries.offsets import MonthEnd

import datetime as sldt # dt.date = pandas...timestamp.date
from IPython.display import display
# import datetime # works for datetime.date()
# from datetime import date # works for date()

# df = pd.read_csv('https://raw.githubusercontent.com/m-mehdi/pandas_tutorials/main/server_util.csv')
# display(df.head())
# df['datetime'] = pd.to_datetime(df['datetime'])
# print(df.info())

df = pd.read_csv('https://raw.githubusercontent.com/m-mehdi/pandas_tutorials/main/server_util.csv', parse_dates=['datetime'])
# print(df.head())

# Set time column as index
df = df.set_index('datetime')

df=df[df.server_id == 100].resample('D')['cpu_utilization', 'free_memory', 'session_count'].mean()
# df=df[df.server_id == 100]
print(df)
# # df[df.server_id == 100].resample('D')['cpu_utilization', 'free_memory', 'session_count'].mean()
# df.resample('D')['cpu_utilization', 'free_memory', 'session_count'].mean()