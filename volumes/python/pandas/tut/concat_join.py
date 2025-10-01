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

df1 = pd.DataFrame({'A': ['A0', 'A1'], 'B': ['B0', 'B1'],
                    'key': ['K0','K1']})
df2 = pd.DataFrame({'B': ['B2', 'B3'], 'C': ['C2', 'C3'],
                    'key': ['K1','K2']})

result_default = pd.concat([df1, df2],join='outer')
result_inner = pd.concat([df1, df2],join='inner')
print("Concatenation with 'join'='outer':")
print(result_default)

print("Concatenation with 'join'='inner':")
print(result_inner)

# Concatenation with 'join'='outer':
#      A   B key    C
# 0   A0  B0  K0  NaN
# 1   A1  B1  K1  NaN
# 0  NaN  B2  K1   C2
# 1  NaN  B3  K2   C3
# Concatenation with 'join'='inner':
#     B key
# 0  B0  K0
# 1  B1  K1
# 0  B2  K1
# 1  B3  K2