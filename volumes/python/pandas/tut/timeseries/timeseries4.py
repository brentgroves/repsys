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
import numpy as np

range_data = pd.date_range(start='1/1/2019', end='1/08/2019', freq='Min')

df = pd.DataFrame(range_data, columns=['datetime'])
df['data'] = np.random.randint(0, 100, size=(len(range_data)))

df.set_index('datetime', inplace=True)

filtered_df = df.loc['2019-01-05']  
print(filtered_df.iloc[1:11])