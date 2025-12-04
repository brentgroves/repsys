# **[Working with missing data](https://pandas.pydata.org/docs/user_guide/missing_data.html#missing-data)**

Values considered “missing”
pandas uses different sentinel values to represent a missing (also referred to as NA) depending on the data type.

numpy.nan for NumPy data types. The disadvantage of using NumPy data types is that the original data type will be coerced to np.float64 or object.
