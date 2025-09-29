# **[](https://python.land/data-processing/process-excel-data-in-python-and-pandas#:~:text=Note%20that%20the%20append%20mode,to%20an%20empty%20Excel%20file.)**

## Create an Excel File Using a List of Lists in Python

To create an Excel file using a list of lists in Python, we will first create a pandas dataframe using the DataFrame() function. Here, we will pass the list of lists as the first input argument and a list of column names as input to the columns parameter.

After executing the DataFrame() function, we get a pandas dataframe containing the data from the list of lists.  Next, we can use the ExcelWriter() function to open an Excel file in write mode and export the pandas dataframe to an Excel sheet using the to_excel() method.

```python
import pandas as pd

# Define a list of lists
data=[["Aditya",179],
      ["Sameer",181],
      ["Dharwish",170],
      ["Joel",167]]

# Define column names
column_names=["Name", "Height"]

# Create a pandas dataframe using the list of lists
df=pd.DataFrame(data, columns=column_names)
writer = pd.ExcelWriter('excel_with_list.xlsx', engine='xlsxwriter')

# Add the pandas dataframe to the excel file as sheet
df.to_excel(writer, sheet_name='first_sheet')
writer.close()
```

The above Excel file shows that the sheet contains an extra unnamed column with index counts. To avoid this, you can set the index parameter to False in the to_excel() method. After this, you will get the Excel file with only the desired columns:

...
`df.to_excel(writer, sheet_name='first_sheet',index=False)`
...
Code language: Python (python)
In the above code, we have set the index parameter to False. Hence, we will get an Excel without the unnamed column:
