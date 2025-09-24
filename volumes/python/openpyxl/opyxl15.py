#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "openpyxl",
#     "pillow"
# ]
# ///
# import openpyxl module
import openpyxl
from openpyxl.drawing.image import Image

wb = openpyxl.Workbook()

sheet = wb.active

sheet.append([10, 2010, "Geeks", 4, "life"])

img = Image("geek.png")

sheet.add_image(img, 'A2')

# Saving the workbook created
wb.save('sample.xlsx')