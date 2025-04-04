# **[odbc architecture](https://learn.microsoft.com/en-us/sql/odbc/reference/odbc-architecture?view=sql-server-ver16)**

## ODBC Architecture

The ODBC architecture has four components:

- Application Performs processing and calls ODBC functions to submit SQL statements and retrieve results.
- Driver Manager Loads and unloads drivers on behalf of an application. Processes ODBC function calls or passes them to a driver
- Driver Processes ODBC function calls, submits SQL requests to a specific data source, and returns results to the application. If necessary, the driver modifies an application's request so that the request conforms to syntax supported by the associated DBMS.
- Data Source Consists of the data the user wants to access and its associated operating system, DBMS, and network platform (if any) used to access the DBMS.

Note the following points about the ODBC architecture. First, multiple drivers and data sources can exist, which allows the application to simultaneously access data from more than one data source. Second, the ODBC API is used in two places: between the application and the Driver Manager, and between the Driver Manager and each driver. The interface between the Driver Manager and the drivers is sometimes referred to as the service provider interface, or SPI. For ODBC, the application programming interface (API) and the service provider interface (SPI) are the same; that is, the Driver Manager and each driver have the same interface to the same functions.
