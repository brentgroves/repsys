# **[connect]()**

## references

- **[certificates](https://stackoverflow.com/questions/72902269/sqlalchemy-pyodbc-how-to-trust-certificate)**
- **[certificate changes](https://techcommunity.microsoft.com/t5/sql-server-blog/odbc-driver-18-0-for-sql-server-released/ba-p/3169228)**

# 3 Create virtual environment

```bash
# add env/ folder to gitignore
conda deactivate
pushd .
cd ~/src/repsys/volumes/python/tutorials/odbc
# python3.8 -m venv env if multiple versions of python are installed using deadsnakes ppa
python3 -m venv env
source env/bin/activate
pip install pyodbc
pip list              
Package    Version
---------- -------
pip        22.0.2
pyodbc     5.1.0
setuptools 59.6.0
```

To connect to database do

```python
import pytds
with pytds.connect('server', 'database', 'user', 'password') as conn:
    with conn.cursor() as cur:
        cur.execute("select 1")
        cur.fetchall()
```
