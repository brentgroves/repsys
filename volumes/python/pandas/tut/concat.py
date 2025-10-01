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

# df1 = pd.DataFrame({'A': ['A0', 'A1'], 'B': ['B0', 'B1']})
# df2 = pd.DataFrame({'A': ['A2', 'A3'], 'B': ['B2', 'B3']})

df1 = pd.DataFrame({'A': ['A0', 'A1'], 'B': ['B0', 'B1']})
df2 = pd.DataFrame({'A': ['A2', 'A0'], 'B': ['B2', 'B3']})

# result_row_concat = pd.concat([df1, df2])
# ignore_index: If True
# result_row_concat = pd.concat([df1, df2],ignore_index=True)

# join: This specifies how to handle the overlapping labels along the specified axis. It can take values like “outer” (default), “inner,” 
# result_row_concat = pd.concat([df1, df2],join='outer')
# Concatenated along rows:
#      A   B
# 0  A0  B0
# 1  A1  B1
# 0  A2  B2
# 1  A0  B3

result_row_concat = pd.concat([df1, df2],join='inner')
# Concatenated along rows:
#      A   B
# 0  A0  B0
# 1  A1  B1
# 0  A2  B2
# 1  A0  B3

# keys: This parameter allows you to create a hierarchical index (MultiIndex) on the concatenation axis, which can be useful for identifying the source of each part of the concatenated data.
# result_row_concat = pd.concat([df1, df2],keys=True)

print("Concatenated along rows:\n", result_row_concat)
