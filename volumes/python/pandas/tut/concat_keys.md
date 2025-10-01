# **[concat](https://pandas.pydata.org/docs/reference/api/pandas.concat.html)**

In pandas, when using the pd.concat() function to combine multiple Series or DataFrame objects, the keys parameter allows the creation of a hierarchical index (MultiIndex) in the resulting concatenated object. This hierarchical index provides a way to identify the source of each row or column in the combined data.

How keys works:
Vertical Concatenation (default, axis=0): When concatenating DataFrames or Series vertically (stacking them on top of each other), providing a list of strings to the keys parameter will create an outer level in the index. Each string in the keys list will correspond to the respective DataFrame or Series in the input list, effectively labeling the origin of the rows.

concat_keys.md

```python
    import pandas as pd

    df1 = pd.DataFrame({'A': [1, 2], 'B': [3, 4]})
    df2 = pd.DataFrame({'A': [5, 6], 'B': [7, 8]})

    result = pd.concat([df1, df2], keys=['df1_data', 'df2_data'])
    print(result)
```

In this example, the resulting DataFrame will have a MultiIndex where the first level indicates whether the row originated from df1_data or df2_data.

Horizontal Concatenation (axis=1): When concatenating DataFrames or Series horizontally (side-by-side, adding columns), the keys parameter will create an outer level in the columns index. Each string in the keys list will label the columns originating from the corresponding input object.

```python
    import pandas as pd

    df1 = pd.DataFrame({'A': [1, 2], 'B': [3, 4]})
    df2 = pd.DataFrame({'C': [5, 6], 'D': [7, 8]})

    result = pd.concat([df1, df2], axis=1, keys=['group_one', 'group_two'])
    print(result)
```

  group_one    group_two
          A  B         C  D
0         1  3         5  7
1         2  4         6  8

Benefits of using keys:
Data Provenance: Clearly identifies which original DataFrame or Series each piece of data came from.
Easier Selection: Allows for easy selection of data belonging to a specific source using the hierarchical index.
Organization: Improves the organization and readability of the combined DataFrame, especially when dealing with many input objects.
