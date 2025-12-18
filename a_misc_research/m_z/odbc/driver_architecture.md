# **[ODBC Driver Architecture](https://learn.microsoft.com/en-us/sql/odbc/reference/develop-driver/odbc-driver-architecture?view=sql-server-ver16)**

## ODBC Driver Architecture

Article
02/28/2023

Driver writers must be aware that the driver architecture can affect whether an application can use DBMS-specific SQL.

![](https://learn.microsoft.com/en-us/sql/odbc/reference/develop-driver/media/odbcdriverovruarch.gif?view=sql-server-ver16)

## File-based Drivers

When the driver accesses the physical data directly, the driver acts as both driver and data source. The driver must process both ODBC calls and SQL statements. Developers of file-based drivers must write their own database engines.

## DBMS-Based Drivers

When a separate database engine is used to access physical data, the driver processes only ODBC calls. It passes SQL statements to the database engine for processing.

## Network Architecture

File and DBMS ODBC configurations can exist on a single network.

## Other Driver Architectures

When a driver is required to work with a variety of data sources, it can be used as middleware. Heterogeneous join engine architecture can make the driver appear as a driver manager. Drivers can also be installed on servers, where they can be shared by a series of clients.
