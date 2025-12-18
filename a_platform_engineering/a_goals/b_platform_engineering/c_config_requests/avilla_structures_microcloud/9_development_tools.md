# Development Tools Network Config Request

Submitted : 2025-03-14 07:29:35
Request Number : REQ0193966

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP access to development tool installation sites.

Reason:  

- Nvm is the preferred method of installing node.js, which is used to create some of our microservices.
- Miniconda is used for legacy python ETL scripts.
- To install and run **[golang](https://go.dev/doc/install)** programs which is what we use for new microservices.

## Issue

1. Unable to access repo.anaconda.com, and go.dev
to install development tools.

Affected Application: Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used to run Structures Information System software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request TCP access to development tool installation sites.

## Key points about the firewall rule

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Destination:
  - *nodejs.org
  - *anaconda.com
  - *go.dev
  - *golang.org

## Details

```bash
curl -vv telnet://nodejs.org:443
curl -vv telnet://anaconda:443
curl -vv telnet://go.dev:443
curl -vv telnet://golang:443
```

John Biel
