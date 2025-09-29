# **[](https://python.land/data-processing/process-excel-data-in-python-and-pandas#:~:text=Note%20that%20the%20append%20mode,to%20an%20empty%20Excel%20file.)**

Update an Excel File in Python
To update an Excel file in Python using the pandas module, we will use the “openpyxl” module by using the engine parameter in the ExcelWriter() function. This will allow us to open the Excel files in append mode. After this, we can perform different update operations, as discussed in the following subsections.

Add a Sheet to an Existing Excel File
To add an Excel sheet to an existing spreadsheet, we will first open the existing Excel file in append mode. For this, we will set the mode parameter to “a” and the engine parameter to “openpyxl” in the ExcelWriter() function. After this, we can append a dataframe into the spreadsheet using the to_excel() method as shown below.

```bash
import pandas as pd

# Read existing excel file into ExcelWriter in Append Mode

writer = pd.ExcelWriter('excel_with_multiple_sheets.xlsx',mode='a',engine="openpyxl")

data=[{"Name":"Aditya","Age":25},
      {"Name":"Sameer","Age":26},
      {"Name":"Dharwish","Age":24},
      {"Name":"Joel","Age":27}]

# convert list of dictionaries to dataframe
df=pd.DataFrame(data)

# Write the pandas dataframe to the excel file

df.to_excel(writer, sheet_name='age',index=False)

# Make sure to properly close the file

writer.close()
```

Code language: Python (python)
We have used the following Excel file as input:
