# how to fetch data
<https://jupyter.org/try-jupyter/lab/>
<https://github.com/pandas-dev/pandas/issues/46682>

```python
import pandas as pd
import matplotlib.pyplot as plt
from js import fetch
from io import StringIO

# URL = "https://gist.github.com/netj/8836201/raw/6f9306ad21398ea43cba4f7d537619d0e07d5ae3/iris.csv"
url = 'https://raw.githubusercontent.com/jcanalesluna/courses_materials/master/datasets/Madrid%20Daily%20Weather%201997-2015.csv'

res = await fetch(url)
text = await res.text()
text
# # url = 'https://raw.githubusercontent.com/jcanalesluna/courses_materials/master/datasets/Madrid%20Daily%20Weather%201997-2015.csv'
df = pd.read_csv(StringIO(text), usecols=['CET', 'Max TemperatureC', 'Mean TemperatureC', 'Min TemperatureC'])
# df = pd.read_csv(StringIO(text))
df
```
