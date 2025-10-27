# collections

## tuples

Tuples in Python are used in scenarios where **data immutability and ordered collections** are desired. Here are key situations where tuples are a suitable choice:
**Immutable Sequences:** When a collection of items should not be modified after creation, such as configuration settings, fixed coordinates, or database records that represent a single row. The immutability of tuples provides data integrity and can prevent accidental changes.
**Returning Multiple Values from Functions:** Functions often need to return more than one piece of information. Tuples are implicitly used for this purpose in Python, allowing a convenient way to bundle and return multiple results.
Python

```python
    def get_user_data(user_id):
        # ... fetch data ...
        return "John Doe", 30, "john.doe@example.com"

    name, age, email = get_user_data(123)
```

**Dictionary Keys:** Since tuples are immutable, they are hashable and can be used as keys in dictionaries, **unlike lists.(()) This is useful when a composite key, made of multiple values, is required.
Python

```python
    coordinates_data = {(10, 20): "Point A", (30, 40): "Point B"}
```

**Fixed-Size Collections of Heterogeneous Data:** When representing a fixed number of related items that may be of different data types, such as a person's name and age, or an RGB color value. Tuples explicitly convey that these elements belong together as a single entity.
Python

```python
    rgb_color = (255, 0, 128)
    employee_record = ("Alice", 45, "HR")
```
