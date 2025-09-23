#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "openpyxl",
# ]
# ///
# import openpyxl module
from openpyxl import Workbook

workbook = Workbook()

workbook.save(filename="sample.xlsx")
