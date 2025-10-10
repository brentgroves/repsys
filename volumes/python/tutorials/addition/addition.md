# addition

in python can a function to the right of an addition operator know the value to the left of the operator

In Python, when an addition operation is performed, the function or method on the right side of the + operator can potentially "know" the value on the left side, but not directly as an argument passed to it. This interaction occurs through a mechanism called operator overloading, specifically using "dunder methods" (double underscore methods).

## Here's how it works

__add__ (Left-hand operation): When you write a + b, Python first attempts to call the __add__ method of the object a (the left operand). If a has a defined __add__ method, it receives b (the right operand) as an argument and can use its own value and b's value to perform the addition.
__radd__ (Right-hand operation): If a does not have an __add__ method, or if its __add__ method indicates that it cannot handle the addition with b (e.g., by returning NotImplemented), Python then attempts to call the __radd__ method of the object b (the right operand). If b has a defined __radd__ method, it receives a (the left operand) as an argument. In this case, the function on the right (b's __radd__ method) explicitly receives the value from the left (a) and can perform the operation.

Therefore, while the function on the right doesn't automatically know the left value in all scenarios, if the left operand's __add__ method doesn't handle the operation, Python will then call the right operand's __radd__ method, explicitly passing the left operand's value to it.

```python
class MyLeftClass:
    def __init__(self, value):
        self.value = value

    def __add__(self, other):
        if isinstance(other, MyRightClass):
            # MyLeftClass's __add__ can handle MyRightClass
            print(f"MyLeftClass's __add__ called. Left: {self.value}, Right: {other.value}")
            return self.value + other.value
        return NotImplemented # Delegate to __radd__ if not handled

class MyRightClass:
    def __init__(self, value):
        self.value = value

    def __radd__(self, other):
        # MyRightClass's __radd__ is called when MyLeftClass's __add__ returns NotImplemented
        print(f"MyRightClass's __radd__ called. Left: {other.value}, Right: {self.value}")
        return other.value + self.value

# Example 1: __add__ handles it
obj_left = MyLeftClass(10)
obj_right = MyRightClass(5)
result = obj_left + obj_right # Output: MyLeftClass's __add__ called. Left: 10, Right: 5

# Example 2: __radd__ handles it (if MyLeftClass didn't handle MyRightClass)
# If MyLeftClass's __add__ returned NotImplemented for MyRightClass, 
# then MyRightClass's __radd__ would be called.
# For demonstration, let's create a scenario where __radd__ would be invoked:
class AnotherLeftClass:
    def __init__(self, value):
        self.value = value
    # No __add__ method or one that returns NotImplemented for MyRightClass

another_left = AnotherLeftClass(20)
another_right = MyRightClass(3)
result2 = another_left + another_right # Output: MyRightClass's __radd__ called. Left: 20, Right: 3
```
