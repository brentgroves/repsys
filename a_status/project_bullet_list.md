# Project Bullet List

Hi Christian and Kevin,

This is a revised bullet list of Information Systems projects containing a certificate management system. It is suitable for our Bi-Weekly meeting. I will send a more detailed summary later.

Thank you.

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

- Ongoing certificate management for each Mach2 MES system
and for the Structures Avilla Kubernetes Cluster
- Connect Structures Avilla Dell PowerEdge servers to extreme core switches with 10GB SPF+ modules in truck mode to VLANs 50 and 220.
- Set up and administer a MySQL InnoDB Cluster
- Set up the Authentication and Authorization K8s platform service
- Configure Zero-Trust Service Mesh Gateway in K8s
- Set up Job Queue system in K8s
- Develop Email microservice in K8s
- Develop SMS Notification microservice in K8s
- Migrate Mobex Azure SQL MI to Linamar's Azure SQL DB.
- Document the Kubernetes troubleshooting process
- Set up Prometheus system monitoring and alerting in K8s.
- Set up a Grafana data visualization and monitoring platform in K8s
- Transition from Multipass hypervisor to MicroCloud Hyper-converged infrastructure (HCI)
- Develop the Automated ETL and Report System.
- Develop an Integrated Tool Management System
- Develop a Tool Tracking module for the tool management system
- Develop the CNC tool adjustment module of the tool management system.
- Develop an Automated Certificate Management System to create certificates and report certificate status for Mach2 MES servers and the Structures Kubernetes Cluster.

## Structures Information Systems, Kubernetes, or K8s, Platform Engineering Support

## Structures Information Systems, Kubernetes, K8s, Application Development and Support

### Automated Certificate Management System

- certificate schema
- report certificate status
- API to create certificates

### Automated ETL Report System

- Move schema from Mobex Azure SQL MI to the Linamar Azure SQL DB.
- Write scripts to compare Mobex Azure SQL result sets to the Linamar Azure SQL DB result set.
- Create a new set of **[ETL](https://www.getdbt.com/blog/extract-transform-load)** scripts that work on the Linamar Azure SQL DB.
- Create a new set of **[ETL](https://www.getdbt.com/blog/extract-transform-load)** scripts that use two data sources for the Structures Avilla Kubernetes Cluster, MySQL InnoDB Cluster, and the Azure SQL DB.
- Create the ETL script runner microservice.

### Tool Management System

- Add the Plex supply item number to the new vending machines.
- Add tool list support.
- Add Engineering manager approvals.
- Add MRO personnel notifications of tooling change requests.
- Work on ERP and Vending Machines integration with our automated **[ETL](https://www.getdbt.com/blog/extract-transform-load)** reporting system.
- Create tooling reports based on job orders in ERP.

### Tool Tracker MES

- Add Tool Tracker DB schema to data sources.
- Insert GCode changes into the Okuma RDX line.  
- Configure and connect the Moxa Serial device server to the RDX line.
- Configure the Kubernetes network to access the Albion OT network.

## CNC tool adjustment app

- Send CMM output to the database, including CNC, feature, and out-of-spec info.
- Tool Setter subscribes to CNC CMM reports from the mobile app.
- Tool Setter updates the mobile app with tool adjustments made.
- Since all CMM report data and tool adjustments are recorded in a database, they are easily viewable.
- The tablet app contains the CMM report data.
- Tool setter updates the app with the offset made.

## PiWeb Research

- Research usages of zeiss piweb and **[statistical process control](https://asq.org/quality-resources/statistical-process-control?srsltid=AfmBOopPwaYtgJNzIb_z2cVgiVBWtzgSygpJiKP-H197XVOC0Opo7C2X)**. We have Mills River license available.
