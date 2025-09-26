# **[](https://pythonhow.com/how/add-a-new-column-to-an-excel-file/)**

Here is how to add a new column to an Excel file in Python.
This guide assumes you have pandas and openpyxl installed. If not, you can install pandas and openpyxl by running pip install pandas openpyxl in your command line or terminal.

Step 1: Import pandas and read the Excel file
First, import the pandas library and use read_excel() to load your Excel file into a DataFrame. Replace 'your_file.xlsx' with the path to your Excel file.

```bash
import pandas as pd

# Load the Excel file

df = pd.read_excel('your_file.xlsx')
```
