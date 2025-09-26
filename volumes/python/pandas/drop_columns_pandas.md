# **[How to drop one or multiple columns in Pandas DataFrame](https://www.geeksforgeeks.org/python/how-to-drop-one-or-multiple-columns-in-pandas-dataframe/)**

Last Updated : 11 Jul, 2025
Let's learn how to drop one or more columns in Pandas DataFrame for data manipulation.

Drop Columns Using df.drop() Method
Let's consider an example of the dataset (data) with three columns 'A', 'B', and 'C'. Now, to drop a single column, use the drop() method with the column’s name.

```python
import pandas as pd

# df = pd.read_excel('oem.xlsx', sheet_name='Sheet1')
df = pd.read_excel('oem.xlsx', sheet_name='oam')

# Syntax: df = df.drop('ColumnName', axis=1)


# Drop column 'B'
df = data.drop(data.iloc[:, 1:5], axis=1)
print(df)
```
