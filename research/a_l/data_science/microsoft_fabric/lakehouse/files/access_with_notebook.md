# **[How to Access Files in Microsoft Fabric Lakehouse Using Notebooks](<https://snorreglemmestad.com/2025/06/07/how-to-access-files-in-microsoft-fabric-lakehouse-using-notebooks/>)**

June 7, 2025

## Introduction

Microsoft Fabric’s lakehouse architecture provides a powerful foundation for storing and processing data at scale. One of the key capabilities is accessing files stored in the lakehouse directly from Fabric notebooks using both pandas and PySpark. This approach allows data professionals to seamlessly work with various file formats while leveraging the distributed computing power of Spark when needed.

In this guide, we’ll walk through the process of accessing Excel files stored in a Fabric lakehouse using a notebook, demonstrating how to read the data with pandas and convert it to a Spark DataFrame for further processing.

## Prerequisites

- Access to Microsoft Fabric workspace
- A lakehouse with files stored in the Files section
- Basic knowledge of Python and pandas
- Understanding of Spark DataFrames
