# **[Null in Python](https://www.geeksforgeeks.org/python/null-in-python/)**

Last Updated : 23 Jul, 2025
In Python, None represents the absence of a value and is the only instance of the NoneType. It's often used as a placeholder for variables that don't hold meaningful data yet. Unlike 0, "" or [], which are actual values, None specifically means "no value" or "nothing." Example:

```python
a = None

if a is None:
  print("True")
else:
  print("False")
```

Output
`True`

Explanation: This code checks if the variable a holds the value None. Since a is explicitly set to None, the condition a is None evaluates to True, so it prints "True".

## Some key points of null

- None is treated as False in boolean contexts.
- It is always checked using the is keyword, not ==, for accuracy.
- Comparing None to any other value (except itself) returns False.
- It is commonly used as the default return value of functions, for optional function arguments and as a placeholder for future assignments.

## Use cases of null

Null is often used in scenarios where a value is not yet assigned, not applicable or intentionally missing. Below are the key use cases of None.

## 1. Default function return

Functions that don't explicitly specify a return value will automatically return None. This signifies the absence of a meaningful result and is the default behavior in Python when no return statement is provided or when the return keyword is used without a value.

```python
def fun():
    pass
​
print(fun())
```

Output
None

Explanation: fun() does nothing because it contains only a pass statement. When it is called, it returns None by default since there is no return statement

## 2. Used as a placeholder

None is commonly used as a placeholder for optional function arguments or variables that have not yet been assigned a value. It helps indicate that the variable is intentionally empty or that the argument is optional, allowing flexibility in handling undefined or default values in Python programs.

```python
x = None 

if x is None:
    print("x has no value")
```

Output
x has no value
Explanation: x is set to None and the condition checks if x has no value. Since it's true, it prints "x has no value".

## 3. Optional function arguments

Optional function arguments allow you to define default values for parameters, making them optional when calling the function. If no value is provided, the parameter uses the default value.

```python
def greet(name=None):
    
    if name is None:
        return "Hello, World!"
    return f"Hello, {name}!"

print(greet()) 
print(greet("GeeksforGeeks"))
```

Output
Hello, World!
Hello, GeeksforGeeks!

Explanation: This function checks if name is None. If true, it returns a default greeting. Otherwise, it returns a personalized greeting. So, it prints "Hello, World!" and "Hello, GeeksforGeeks!".

## 4. Indicating missing result in conditional logic

None can be used directly in your logic to represent a missing or undefined result, especially when scanning or checking values.

```python
nums = [1, 3, 5]
result = None

for n in nums:
    if n % 2 == 0:
        result = n
        break

if result is None:
    print("No even number found")
else:
    print("First even number:", result)
```

Output
No even number found
Explanation: This code tries to find the first even number in a list. Since there are none, result remains None and the program prints that no even number was found.
