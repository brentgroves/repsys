# ETL Process Overview

Hi Jared,

Welcome to our team. You can jump right in and use Power BI by accessing Plex directly, or go deeper and learn Python and our ETL process. Please feel free to reach out to me.

Thanks

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

## **[SQL CTEs](https://www.datacamp.com/tutorial/cte-sql)**

It is a way to make complex tasks easier by dividing them into smaller ones.

## Data Warehouse

We have a data warehouse for your use. The idea is to transfer data that you need to report on to a centralized database.

## **[ETL Process](https://www.geeksforgeeks.org/etl-process-in-data-warehouse/)**

To get data into our data warehouse, we use Python or Golang.

## Python Plex ODBC ETL script

```python
#!/usr/bin/env python
import pyodbc 
from datetime import datetime
import sys 
import os
# https://docs.microsoft.com/en-us/sql/connect/python/pyodbc/step-3-proof-of-concept-connecting-to-sql-using-pyodbc?view=sql-server-ver16
# https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/programming-guidelines?view=sql-server-ver16
# https://github.com/mkleehammer/pyodbc/wiki/Calling-Stored-Procedures
# https://thepythonguru.com/fetching-records-using-fetchone-and-fetchmany/
# https://code.google.com/archive/p/pyodbc/wikis/Cursor.wiki
def print_to_stdout(*a):
    # Here a is the array holding the objects
    # passed as the argument of the function
    print(os.path.basename(__file__)+':',*a, file = sys.stdout)


def print_to_stderr(*a):
    # Here a is the array holding the objects
    # passed as the argument of the function
    print(os.path.basename(__file__)+':',*a, file = sys.stderr)
    
try:
  ret = 0
  # pass secrets as parameters
  pcn_list = (sys.argv[1])
  username = (sys.argv[2])
  password = (sys.argv[3])
  username2 = (sys.argv[4])
  password2 = (sys.argv[5])
  username3 = (sys.argv[6])
  password3 = (sys.argv[7])
  mysql_host = (sys.argv[8])
  mysql_port = (sys.argv[9])
  azure_dw = (sys.argv[10])

    # https://geekflare.com/calculate-time-difference-in-python/
  start_time = datetime.now()
  end_time = datetime.now()

  current_time = start_time.strftime("%H:%M:%S")
  print_to_stdout(f"Current Time: {current_time=}")

  # https://docs.microsoft.com/en-us/sql/connect/python/pyodbc/step-1-configure-development-environment-for-pyodbc-python-development?view=sql-server-ver15
  # password = 'wrong' 
  conn = pyodbc.connect('DSN=Plex;UID='+username+';PWD='+ password)
  # https://stackoverflow.com/questions/11451101/retrieving-data-from-sql-using-pyodbc
  cursor = conn.cursor()
# accounting_account_DW_Import
# Plex call
  cursor.execute("{call sproc300758_11728751_1978024 (?)}", pcn_list)
  rows = cursor.fetchall()

  cursor.close()
  fetch_time = datetime.now()
  tdelta = fetch_time - start_time 
  print_to_stdout(f"fetch_time={tdelta}") 
  conn2 = pyodbc.connect('DSN=dw;UID='+username2+';PWD='+ password2 + ';DATABASE=mgdw')
  cursor2 = conn2.cursor()
   # https://code.google.com/archive/p/pyodbc/wikis/GettingStarted.wiki
  txt = "delete from Plex.accounting_account where pcn in ({dellist:s})"
  # https://github.com/mkleehammer/pyodbc/wiki/Cursor
  # The return value is always the cursor itself:
  rowcount=cursor2.execute(txt.format(dellist = pcn_list)).rowcount
  print_to_stdout(f"{txt} - rowcount={rowcount}")
  print_to_stdout(f"{txt} - messages={cursor2.messages}")
      
  cursor2.commit()
  # https://github.com/mkleehammer/pyodbc/wiki/Cursor
  # https://github.com/mkleehammer/pyodbc/wiki/Features-beyond-the-DB-API#fast_executemany
  # https://towardsdatascience.com/how-i-made-inserts-into-sql-server-100x-faster-with-pyodbc-5a0b5afdba5
  im2='''insert into Plex.accounting_account
  values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)''' 
  cursor2.fast_executemany = True
  cursor2.executemany(im2,rows)
  cursor2.commit()
  cursor2.close()

except pyodbc.Error as ex:
  ret = 1
  error_msg = ex.args[1]
  print_to_stderr(error_msg) 

except BaseException as error:
    ret = 1
    print('An exception occurred: {}'.format(error))

finally:
    end_time = datetime.now()
    tdelta = end_time - start_time 
    print_to_stdout(f"total time: {tdelta}") 
    if 'conn' in globals():
        conn.close()
    if 'conn2' in globals():
        conn2.close()
    sys.exit(ret)

```

## Ubuntu

A Ubuntu VM with access to Python and our data sources.
