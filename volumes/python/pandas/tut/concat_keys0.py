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

df1 = pd.DataFrame({'A': [1, 2], 'B': [3, 4]})
df2 = pd.DataFrame({'A': [5, 6], 'B': [7, 8]})

result = pd.concat([df1, df2], keys=['df1_data', 'df2_data'])
print(result)

#             A  B
# df1_data 0  1  3
#          1  2  4
# df2_data 0  5  7
#          1  6  8

In this example, the resulting DataFrame will have a MultiIndex where the first level indicates whether the row originated from df1_data or df2_data.
