# Kubernetes Admin Access

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

Issue: The Avilla Structures Kubernetes administrator does not have full access to the MicroCloud/K8s IP range from his PCs running in Albion and Avilla.

Project: Avilla Structures Kubernetes Cluster

```yaml
Administrator IPs: {10.188.40.232, 10.188.40.20, 10.187.40.60, 10.187.40.123}
MicroCloud/K8s IP range: 10.188.50.[197-212]
computer: research11
```

## Hosts

```yaml
computer: isdev
location: Avilla
ip: 10.188.40.20
usb nic: ASIX
mac: F8:E4:3B:ED:63:BD
```

```yaml
computer: research11
location: Avilla
ip: 10.188.40.232
nic: integrated
mac: 
```

```yaml
computer: isdev
location: Albion
ip: 10.187.40.60
usb nic: 
mac: A0:CE:C8:5A:FC:3C
```

```yaml
computer: research21
location: Albion
ip: 10.187.40.123
nic: integrated 
mac: 
```

```yaml
computer: moxa
sn: TBZAE1069693
mac: 00:90:e8:85:c7:be
desc: serial device server for the JT Fronts marposs gage
```

Request: Please give the Structures Kubernetes Cluster administrator full access to the MicroCloud/K8s IP range.

Reason: The Structures Kubernetes Cluster administrator would like to manage the K8s cluster from Albion and Avilla.

Affected Application: Automated ETL and Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used to run Structures Information System software such as the Automated ETL and Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for all of Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Please expand the Kubernetes policy to give the Structures Kubernetes Cluster administrator full access to the MicroCloud/K8s IP range.

## Verify

From the Structures Kubernetes Administrator's PCs running in Albion and Avilla:

- SSH into each MicroCloud Cluster node.
- Use virt-viewer and the spice protocol to access the Windows Server 22 VM running on the Structures MicroCloud Cluster.
- Verify a Windows 11 VM running on the Kubernetes administrator's PCs can access the Ceph storage cluster running on the MicroCloud Cluster.
- Verify Windows Server 22 VM running on the MicroCloud cluster can access the Ceph storage cluster which is also running on the MicroCloud Cluster.
