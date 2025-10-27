# **[Different ways to create Pandas Dataframe](https://www.geeksforgeeks.org/python/different-ways-to-create-pandas-dataframe/)**

<https://jupyter.org/try-jupyter/lab/>

Last Updated : 11 Jul, 2025
It is the most commonly used Pandas object. The pd.DataFrame() function is used to create a DataFrame in Pandas. There are several ways to create a Pandas Dataframe in Python.

Example: Creating a DataFrame from a Dictionary

```python
import pandas as pd

# initialize data of lists

data = {'Name': ['Tom', 'nick', 'krish', 'jack'],
        'Age': [20, 21, 19, 18]}

# Create DataFrame

df = pd.DataFrame(data)

print(df)
```

Explanation: Here, a dictionary named data is created. The dictionary contains two keys: 'Name' and 'Age'.

- The value for 'Name' is a list of names: ['Tom', 'nick', 'krish', 'jack'].
- The value for 'Age' is a list of corresponding ages: [20, 21, 19, 18].

This dictionary structure is suitable for creating a DataFrame, as it allows each key to represent a column in the resulting DataFrame.
