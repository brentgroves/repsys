# Alpine Linux CDN

Submitted : 2025-03-17 19:16:41
Request Number : REQ0194296

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP access to the **[Alpine Linux](https://en.wikipedia.org/wiki/Alpine_Linux)** package manager's Content Delivery Network (CDN).

Reason: Reason: We use **[Alpine Linux](https://alpinelinux.org/about/)** for our debugging container, and its package manager uses this site to download the necessary debugging tools.

Affected Application: Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will run Structures Information System software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request TCP access to the **[Alpine Linux](https://en.wikipedia.org/wiki/Alpine_Linux)** package manager Content Delivery Network (CDN) to download debugging tools for our Alpine containers.

## Key points about the firewall rule

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Destinations:
  - dl-cdn.alpinelinux.org
  - *alpinelinux.org

## Details

```bash
# Alpine Linux package manager CDN
curl -vv telnet://dl-cdn.alpinelinux.org/alpine/v3.21/main/x86_64/APKINDEX.tar.gz:443

sudo tcpdump -i any -nn dst host dl-cdn.alpinelinux.org/alpine/v3.21/main/x86_64/APKINDEX.tar.gz
```

John Biel
