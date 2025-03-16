# REQ0193020/RITM0193066

John Biel

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP connection to Plex test and production databases.

## Issue

1. Unable to connect test.odbc.plex.com:19995 and odbc.plex.com:19995

Affected Application: Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used run Structures Information System software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request TCP connection to Plex test and production databases.

## Key points about the firewall rule

- Protocol: TCP
- Port: 19995
- Action: Allow
- Destination: "test.odbc.plex.com:19995 and odbc.plex.com:19995"

## Details

```bash
# From system with access to Plex databases
telnet test.odbc.plex.com 19995
Trying 38.97.236.97...
Connected to test.odbc.plex.com.
Escape character is '^]'.
# From Structures Avilla Kubernetes system.
telnet test.odbc.plex.com 19995
Trying 38.97.236.97...
```
