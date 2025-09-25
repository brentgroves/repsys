# **[How to copy data from one excel sheet to another](https://www.geeksforgeeks.org/python/python-how-to-copy-data-from-one-excel-sheet-to-another/)**

Python | How to copy data from one excel sheet to another
Last Updated : 03 Oct, 2019

In this article, we will learn how to copy data from one excel sheet to destination excel workbook using openpyxl module in Python. For working with excel files, we require openpyxl, which is a Python library that is used for reading, writing and modifying excel (with extension xlsx/xlsm/xltx/xltm) files. It can be installed using the following command:

`Sudo pip3 install openpyxl`

For copying one excel file to another, we first open both the source and destination excel files. Then we calculate the total number of rows and columns in the source excel file and read a single cell value and store it in a variable and then write that value to the destination excel file at a cell position similar to that of the cell in source file. The destination file is saved.

Procedure -

1) Import openpyxl library as xl.
2) Open the source excel file using the path in which it is located.

  Note: The path should be a string and have double backslashes (\\) instead of single backslash (\). Eg: Path should be C:\\Users\\Desktop\\source.xlsx Instead of  C:\Users\Admin\Desktop\source.xlsx
3) Open the required worksheet to copy using the index of it. The index of worksheet ‘n’ is ‘n-1’. For example, the index of worksheet 1 is 0.
4) Open the destination excel file and the active worksheet in it.
5) Calculate the total number of rows and columns in source excel file.
6) Use two for loops (one for iterating through rows and another for iterating through columns of the excel file) to read the cell value in source file to a variable and then write it to a cell in destination file from that variable.
7) Save the destination file.

```python
# importing openpyxl module
import openpyxl as xl;

# opening the source excel file
filename ="C:\\Users\\Admin\\Desktop\\trading.xlsx"
wb1 = xl.load_workbook(filename)
ws1 = wb1.worksheets[0]

# opening the destination excel file 
filename1 ="C:\\Users\\Admin\\Desktop\\test.xlsx"
wb2 = xl.load_workbook(filename1)
ws2 = wb2.active

# calculate total number of rows and 
# columns in source excel file
mr = ws1.max_row
mc = ws1.max_column

# copying the cell values from source 
# excel file to destination excel file
for i in range (1, mr + 1):
    for j in range (1, mc + 1):
        # reading cell value from source excel file
        c = ws1.cell(row = i, column = j)

        # writing the read value to destination excel file
        ws2.cell(row = i, column = j).value = c.value

# saving the destination excel file
wb2.save(str(filename1))
```

Source File:

![i1](https://media.geeksforgeeks.org/wp-content/uploads/20190920095910/Source.png)

Output:

![i2](https://media.geeksforgeeks.org/wp-content/uploads/20190920095908/Destination.png)
