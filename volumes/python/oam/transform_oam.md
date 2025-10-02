# transform oam

<https://stackoverflow.com/questions/61026839/unable-to-understand-the-syntax-for-iloc-for-reversing-all-rows-vs-reversing-all>

## goal

create pbi formated sheet from maintenance input sheet

## steps

```yaml
input: "Oil adds to Machines.xlsx#Auguest Oil Usage"  
output: "Fabric-OAM.xlsx#Auguest Oil Usage"
```

## 1. date

read date in "Aug. oil usage" sheet cell B1
get month/year

loop through days of the month
d3 to d107

## delete sheets

While pandas provides excellent capabilities for reading and writing data to and from Excel files, it does not directly offer a function to delete an entire sheet within an existing Excel workbook. To achieve this, you need to use a library that provides lower-level Excel file manipulation, such as openpyxl or xlwings.
