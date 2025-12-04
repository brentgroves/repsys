# drop rows

AI Overview
To drop rows with null values in a pandas DataFrame, the dropna() method is used. This method offers various parameters to control how null values are handled.

1. Dropping rows with any null value:
To remove any row that contains at least one null (NaN) value across any of its columns, use the dropna() method without any specific arguments or with how='any'.
Python

import pandas as pd
import numpy as np

```python
# Sample DataFrame

df = pd.DataFrame({
    'A': [1, 2, np.nan, 4],
    'B': [5, np.nan, 7, 8],
    'C': [9, 10, 11, np.nan]
})

# Drop rows with any null value

df_cleaned = df.dropna()
print(df_cleaned)
```
