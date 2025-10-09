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

# range_date

rd = pd.date_range(start ='1/1/2019', end ='1/08/2019',freq ='Min')
df = pd.DataFrame(rd, columns =['date'])
df['data'] = np.random.randint(0, 100, size =(len(rd)))

print(df.head(10))