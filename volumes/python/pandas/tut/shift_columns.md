Shifting rows
By default, the data is written into the Excel sheet starting from the sheet’s first row and first column. If you want to shift rows while writing data to the Excel sheet, you can use the startrow parameter in the to_excel() method as shown below:

...
df.to_excel(writer, sheet_name='first_sheet',index=False, startrow=3)
...
Code language: Python (python)
The startrow parameter takes the row number starting from where the data should be written in the Excel file. For example, we have set the startrow parameter to 3 in the above code. Hence, the data in the Excel file will be written starting from the fourth row of the sheet (remember, we programmers start counting at 0), leaving the first three rows empty. You can observe this in the following file.
Shifting both columns and rows
Of course, you can also use the startcol and startrow parameters together to write data at a specific location in the Excel sheet, as shown below:

import pandas as pd

data=[["Aditya",179],
      ["Sameer",181],
      ["Dharwish",170],
      ["Joel",167]]

column_names=["Name", "Height"]

df=pd.DataFrame(data, columns=column_names)

writer = pd.ExcelWriter('excel_with_list_displaced.xlsx', engine='xlsxwriter')
df.to_excel(writer, sheet_name='first_sheet',index=False, startrow=3, startcol=4)
writer.close()
Code language: Python (python)
In this code, we have set the startrow and startcol parameters to 3 and 4, respectively. Hence, the data is written to the Excel sheet starting from the fourth row and fifth column, as demonstrated in the file below:
