#!/usr/bin/env python
# coding: utf-8

# ## nb_fabric_de_series_032_excel_files
# 
# New notebook

# In[1]:


# Import pandas library
import pandas as pd

# Lakehouse file path to a variable
# lh_file_path = "abfss://ada1ba44-70b7-41af-b6b1-aaa27c630134@onelake.dfs.fabric.microsoft.com/d86d76ca-5ab2-490c-86f0-9326cd186063/Files/fabric_de_series_032"
lh_file_path ="abfss://fad2d397-2419-4518-aa81-b0d383e4f42d@onelake.dfs.fabric.microsoft.com/3c6b68c7-e42c-491f-a923-448b33c4171b/Files/fabric_de_series_032"
# Read an excel file to a pandas df
df_pd = pd.read_excel(f"{lh_file_path}/file_1.xlsx")

# Print the type of the pandas df
print(type(df_pd))

# Display the pandas df
display(df_pd)


# In[2]:


# Import pandas library
import pandas as pd

# Lakehouse file path to a variable
lh_file_path = "abfss://ada1ba44-70b7-41af-b6b1-aaa27c630134@onelake.dfs.fabric.microsoft.com/d86d76ca-5ab2-490c-86f0-9326cd186063/Files/fabric_de_series_032"

# Read an excel file to a pandas df
df_pd = pd.read_excel(f"{lh_file_path}/file_1.xlsx")

# Print the type of the pandas df
print(type(df_pd))

# Display the pandas df
display(df_pd)

# Conver to a spark df
df_spark = spark.createDataFrame(df_pd)

# Print the type of the spark df
print(type(df_spark))

# Display the spark df
display(df_spark)


# In[3]:


# Import pandas library
import pandas as pd

# Lakehouse file path to a variable
lh_file_path = "abfss://ada1ba44-70b7-41af-b6b1-aaa27c630134@onelake.dfs.fabric.microsoft.com/d86d76ca-5ab2-490c-86f0-9326cd186063/Files/fabric_de_series_032"

# Read an excel file to a pandas df
df_pd = pd.read_excel(f"{lh_file_path}/file_1.xlsx")

# Conver to a spark df
df_spark = spark.createDataFrame(df_pd)

# Create a schema if not exists and write the spark df to lakehouse table
spark.sql("CREATE SCHEMA IF NOT EXISTS fabric_de_series_032")
df_spark.write.mode("overwrite").format("delta").saveAsTable("fabric_de_series_032.file_1")

# Read data from the lakehouse table
df_table = spark.sql("SELECT * FROM lh_fabric_de_series_02.fabric_de_series_032.file_1")
display(df_table)


# In[4]:


# Import pandas library
import pandas as pd

# Lakehouse file path to a variable
lh_file_path = "abfss://ada1ba44-70b7-41af-b6b1-aaa27c630134@onelake.dfs.fabric.microsoft.com/d86d76ca-5ab2-490c-86f0-9326cd186063/Files/fabric_de_series_032"

# Read excel to a pandas df
df_pd = pd.read_excel(f"{lh_file_path}/file_2.xlsx")

# Conver to a spark df
df_spark = spark.createDataFrame(df_pd)

# Display the spark df
display(df_spark)


# In[5]:


# Import pandas library
import pandas as pd

# Lakehouse file path to a variable
lh_file_path = "abfss://ada1ba44-70b7-41af-b6b1-aaa27c630134@onelake.dfs.fabric.microsoft.com/d86d76ca-5ab2-490c-86f0-9326cd186063/Files/fabric_de_series_032"

# Read excel to a pandas df
df_pd = pd.read_excel(f"{lh_file_path}/file_2.xlsx",\
        sheet_name="data_2",\
        header=None,\
        skiprows=3,\
        skipfooter=2,\
        names=["date","col1","col2","col3"])


# Conver to a spark df
df_spark = spark.createDataFrame(df_pd)

# Display the spark df
display(df_spark)


# In[6]:


# Import pandas library
import pandas as pd

# Lakehouse file path to a variable
lh_file_path = "abfss://ada1ba44-70b7-41af-b6b1-aaa27c630134@onelake.dfs.fabric.microsoft.com/d86d76ca-5ab2-490c-86f0-9326cd186063/Files/fabric_de_series_032"

# Read excel to a pandas df
df_pd = pd.read_excel(f"{lh_file_path}/file_2.xlsx",\
        sheet_name="data_2",\
        header=None,\
        skiprows=3,\
        skipfooter=2,\
        names=["date","col1","col2","col3"])

# Conver to a spark df
df_spark = spark.createDataFrame(df_pd)

# Create a schema if not exists and write the spark df to lakehouse table
spark.sql("CREATE SCHEMA IF NOT EXISTS fabric_de_series_032")
df_spark.write.mode("overwrite").format("delta").saveAsTable("fabric_de_series_032.file_2")

# Read data from the lakehouse table
df_table = spark.sql("SELECT * FROM lh_fabric_de_series_02.fabric_de_series_032.file_2")
display(df_table)

