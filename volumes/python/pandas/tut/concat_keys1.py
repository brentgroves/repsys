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
df2 = pd.DataFrame({'C': [5, 6], 'D': [7, 8]})

result = pd.concat([df1, df2], axis=1, keys=['group_one', 'group_two'])
print(result)

#   group_one    group_two   
#           A  B         C  D
# 0         1  3         5  7
# 1         2  4         6  8