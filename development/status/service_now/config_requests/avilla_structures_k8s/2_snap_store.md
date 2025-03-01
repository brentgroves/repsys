
# RITM0192002

Facility: 055 - BU - Linamar Structures

Request: Please update the Avilla Structures "Kubernetes to untrust" policy.

Initial Request: RITM0187718

Project: Avilla Structures Kubernetes Cluster

Affected Application: Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used run Structures Information software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Policy Change

1. Please change the range of this policy from 10.188.50.[200-203] to 10.188.50.[200-212]
  Reason: To create 1 backup and 1 development Kubernetes Cluster in addition to the production cluster.

2. Please grant Snap Store access.

Can't install/update the Ubuntu MicroK8s software without accessing the **[Canonical's Snap Store](https://microk8s.io/docs/getting-started)**.

To access the Snap Store, you typically need a firewall rule that allows outbound connections to the following domains over HTTPS (port 443): "store.canonical.com" and "api.snapcraft.io"; this will enable your system to communicate with the Snap Store servers to download and install applications.

Key points about the firewall rule:

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Destination: "store.canonical.com" and "api.snapcraft.io"
