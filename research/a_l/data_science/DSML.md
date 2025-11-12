# notes

`https://vincentarelbundock.github.io/Rdatasets/csv/datasets/iris.csv`
`https://raw.githubusercontent.com/prudhvinathreddymalla/Abalone-Dataset/refs/heads/master/Abalone%20Dataset.csv`

```python
from ucimlrepo import fetch_ucirepo
# fetch dataset
abalone = fetch_ucirepo(id=1)
# data (as pandas dataframes)
X = abalone.data.features
y = abalone.data.targets
# metadata
print(abalone.metadata)
# variable information
print(abalone.variables)
```
