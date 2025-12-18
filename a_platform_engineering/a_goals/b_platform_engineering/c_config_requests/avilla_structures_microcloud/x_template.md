
# REQ0187672

Request: Update Avilla Structures "Kubernetes to untrust" policy.

Project: Avilla Structures Kubernetes Cluster

The Avilla Structures Kubernetes Cluster will be used run Structures Information software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Changes

1. Change from 10.188.50.[200-203] to 10.188.50.[200-212]
  Reason: Create 1 backup and 1 development Kubernetes Cluster in addition to the production cluster.

2. Snap Store access.

Can't install/update the Ubuntu MicroK8s software without accessing the **[Canonical's Snap Store](https://microk8s.io/docs/getting-started)**.

To access the Snap Store, you typically need a firewall rule that allows outbound connections to the following domains over HTTPS (port 443): "store.canonical.com" and "api.snapcraft.io"; this will enable your system to communicate with the Snap Store servers to download and install applications.

Key points about the firewall rule:

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Destination: "store.canonical.com" and "api.snapcraft.io"
