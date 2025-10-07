# **[]()**

To loop through the days of a month in Python, you can utilize the datetime and calendar modules.
Here are a few methods:

## 1. Using datetime and timedelta

This method allows you to iterate through a range of dates, starting from the first day of the month and ending on the last.
Python

import datetime

year = 2025
month = 10  # October

start_date = datetime.date(year, month, 1)

# Calculate the last day of the month

if month == 12:
    end_date = datetime.date(year + 1, 1, 1) - datetime.timedelta(days=1)
else:
    end_date = datetime.date(year, month + 1, 1) - datetime.timedelta(days=1)

current_date = start_date
while current_date <= end_date:
    print(current_date)
    current_date += datetime.timedelta(days=1)
