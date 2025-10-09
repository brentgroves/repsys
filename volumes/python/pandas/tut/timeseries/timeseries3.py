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
from datetime import datetime
import numpy as np

# range_Date
# A Pandas DatetimeIndex is an immutable sequence of datetime64 data, primarily used as an index for DataFrame or Series objects to enable time-based operations. It allows for efficient handling of time series data.
rd = pd.date_range(start ='1/1/2019', end ='1/08/2019',freq ='Min')

df = pd.DataFrame(rd, columns =['date'])
df['data'] = np.random.randint(0, 100, size =(len(rd)))

# string_data
    # List comprehension: creates a list of squares
    # squares = [i * i for i in range(5)]  # [0, 1, 4, 9, 16]
s = [str(x) for x in rd]
print(s[1:11])
