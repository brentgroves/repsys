# **[]()**

- **[ref](https://python.land/data-processing/process-excel-data-in-python-and-pandas#:~:text=Note%20that%20the%20append%20mode,to%20an%20empty%20Excel%20file.)**
- <https://stackoverflow.com/questions/64983554/pandas-how-to-keep-sheets-untouched#:~:text=A%20possible%20way%20to%20do,custom%20styling%20from%20your%20tables.&text=As%20far%20as%20I%20know,to%20%60df%60%20>...
- <https://www.reddit.com/r/learnpython/comments/vps5el/overwrite_existing_excel_data_using_pandas/#:~:text=Updated%20Solution:,otherwise%20it%20will%20create%20one>.

To change and save a single sheet of an Excel workbook using pandas while preserving other sheets, you must combine pandas with the openpyxl engine. The general process is:

- Load the entire workbook using openpyxl.
- Use a pandas ExcelWriter object in "append" mode (mode='a') to overwrite the specific sheet with new data from a DataFrame.
- Save the ExcelWriter to apply the changes to the workbook.

This method requires that the openpyxl library is installed (pip install openpyxl).

## modify and save sheet

```python
import pandas as pd
from openpyxl import load_workbook

# Step 1: Read all sheets from the existing Excel file.
# Store the dataframes in a dictionary where keys are the sheet names.
file_path = 'your_workbook.xlsx'
all_sheets_dict = pd.read_excel(file_path, sheet_name=None)

# Step 2: Modify the desired sheet's DataFrame.
# For this example, we'll modify 'Sheet1'.
df_to_modify = all_sheets_dict['Sheet1']
df_to_modify['New_Column'] = range(len(df_to_modify))

# Step 3: Write the updated DataFrame back to the specific sheet using ExcelWriter.
# Use 'append' mode and the 'openpyxl' engine.
with pd.ExcelWriter(
    file_path,
    engine='openpyxl',
    mode='a', # 'a' is for append mode
    if_sheet_exists='replace' # 'replace' overwrites the existing sheet
) as writer:
    df_to_modify.to_excel(writer, sheet_name='Sheet1', index=False)

print(f"Sheet 'Sheet1' in {file_path} has been updated and saved.")
```
