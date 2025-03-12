# REQ0193020/RITM0193066

John Biel

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP connection to nodejs.org, repo.anaconda.com, ghcr.io

Reason:  

- Nvm is the preferred method of installing node.js which is used to create some of our microservices.
- miniconda is used for legacy python ETL scripts.

## Issue

1. Unable to connect nodejs.org

Affected Application: Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used run Structures Information System software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request TCP connection to nodejs.org.

## Key points about the firewall rule

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Destination: "nodejs.org", "repo.anaconda.com"

## Details

```bash
# From system with access to nodejs access
telnet nodejs.org 443
Trying 104.20.22.46...
Connected to nodejs.org.
Escape character is '^]'.
^]
# From Structures Avilla Kubernetes system.
telnet nodejs.org 443
Trying 104.20.22.46...

telnet repo.anaconda.com 443
Trying 104.16.191.158...

 telnet ghcr.io 443
Trying 140.82.114.33...

# Linux homebrew 
# fails download from ghcr.io
/bin/bash install.sh
==> Checking for `sudo` access (which may request your password)...
==> This script will install:
...
==> Updating Homebrew...
==> Downloading https://ghcr.io/v2/homebrew/portable-ruby/portable-ruby/blobs/sha256:ece69c4b930308e50187f2df4f909026610a943cefa5e2b5942a327e3ad0d8f8
^CO=-  

# https://github.com/orgs/Homebrew/discussions/5498
# formulae.brew.sh and ghcr.io will get you most of the way with a standard install. This will allow you run brew update and upgrade any formulae that we have bottles for.
```
