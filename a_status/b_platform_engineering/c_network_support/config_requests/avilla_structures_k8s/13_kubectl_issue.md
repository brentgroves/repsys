# kubectl issue

Submitted : 2025-03-20 19:02:37
Request Number : REQ0194961

Hi Justin,

Is inbound access to ports 6443 and 16443 blocked by the Fortigate Firewall? We use a program called kubectl to access the Kubernetes API from remote computers.  Kubectl passes a client key and certificate for authentication that the Firewall might also not like. Could you please help me?

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Project: Avilla Structures Kubernetes Cluster

Request: Please allow inbound access to ports 6443 and 16443 from 10.188.40.230 and 10.188.50.200-212.

Reason: For kubectl to function correctly, firewall access needs to be open for TCP traffic on ports 6443 and 16443 (Kubernetes API server) and potentially other ports depending on your cluster configuration.

Here's a more detailed breakdown:
Kubernetes API Server:
The default port for the Kubernetes API server is 6443 and 16443, but this can be configured.
kubectl uses this API server to interact with the cluster.
You need inbound TCP traffic on this port (or the configured port 16443) to be allowed from the machine where you're running kubectl to the Kubernetes master node.

Affected Application: Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will run Structures Information System software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request: For kubectl to function correctly, firewall access needs to be open for TCP traffic on ports 6443 and 16443

## Key points about the firewall rule

- Protocol: TCP
- Port: 6443 and 16443
- Action: Allow
- source:
  - 10.188.40.230
  - 10.188.50.200-212

## Details

```bash
# Alpine Linux package manager CDN
kubectl get all 
E0320 18:11:12.623408  113886 memcache.go:265] "Unhandled Error" err=" couldn't get current server API group list: Get \"https://10.188.50.214:16443/api?timeout=32s\": dial tcp 10.188.50.214:16443: i/o timeout"

```

John Biel
