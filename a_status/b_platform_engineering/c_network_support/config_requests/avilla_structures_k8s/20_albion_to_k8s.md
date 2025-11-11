Submitted : 2025-11-11 17:36:10
Request Number : REQ0228087

# Access to applications that will be running on the Structures Kubernetes Cluster

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Issue: The software that will be running on the Structures Kubernetes Cluster is intended to be accessible to all Structures employees and until recently this was the case. Now only employees from the site where the cluster is located can access it.

Project: Avilla Structures Kubernetes Cluster

K8s IP range: 10.188.50.[200-212]

Request: Please make the software that will be running on the Structures Kubernetes Cluster accessible to all Structures employees.

Reason: So that all Structures employees can access the software that will be running on the Kubernetes Cluster.

Affected Application: Automated ETL and Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used to run Structures Information System software such as the Automated ETL and Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for all of Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Please make the software that will be running on the Structures Kubernetes Cluster accessible to all Structures employees.

## Verify

From a PC running in Albion access an HTTP test service running on a Structures MicroCloud node which will host the Kubernetes Cluster.
