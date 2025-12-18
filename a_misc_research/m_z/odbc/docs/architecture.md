# **[Database Access Architecture](https://learn.microsoft.com/en-us/sql/odbc/reference/database-access-architecture?view=sql-server-ver17)**

**[unixodb](https://www.unixodbc.org/)**

06/25/2024
One of the questions in the development of ODBC was which part of the database access architecture to standardize. The SQL programming interfaces described in the previous section - embedded SQL, SQL modules, and CLIs - are only one part of this architecture. In fact, because ODBC was primarily intended to connect personal computer-based applications to minicomputer and mainframe DBMSs, there were also a number of network components, some of which could be standardized.

## Network Database Access

10/17/2024
Accessing a database across a network requires a number of components, each of which is independent of, and resides beneath, the programming interface. These components are shown in the following illustration.

![i1](https://learn.microsoft.com/en-us/sql/odbc/reference/media/pr04.gif?view=sql-server-ver17)

A further description of each component follows:

Programming Interface As described earlier in this section, the programming interface contains the calls made by the application. These interfaces (embedded SQL, SQL modules, and call-level interfaces) are generally specific to each DBMS, although they are usually based on an ANSI or ISO standard.

Data Stream Protocol The data stream protocol describes the stream of data transferred between the DBMS and its client. For example, the protocol might require the first byte to describe what the rest of the stream contains: a SQL statement to be executed, a returned error value, or returned data. The format of the rest of the data in the stream would then depend on this flag. For example, an error stream might contain the flag, a 2-byte integer error code, a 2-byte integer error message length, and an error message.

The data stream protocol is a logical protocol and is independent of the protocols used by the underlying network. Thus, a single data stream protocol can generally be used on a number of different networks. Data stream protocols are typically proprietary and have been optimized to work with a particular DBMS.

Interprocess Communication Mechanism The interprocess communication (IPC) mechanism is the process by which one process communicates with another. Examples include named pipes, TCP/IP sockets, and DECnet sockets. The choice of IPC mechanism is constrained by the operating system and network being used.

Network Protocol The network protocol is used to transport the data stream over a network. It can be considered the plumbing that supports the IPC mechanisms used to implement the data stream protocol, as well as supporting basic network operations such as file transfers and print sharing. Network protocols include NetBEUI, TCP/IP, DECnet, and SPX/IPX and are specific to each network.

## Standard Database Access Architectures

06/25/2024
In looking at the database access components described in the preceding section, it turns out that two of them - programming interfaces and data stream protocols - are good candidates for standardization. The other two components - IPC mechanism and network protocols - not only reside at too low a level but they are both highly dependent on the network and operating system. There is also a third approach - gateways - that provides possibilities for standardization.

This section contains the following topics.

Standard Programming Interface

Standard Programming Interface
06/25/2024
The programming interface is perhaps the most obvious candidate for standardization. In fact, when ODBC was being developed, ANSI and ISO already provided standards for embedded SQL and SQL modules. Although no standards existed for a database CLI, the SQL Access Group - an industry consortium of database vendors - was considering whether to create one; parts of ODBC later became the basis for their work.

One of the requirements for ODBC was that a single application binary had to work with multiple DBMSs. It is for this reason that ODBC does not use embedded SQL or module languages. Although the language in embedded SQL and module languages is standardized, each is tied to DBMS-specific precompilers. Thus, applications must be recompiled for each DBMS and the resulting binaries work only with a single DBMS. While this is acceptable for the low-volume applications found in the minicomputer and mainframe worlds, it is unacceptable in the personal computer world. First, it is a logistical nightmare to deliver multiple versions of high-volume, shrink-wrapped software to customers; second, personal computer applications often need to access multiple DBMSs simultaneously.

On the other hand, a call-level interface can be implemented through libraries, or database drivers, that reside on each local machine; a different driver is required for each DBMS. Because modern operating systems can load such libraries (such as dynamic-link libraries on the Microsoft Windows operating system) at run time, a single application can access data from different DBMSs without recompilation and can also access data from multiple databases simultaneously. As new database drivers become available, users can just install these on their computers without having to modify, recompile, or relink their database applications. Furthermore, a call-level interface was a good candidate for ODBC because Windows - the platform for which ODBC was originally developed - already made extensive use of such libraries.

Standard Data Stream Protocol

A standard data stream protocol is one way to access data in heterogeneous DBMSs. In fact, a standard data stream protocol already exists:

The ANSI/ISO Remote Database Access (RDA) standard: ISO/IEC 9579:2000. Although the ANSI/ISO system shows promise, it is not widely implemented today.

Standard Gateway

A gateway is a piece of software that causes one DBMS to look like another. That is, the gateway accepts the programming interface, SQL grammar, and data stream protocol of a single DBMS and translates it to the programming interface, SQL grammar, and data stream protocol of the hidden DBMS. For example, applications written to use SQL Server can also access DB2 data through the Micro Decisionware DB2 Gateway; this product causes DB2 to look like SQL Server. When gateways are used, a different gateway must be written for each target database.

Although gateways are limited by architectural differences among DBMSs, they are a good candidate for standardization. However, if all DBMSs are to standardize on the programming interface, SQL grammar, and data stream protocol of a single DBMS, whose DBMS is to be chosen as the standard? Certainly no commercial DBMS vendor is likely to agree to standardize on a competitor's product. And if a standard programming interface, SQL grammar, and data stream protocol are developed, no gateway is needed.

## odbc solution

The question, then, is how does ODBC standardize database access? There are two architectural requirements:

Applications must be able to access multiple DBMSs using the same source code without recompiling or relinking.

Applications must be able to access multiple DBMSs simultaneously.

And there is one more question, due to marketplace reality:

Which DBMS features should ODBC expose? Only features that are common to all DBMSs or any feature that is available in any DBMS?
ODBC solves these problems in the following manner:

- **ODBC is a call-level interface**. To solve the problem of how applications access multiple DBMSs using the same source code, ODBC defines a standard CLI. This contains all of the functions in the CLI specifications from Open Group and ISO/IEC and provides additional functions commonly required by applications.

A different library, or driver, is required for each DBMS that supports ODBC. The driver implements the functions in the ODBC API. To use a different driver, the application does not need to be recompiled or relinked. Instead, the application simply loads the new driver and calls the functions in it. To access multiple DBMSs simultaneously, the application loads multiple drivers. How drivers are supported is operating system-specific. For example, on the Microsoft Windows operating system, drivers are dynamic-link libraries (DLLs).

- **ODBC defines a standard SQL grammar**. In addition to a standard call-level interface, ODBC defines a standard SQL grammar. This grammar is based on the Open Group SQL CAE specification. Differences between the two grammars are minor and primarily due to the differences between the SQL grammar required by embedded SQL (Open Group) and a CLI (ODBC). There are also some extensions to the grammar to expose commonly available language features not covered by the Open Group grammar.

Applications can submit statements using ODBC or DBMS-specific grammar. If a statement uses ODBC grammar that is different from DBMS-specific grammar, the driver converts it before sending it to the data source. However, such conversions are rare because most DBMSs already use standard SQL grammar.

- **ODBC provides a Driver Manager** to manage simultaneous access to multiple DBMSs. Although the use of drivers solves the problem of accessing multiple DBMSs simultaneously, the code to do this can be complex. Applications that are designed to work with all drivers cannot be statically linked to any drivers. Instead, they must load drivers at run time and call the functions in them through a table of function pointers. The situation becomes more complex if the application uses multiple drivers simultaneously.

Rather than forcing each application to do this, ODBC provides a Driver Manager. The Driver Manager implements all of the ODBC functions - mostly as pass-through calls to ODBC functions in drivers - and is statically linked to the application or loaded by the application at run time. Thus, the application calls ODBC functions by name in the Driver Manager, rather than by pointer in each driver.

When an application needs a particular driver, it first requests a connection handle with which to identify the driver and then requests that the Driver Manager load the driver. The Driver Manager loads the driver and stores the address of each function in the driver. To call an ODBC function in the driver, the application calls that function in the Driver Manager and passes the connection handle for the driver. The Driver Manager then calls the function by using the address it stored earlier.

- **ODBC exposes a significant number of DBMS features** but does not require drivers to support all of them. If ODBC exposed only features that are common to all DBMSs, it would be of little use; after all, the reason so many different DBMSs exist today is that they have different features. If ODBC exposed every feature that is available in any DBMS, it would be impossible for drivers to implement.

Instead, ODBC exposes a significant number of features - more than are supported by most DBMSs - but requires drivers to implement only a subset of those features. Drivers implement the remaining features only if they are supported by the underlying DBMS or if they choose to emulate them. Thus, applications can be written to exploit the features of a single DBMS as exposed by the driver for that DBMS, to use only those features used by all DBMSs, or to check for support of a particular feature and react accordingly.

So that an application can determine what features a driver and DBMS support, ODBC provides two functions (SQLGetInfo and SQLGetFunctions) that return general information about the driver and DBMS capabilities and a list of functions the driver supports. ODBC also defines API and SQL grammar conformance levels, which specify broad ranges of features supported by the driver. For more information, see Conformance Levels.

It is important to remember that ODBC defines a common interface for all of the features it exposes. Because of this, applications contain feature-specific code, not DBMS-specific code, and can use any drivers that expose those features. One advantage of this is that applications do not need to be updated when the features supported by a DBMS are enhanced; instead, when an updated driver is installed, the application automatically uses the features because its code is feature-specific, not driver-specific or DBMS-specific.
