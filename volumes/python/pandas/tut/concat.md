# **[concat](https://builtin.com/articles/pandas-concat#:~:text=Pandas.concat()%20Function%20Syntax,The%20default%20is%20False%2C%20however.)**

The pandas.concat() function is used to concatenate pandas objects, such as Series or DataFrames, along a specified axis. This function provides a flexible way to combine data, similar to how you might append rows in a spreadsheet or join columns in a database.

Key Parameters of pandas.concat():

- objs: This is a sequence or mapping of the Series or DataFrame objects you want to concatenate. It's typically a list of DataFrames.

- axis: This parameter determines the axis along which the concatenation will occur.
  - axis=0 (default): Concatenates along rows, stacking the DataFrames vertically.
  - axis=1: Concatenates along columns, placing the DataFrames side-by-side.

- join: This specifies how to handle overlapping labels (indexes or columns) along the non-concatenation axis.
  - 'outer' (default): Returns the union of the labels, filling missing values with NaN.
  - 'inner': Returns the intersection of the labels, only including shared labels.

- ignore_index: If True, the original index of the concatenated objects is discarded, and a new default integer index (0 to n-1) is assigned to the resulting object. This is useful when the original indexes are not meaningful or contain duplicates.
- keys: This parameter allows you to create a hierarchical index (MultiIndex) on the concatenation axis, which can be useful for identifying the source of each part of the concatenated data.

Example Usage:
Concatenating DataFrames along rows (default axis=0):
Python

```python
import pandas as pd

df1 = pd.DataFrame({'A': ['A0', 'A1'], 'B': ['B0', 'B1']})
df2 = pd.DataFrame({'A': ['A2', 'A3'], 'B': ['B2', 'B3']})

result_row_concat = pd.concat([df1, df2])
print("Concatenated along rows:\n", result_row_concat)
```
