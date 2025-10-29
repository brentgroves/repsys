# Copy Data to Data Lake folder

Hi Tarek,

Would you please help me copy data to a data lake folder? Any help you could give me would be greatly appreciated.

- Thanks Brent

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>>.

## Goal: Copy Data to Data Lake folder

## Steps

 1. Go to E055-Linamar Structures workspace
 2. Create new item: copy job
 3. Choose data source: http
    base url: <https://raw.githubusercontent.com/nextgendatahub/MedallionLakehouseFabric/>
    path: refs/heads/main/ShoppingMart_StructuredData/Orders_Data.csv
    preview data: works
 4. data destination: E055_Linamar_Structures_Bronze_Lakehouse
copy mode: full copy
map to destination: files

Above Folders Path this is shown: "If the identity you use to access the data store only has permission to subdirectory instead of the entire account, specify the path to browse."

## All my failed attempts for different Folder Path

Tested each folder path below:

- blank
- Files
- \Files
- \Files\
- /Files
- /Files/
- E055-Linamar Structures/E055_Linamar_Structures_Bronze_Lakehouse/Files/
- /E055-Linamar Structures/E055_Linamar_Structures_Bronze_Lakehouse/Files/

After entering each of the above folder paths I tested the connection by clicking on the browse button next to the Folder Path field. On each attempt to browse the folder path I received the following error:

**Error:**
Root folder
Failed to load
Internal error has occurred. Activity ID: 0bc325f0-2b0f-4c4e-9572-cf14570dc3aa

## rest of the Copy Data fields

File name: test.csv
Copy behavior: flatten hierarchy
File format: delimitted text
