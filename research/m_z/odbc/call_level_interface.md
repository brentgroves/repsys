# **[Call Level Interface](https://en.wikipedia.org/wiki/Call_Level_Interface)**

## references

<https://en.wikipedia.org/wiki/Call_Level_Interface>
<https://learn.microsoft.com/en-us/sql/odbc/reference/call-level-interfaces?view=sql-server-ver16>

## **[Call Level Interface (CLI)](https://en.wikipedia.org/wiki/Call_Level_Interface)**

The Call Level Interface (CLI) is an application programming interface [API](1) and software standard to embed Structured Query Language (SQL) code in a host program[2] as defined in a joint standard by the International Organization for Standardization (ISO) and International Electrotechnical Commission (IEC): ISO/IEC 9075-3:2003.[3] The Call Level Interface defines how a program should send SQL queries to the database management system (DBMS) and how the returned recordsets should be handled by the application in a consistent way. Developed in the early 1990s, the API was defined only for the programming languages C and COBOL.

The interface is part of what The Open Group, publishes in a part of the X/Open Portability Guide, termed the Common Application Environment, which is intended to be a wide standard for programming open applications, i.e., applications from different programming teams and different vendors that can interoperate efficiently. SQL/CLI provides an international standard implementation-independent CLI to access SQL databases. Client–server tools can easily access databases through dynamic-link libraries (DLL). It supports and encourages a rich set of client–server tools.

The most widespread use of the CLI standard is the basis of the Open Database Connectivity (ODBC) specification, which is widely used to allow applications to transparently access database systems from different vendors. The current version of the API, ODBC 3.52, incorporates features from both the ISO and X/Open standards. Examples of languages that support Call Level Interface are ANSI C, C#, Visual Basic .NET (VB.NET), Java, Pascal, and Fortran.[4]

## History

The work with the Call Level Interface began in a subcommittee of the US-based SQL Access Group [SAG][5][6](7) In 1992, it was initially published and marketed as Microsoft's ODBC API. The CLI specification was submitted as to the ISO and American National Standards Institute (ANSI) standards committees in 1993. The standard has the book number ISBN 1-85912-081-4 and the internal document number is C451.

ISO SQL/CLI is an addendum to 1992 SQL standard (SQL-92). It was completed as ISO standard ISO/IEC 9075-3:1995 Information technology—Database languages—SQL—Part 3: Call-Level Interface (SQL/CLI). The current SQL/CLI effort is adding support for SQL3.

In the fourth quarter of 1994, control over the standard was transferred to the X/Open Company, which significantly expanded and updated it. The X/Open CLI interface is a superset of the ISO SQL CLI.

## **[call level interfaces](https://learn.microsoft.com/en-us/sql/odbc/reference/call-level-interfaces?view=sql-server-ver16)**

Call-level interfaces are commonly used in client/server architectures, in which the application program (the client) resides on one computer and the DBMS (the server) resides on a different computer. The application calls CLI functions on the local system, and those calls are sent across the network to the DBMS for processing.

A call-level interface is similar to dynamic SQL, in that SQL statements are passed to the DBMS for processing at run time, but it differs from embedded SQL as a whole in that there are no embedded SQL statements and no precompiler is required.

Using a call-level interface typically involves the following steps:

1. The application calls a CLI function to connect to the DBMS.

2. The application builds an SQL statement and places it in a buffer. It then calls one or more CLI functions to send the statement to the DBMS for preparation and execution.

3. If the statement is a SELECT statement, the application calls a CLI function to return the results in application buffers. Typically, this function returns one row or one column of data at a time.

4. The application calls a CLI function to disconnect from the DBMS.
