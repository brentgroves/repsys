# **[connect]()**

# 3 Create virtual environment

```bash
# add env/ folder to gitignore
conda deactivate
pushd .
cd ~/src/repsys/volumes/python/tutorials/tds
# python3.8 -m venv env if multiple versions of python are installed using deadsnakes ppa
python3 -m venv env
source env/bin/activate
pip install python-tds
pip list              
Package    Version
---------- -------
pip        22.0.2
python-tds 1.15.0
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
