# REQ0193020/RITM0193066

## references

- **[soap xml fw](https://www.itprotoday.com/it-security/soap-xml-firewalls)**
- **[soap and wsdl](https://www.soapui.org/docs/soap-and-wsdl/working-with-wsdls/#1-Working-with-WSDLs)**

## SOAP config request

We will be submitting an additional request for micro services running on our Structures Avilla Kubernetes cluster to have access to the Plex **[SOAP](https://www.techtarget.com/searchapparchitecture/definition/SOAP-Simple-Object-Access-Protocol)** server. Both the SOAP web service and an ODBC connection give access to the Plex database.  The difference being that Plex maintains the SQL queries of the SOAP web services which access the live database and we maintain the SQL queries in a snapshot of the database when connecting via ODBC.  

Thank you,

This config request may not be need since I could connect to both the api.plexonline.com and testapi.plexonline.com endpoints.

```bash
# From system with access to Plex SOAP web services
telnet api.plexonline.com 443
Trying 38.97.236.57...
Connected to api.plexonline.com.
Escape character is '^]'.
^]Connection closed by foreign host.

telnet testapi.plexonline.com 443
Trying 38.97.236.77...
Connected to testapi.plexonline.com.
Escape character is '^]'.
```

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP connection to Plex SOAP Web Services.

## Issue

1. Unable to connect to Plex Web Services.

Affected Application: Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used run Structures Information System software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request TCP connection to Plex SOAP web services.

## Key points about the firewall rule

- Protocol: TCP
- Port: 19995
- Action: Allow
- Destination: "test.odbc.plex.com:19995 and odbc.plex.com:19995"

## Details

```bash
- Protocol: TCP
- Port: 443
- Action: Allow
- Destination: "api.plexonline.com" and "testapi.plexonline.com"

```bash
# From system with access to Plex SOAP web services
telnet api.plexonline.com 443
Trying 38.97.236.57...
Connected to api.plexonline.com.
Escape character is '^]'.
^]Connection closed by foreign host.

telnet testapi.plexonline.com 443
Trying 38.97.236.77...
Connected to testapi.plexonline.com.
Escape character is '^]'.
```
