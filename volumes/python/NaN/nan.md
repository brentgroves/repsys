# **[How to Check for NaN Values in Python?[With Examples]](https://www.turing.com/kb/nan-values-in-python)**

NaN (Not a Number) is a special value representing missing or undefined Python data. Dealing with NaN values is crucial in data analysis and scientific computing. In this article, we will explore various methods to check for NaN in Python, accompanied by practical examples. Whether you are working with numerical data, handling missing values, or performing data quality checks, this article on how to detect NaN in Python will significantly enhance your data analysis skills.

## Understanding NaN in Python

Before we dive into the methods of checking for NaN values, let's understand the difference between NaN, zero, and empty values in Python.

- **NaN (Not a Number):** NaN represents missing or undefined data in Python. It is typically encountered while performing mathematical operations that result in an undefined or nonsensical value. NaN is a floating-point value represented by the float('nan') object in Python.
- **Zero:** Zero (0) is a numerical value that represents a valid number indicating nothing or the absence of quantity. It is not the same as NaN, as NaN represents a specific numeric value.
- **Empty:** Empty values refer to variables or objects that have not been assigned any value. They differ from NaN and zero, as they represent the absence of any value or data.

Understanding these distinctions is essential, as differentiating between NaN, zero, and empty values helps in accurately identifying and handling missing or undefined data in Python.

## Ways to check NaN value in Python

Using the `math.isnan()` Function

The math module in Python provides the isnan() function, which can be used to check if a value is NaN. This method works only with floating-point values. Here's an example:

```python
import math 

value = 5.2 
if math.isnan(value): 
    print("Value is NaN") 
else: 
    print("Value is not NaN"
```

This method returns True if the value is NaN, and False otherwise.

## Using the numpy.isnan() Function

If you're working with arrays or large datasets, the NumPy library provides a convenient function called isnan() to check for NaN in Python values. This method works efficiently with both scalar values and arrays. Consider the following example:

```python
import numpy as np 

data = np.array([1.2, np.nan, 3.4, np.nan]) 
nan_indices = np.isnan(data) 
print(nan_indices)
```

The output will be a Boolean array indicating the positions of NaN values in the data array. True represents NaN values, while False represents non-NaN values.
