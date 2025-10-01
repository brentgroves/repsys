# **[](https://www.geeksforgeeks.org/pandas/merge-join-two-dataframes-on-multiple-columns-in-pandas/)**

Merge/Join Two Dataframes on Multiple Columns in Pandas
Last Updated : 23 Jul, 2025
When working with large datasets, it's common to combine multiple DataFrames based on multiple columns to extract meaningful insights. Pandas provides the merge() function, which enables efficient and flexible merging of DataFrames based on one or more keys. This guide will explore different ways to merge DataFrames on multiple columns, including inner, left, right and outer joins.

Example: Merging DataFrames on Multiple Columns with Different Names
Sometimes, the common columns are present but have different names. Instead of renaming them manually, we can specify the column names separately for each DataFrame using left_on and right_on.

```python
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
```
