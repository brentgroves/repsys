# **[Create an Excel File With Multiple Sheets in Python](https://python.land/data-processing/process-excel-data-in-python-and-pandas#:~:text=Note%20that%20the%20append%20mode,to%20an%20empty%20Excel%20file.)**

To create an Excel file with multiple sheets in Python, follow these steps:

- First, create multiple pandas dataframes using the DataFrame() function and a list of lists or dictionaries.
- Next, open an Excel file in write mode using the ExcelWriter() function.
- Once we get the ExcelWriter object, we write all the dataframes into the Excel file as sheets using the to_excel() method. Here, we have to give each sheet a different name.
- Finally, we will close the ExcelWriter object using the close() method.

After executing the above steps, we can create an Excel file with multiple sheets:

```python
import pandas as pd

# Define list of dictionaries
height_data=[{"Name":"Aditya","Height":179},
      {"Name":"Sameer","Height":181},
      {"Name":"Dharwish","Height":170},
      {"Name":"Joel","Height":167}]

weight_data=[{"Name":"Aditya","Weight":76},
      {"Name":"Sameer","Weight":68},
      {"Name":"Dharwish","Weight":69},
      {"Name":"Joel", "Weight":73}]

marks_data=[{"Name":"Aditya","Marks":79},
      {"Name":"Sameer","Marks":81},
      {"Name":"Dharwish","Marks":70},
      {"Name":"Joel","Marks":67}]

# Convert list of dictionaries to dataframe
height_df=pd.DataFrame(height_data)
weight_df=pd.DataFrame(weight_data)
marks_df=pd.DataFrame(marks_data)

writer = pd.ExcelWriter('excel_with_multiple_sheets.xlsx', engine='xlsxwriter')

height_df.to_excel(writer, sheet_name='height',index=False)
weight_df.to_excel(writer, sheet_name='weight',index=False)
marks_df.to_excel(writer, sheet_name='marks',index=False)
writer.close()
```
