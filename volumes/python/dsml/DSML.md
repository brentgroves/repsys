# **[Data Science and Machine Learning: Mathematical and Statistical Methods](https://github.com/DSML-book/)**

## start here (page: 4)

- **[dsml](https://people.smp.uq.edu.au/DirkKroese/DSML/)**

`https://vincentarelbundock.github.io/Rdatasets/csv/datasets/iris.csv`
`https://raw.githubusercontent.com/prudhvinathreddymalla/Abalone-Dataset/refs/heads/master/Abalone%20Dataset.csv`
`https://www.biostatisticien.eu/springeR/nutrition_elderly.xls`
<https://www.biostatisticien.eu/springeR/nutrition_elderly.xls>
<https://www.biostatisticien.eu/springeR/nutrition_elderly.xls>

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
