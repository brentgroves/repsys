# **[](https://python.land/data-processing/process-excel-data-in-python-and-pandas#:~:text=Note%20that%20the%20append%20mode,to%20an%20empty%20Excel%20file.)**

Add a Row or Column to a Sheet in an Excel File
We will use the following steps to add a row to an existing sheet in an Excel file in Python:

First, we open the Excel file in append mode using the ExcelWriter() function. Here, we will set the if_sheet_exists parameter to “replace” so that we can overwrite the existing sheet after adding a new row to it.
Next, we read the sheet we want to modify into a pandas dataframe using the read_excel() method.
Once we get the data frame, we add a row to it using the concat() function.
After adding a new row to the dataframe, we write back the dataframe to the Excel file using the to_excel() method.
Finally, we close the ExcelWriter object using the close() method.
After executing the above statements, we can add a row to a sheet in an Excel file in Python as shown below.

```bash
import pandas as pd

# Read existing excel file into ExcelWriter in Append Mode

writer = pd.ExcelWriter('excel_with_multiple_sheets.xlsx',
           mode='a',engine="openpyxl",if_sheet_exists="replace")
df=pd.read_excel('excel_with_multiple_sheets-4.xlsx', sheet_name="weight")
newRow= {"Name":"Elon","Weight":77}
new_row=pd.DataFrame([newRow])
df=pd.concat([df,new_row],ignore_index=True)

# Write the pandas dataframe to the excel file

df.to_excel(writer, sheet_name='weight',index=False)
writer.close()
```

Code language: Python (python)
We have used the following Excel file as input to the above code.
