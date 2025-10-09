#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "openpyxl",
#     "xlsxwriter",
#     "pandas",
# ]
# ///
import pandas as pd
# The from ... import ... clause in Python is used to import specific objects (functions, classes, variables) directly into the current namespace from a module or package, rather than importing the entire module.
# When to use from ... import ...:
# When you only need a few specific items from a module: If you only intend to use a small subset of a module's contents, importing only those specific items keeps your namespace cleaner and reduces the chance of naming conflicts.

from datetime import datetime
import numpy as np

# range_date
rd = pd.date_range(start ='1/1/2019', end ='1/08/2019', freq ='Min')
print(rd)