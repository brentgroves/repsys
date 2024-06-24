# **[ODBC](https://insightsoftware.com/blog/what-is-odbc/#:~:text=Open%20Database%20Connectivity%20(ODBC)%20is,based%20data%20access%20was%20born.)**

## references

<https://learn.microsoft.com/en-us/sql/odbc/microsoft-open-database-connectivity-odbc?view=sql-server-ver16>

## **[Microsoft Open Database Connectivity](https://learn.microsoft.com/en-us/sql/odbc/microsoft-open-database-connectivity-odbc?view=sql-server-ver16)**

The Microsoft Open Database Connectivity (ODBC) interface is a C programming language interface that makes it possible for applications to access data from a variety of database management systems (DBMSs). ODBC is a low-level, high-performance interface that is designed specifically for relational data stores.

The ODBC interface allows maximum interoperability-an application can access data in diverse DBMSs through a single interface. Moreover, that application will be independent of any DBMS from which it accesses data. Users of the application can add software components called drivers, which interface between an application and a specific DBMS.

## **[ODBC Specification](https://insightsoftware.com/blog/what-is-odbc/#:~:text=Open%20Database%20Connectivity%20(ODBC)%20is,based%20data%20access%20was%20born.)**

Open Database Connectivity (ODBC) is an open standard Application Programming Interface (API) for accessing a database. In 1992, Microsoft partners with Simba to build the world's first ODBC driver; SIMBA. DLL, and standards-based data access was born. By using ODBC statements in a program, you can access files in a number of different common databases. In addition to the ODBC software, a separate module or driver is needed for each database to be accessed.

The latest version of ODBC specification is available from Microsoft‘s website.
For your convenience, you can also download a PDF version of the current ODBC 3.8 Specification.

## ODBC History

Microsoft introduced the ODBC standard in 1992. ODBC was a standard designed to unify access to SQL databases. Following the success of ODBC, Microsoft introduced OLE DB which was to be a broader data access standard. OLE DB was a data access standard that went beyond just SQL databases and extended to any data source that could deliver data in tabular format. Microsoft’s plan was that OLE DB would supplant ODBC as the most common data access standard. More recently, Microsoft introduced the ADO data access standard. ADO was supposed to go further than OLE DB, in that ADO was more object oriented. However, even with Microsoft’s very significant attempts to replace the ODBC standard with what were felt to be “better” alternatives, ODBC has continued to be the de facto data access standard for SQL data sources. In fact, today the ODBC standard is more common than OLE DB and ADO because ODBC is widely supported (including support from Oracle and IBM) and is a cross platform data access standard. Today, the most common data access standards for SQL data sources continue to be ODBC and JDBC, and it is very likely that standards like OLE DB and ADO will fade away over time.

## ODBC Overview

ODBC has become the de-facto standard for standards-based data access in both relational and non-relational database management systems (DBMS). Simba worked closely with Microsoft to co-develop the ODBC standard back in the early 90’s. The ODBC standard enables maximum interoperability thereby enabling application developers to write a single application to access data sources from different vendors. ODBC is based on the Call-Level Interface (CLI) specifications from Open Group and ISO/IEC for database APIs and uses Structured Query Language (SQL) as its database access language.
