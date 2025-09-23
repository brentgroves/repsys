# **[Working with Excel Spreadsheets in Python](https://www.geeksforgeeks.org/python/working-with-excel-spreadsheets-in-python/)**

You all must have worked with Excel at some time in your life and must have felt the need to automate some repetitive or tedious task. Don't worry in this tutorial we are going to learn about how to work with Excel using Python, or automating Excel using Python. We will be covering this with the help of the Openpyxl module and will also see how to get Python in Excel.

## Getting Started Python Openpyxl

Openpyxl is a Python library that provides various methods to interact with Excel Files using Python. It allows operations like reading, writing, arithmetic operations, plotting graphs, etc. This module does not come in-built with Python. To install this type the below command in the terminal.

`pip install openpyxl`

```python
#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "openpyxl",
# ]
# ///
```

## Read an Excel File in Python

To read an Excel file you have to open the spreadsheet using the load_workbook() method. After that, you can use the active to select the first sheet available and the cell attribute to select the cell by passing the row and column parameter. The value attribute prints the value of the particular cell. See the below example to get a better understanding.

Note: The first row or column integer is 1, not 0.

![i1](https://media.geeksforgeeks.org/wp-content/uploads/20210222190144/pythonexcelreadinexcelopenpyxl.png)

Example:

In this example, a Python program uses the openpyxl module to read an Excel file ("gfg.xlsx"), opens the workbook, and retrieves the value of the cell in the first row and first column, printing it to the console.

```python
# import openpyxl module
import openpyxl

# Give the location of the file
path = "gfg.xlsx"

# To open the workbook
# workbook object is created
wb_obj = openpyxl.load_workbook(path)

# Get workbook active sheet object
# from the active attribute
sheet_obj = wb_obj.active

cell_obj = sheet_obj.cell(row=1, column=1)

print(cell_obj.value)
```

## run 1

```bash
./opyxl1.py
```

## Python Openpyxl Read multiple cells

There can be two ways of reading from multiple cells:

### Reading through Rows and Columns in Excel with openpyxl

- Read from multiple cells using the cell name
- Reading through Rows and Columns in Excel with openpyxl

We can get the count of the total rows and columns using the max_row and max_column respectively. We can use these values inside the for loop to get the value of the desired row or column or any cell depending upon the situation. Let's see how to get the value of the first column and first row.

In this example, a Python program using the openpyxl module reads an Excel file ("gfg.xlsx"). It retrieves and prints the total number of rows and columns in the active sheet, followed by displaying the values of the first column and first row through iterative loops.

```python
import openpyxl

# Give the location of the file
path = "gfg.xlsx"

wb_obj = openpyxl.load_workbook(path)

sheet_obj = wb_obj.active

row = sheet_obj.max_row
column = sheet_obj.max_column

print("Total Rows:", row)
print("Total Columns:", column)

print("\nValue of first column")
for i in range(1, row + 1):
    cell_obj = sheet_obj.cell(row=i, column=1)
    print(cell_obj.value)

print("\nValue of first row")
for i in range(1, column + 1):
    cell_obj = sheet_obj.cell(row=2, column=i)
    print(cell_obj.value, end=" ")
```

Output:

Total Rows: 6
Total Columns: 4
Value of first column
Name
Ankit
Rahul
Priya
Nikhil
Nisha
Value of first row
Ankit  B.Tech CSE 4

## Read from Multiple Cells Using the Cell Name

We can also read from multiple cells using the cell name. This can be seen as the list slicing of Python. In this example, a Python program utilizes the openpyxl module to read an Excel file ("gfg.xlsx"). It creates a cell object by specifying a range from 'A1' to 'B6' in the active sheet and prints the values of each cell pair within that range using a for loop.

```python
import openpyxl

# Give the location of the file
path = "gfg.xlsx"

wb_obj = openpyxl.load_workbook(path)

sheet_obj = wb_obj.active

cell_obj = sheet_obj['A1': 'B6']

for cell1, cell2 in cell_obj:
    print(cell1.value, cell2.value)
```

Output:

Name Course
Ankit  B.Tech
Rahul M.Tech
Priya MBA
Nikhil B.Tech
Nisha B.Tech

Refer to the below article to get detailed information about reading excel files using openpyxl.

**[Reading an excel file using Python openpyxl module](https://www.geeksforgeeks.org/python/python-reading-excel-file-using-openpyxl-module/)**

## Python Write Excel File

First, let's create a new spreadsheet, and then we will write some data to the newly created file. An empty spreadsheet can be created using the Workbook() method. Let's see the below example.

Example:

In this example, a new blank Excel workbook is generated using the openpyxl library's Workbook() function, and it is saved as "sample.xlsx" with the save() method. This code demonstrates the fundamental steps for creating and saving an Excel file in Python.

```bash
from openpyxl import Workbook

workbook = Workbook()

workbook.save(filename="sample.xlsx")
```

Output

![i3](https://media.geeksforgeeks.org/wp-content/uploads/20210223150846/emptyspreadsheetusingPython.png)

After creating an empty file, let's see how to add some data to it using Python. To add data first we need to select the active sheet and then using the cell() method we can select any particular cell by passing the row and column number as its parameter. We can also write using cell names. See the below example for a better understanding.

Example:

In this example, the openpyxl module is used to create a new Excel workbook and populate cells with values such as "Hello," "World," "Welcome," and "Everyone." The workbook is then saved as "sample.xlsx," illustrating the process of writing data to specific cells and saving the changes

```python
# import openpyxl module
import openpyxl

wb = openpyxl.Workbook()

sheet = wb.active

c1 = sheet.cell(row=1, column=1)

# writing values to cells
c1.value = "Hello"

c2 = sheet.cell(row=1, column=2)
c2.value = "World"

c3 = sheet['A2']
c3.value = "Welcome"

# B2 means column = 2 & row = 2.
c4 = sheet['B2']
c4.value = "Everyone"

wb.save("sample.xlsx")
```

output:

![i4](https://media.geeksforgeeks.org/wp-content/uploads/20210223152030/pythonexcelwritingtofile.png)

Refer to the below article to get detailed information about writing to excel.

**[Writing to an excel file using openpyxl module](https://www.geeksforgeeks.org/python/python-writing-excel-file-using-openpyxl-module/)**

## Append data in excel using Python

In the above example, you will see that every time you try to write to a spreadsheet the existing data gets overwritten, and the file is saved as a new file. This happens because the Workbook() method always creates a new workbook file object. To write to an existing workbook you must open the file with the load_workbook() method. We will use the above-created workbook.

Example:

In this example, the openpyxl module is employed to load an existing Excel workbook ("sample.xlsx"). The program accesses cell 'A3' in the active sheet, updates its value to "New Data," and then saves the modified workbook back to "sample.xlsx."

```python
# import openpyxl module 
import openpyxl 

wb = openpyxl.load_workbook("sample.xlsx") 

sheet = wb.active 

c = sheet['A3'] 
c.value = "New Data"

wb.save("sample.xlsx")
```

output

![i6](https://media.geeksforgeeks.org/wp-content/uploads/20210223160255/appenddataexcelpython.png)

We can also use the append() method to append multiple data at the end of the sheet.

Example:

In this example, the openpyxl module is utilized to load an existing Excel workbook ("sample.xlsx"). A two-dimensional data structure (tuple of tuples) is defined and iteratively appended to the active sheet, effectively adding rows with values (1, 2, 3) and (4, 5, 6).

```python
# import openpyxl module 
import openpyxl 

wb = openpyxl.load_workbook("sample.xlsx") 

sheet = wb.active 

data = (
    (1, 2, 3),
    (4, 5, 6)
)

for row in data:
    sheet.append(row)

wb.save('sample.xlsx')
```

Output

![i7](https://media.geeksforgeeks.org/wp-content/uploads/20210223174728/appenddataexcelpython.png)
