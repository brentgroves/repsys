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

df1 = pd.DataFrame({'product_code': ['P001', 'P002', 'P003'],
'store_location': ['New York', 'Los Angeles', 'Chicago'],
'stock_quantity': [120, 150, 200]})

df2 = pd.DataFrame({'code': ['P001', 'P002', 'P004'],
'store': ['New York', 'Los Angeles', 'Houston'],
'price': [15.5, 20.0, 25.0]})

# Merging on multiple columns ('product_code' and 'store_location')
res = pd.merge(df1, df2, left_on=['product_code', 'store_location'], right_on=['code', 'store'], how='inner')
print(res)

#   product_code store_location  stock_quantity  code        store  price
# 0         P001       New York             120  P001     New York   15.5
# 1         P002    Los Angeles             150  P002  Los Angeles   20.0