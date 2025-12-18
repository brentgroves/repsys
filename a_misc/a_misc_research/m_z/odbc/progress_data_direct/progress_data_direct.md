# **[](https://www.progress.com/odbc/custom-connector-sdk)**

## references

<https://www.youtube.com/watch?v=b-NMzIbdUew>
<https://www.progress.com/data-connectivity/power-bi>

Progress DataDirect’s ODBC Driver for any Data Source or API offers a high-performing, secure and reliable connectivity solution for ODBC applications to access any Data Source or API data. Our ODBC driver can be easily used with all versions of SQL and across all platforms - Unix / Linux, AIX, Solaris, Windows and HP-UX. Enjoy real-time analytics, reporting and business intelligence (BI) capabilities with your favorite tools such as Tableau, Power BI, Qlik, Excel, Cognos, Informatica, SAS, Board, MicroStrategy, SSIS, Oracle OBIEE and more.

- Quickly develop custom ODBC driver across C, C++, Java, .NET, REST, ABL
- Broad data connection and application platform options
- Increase development productivity by using our robust SDK
- Portable: Use the same code to support of any API - ODBC, JDBC, OLE DB, ADO.NET

## **[Access Token](https://docs.progress.com/bundle/datadirect-aha-odbc-80/page/Access-Token.html)**

Specifies the access token used to authenticate to Aha! with OAuth 2.0 enabled. Typically, this option is configured by the application; however, in some scenarios, you may need to secure a token using external processes. In those instances, you can also use this option to set the access token manually.

Valid Values
String

where:

String

is an access token you have obtained from the authentication service.

Notes
Access tokens are temporary and must be replaced to maintain the session without interruption. The life of an access token is typically one hour.

See "OAuth 2.0 authentication" for examples and more information.

## Data Security

Keep the data secure during transit with latest security protocols like TLS v1.3, also use the SDK to support data encryption at rest by integrating with custom data encryption and business rules providers

## **[What Does Distributing DataDirect Drivers Involve?](https://www.progress.com/tutorials/jdbc/how-to-embed-and-distribute-jdbc-and-odbc-data-connectivity)**

Distributing the drivers is a three-part process that consists of branding the drivers, installing them with your application's installer program, and enabling your application to unlock the drivers:

### Branding

Branding consists of renaming the driver and license files, and, most importantly, creating locked drivers that can only be used by your product. The DataDirect installation program makes this easy by guiding you through the entire branding process.

### Installing the Driver Files

Installing the drivers with your installation program requires modifying your product installer to load the branded driver files and, for ODBC drivers, adding the necessary entries to the system information files and environment variables.

### Unlocking the Drivers

Your application implements a special set of calls to unlock the drivers when connecting to your data source.
