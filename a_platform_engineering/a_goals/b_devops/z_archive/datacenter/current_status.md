# Structures Cloud-based and OnPrem Kubernetes Cluster status

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

- Thanks to Jared for all his help explaining Linamar networking and firewall config requests. 
- Thanks to Justin Langille for creating a large ruleset so that K8s can have the access needed. I passed this ruleset on to Hayley Rymer.

## Azure Solution for Automated Reporting, Tool Management System, and Tool Tracker MES
  - create Azure SQL DB (done)
  - Test TB report scripts and Power BI report on Linamar Azure SQL DB.
- Azure AKS
  - create Microsoft Entra K8s Admin Group (done)
  - create K8s cluster
    - deploy Istio Service Mesh Gateway

## **[Avilla Structures redundant on-prem MAAS, MicroStack, Structures MicroK8s Clusters for Automated Reporting, Tool Management System, and Tool Tracker MES](https://canonical.com/microstack/docs/multi-node-maas)** On-Prem Kubernetes Cluster

- I am making a Docker-based image that is able to connect to data sources. This is tricky. We can then use this base image in other specific docker images that need access to our data sources.
- Noticed that Linamar Network routes traffic by assigning the 10.*.*.254 address as the default route of each vlan. These 254 addresses are located on the Fortigate switch which maintains all Firewall rulesets. 
  - Can add multiple network interfaces to host which is each assigned an address on a different vlan and use Linux local routing table to access both networks.
  - eno1 - vlan 10.188.220.0
  - eno2 - vlan 10.188.70.0
  - en03 - private 10.1.10.0 k8s network
  - Each mp vm adds a tap device to the mpqemubro bridge which mp has set up the local routing table to route outgoing traffic using nat to change source address to 10.188.220.200 which has been given access to internet domains k8s needs for production. 
  - Only one config request must be completed for the machine provisioner and all K8s VMS. 
  - everyone can access the server 10.188.70.0 vlan and then we use iptables to nat/port forward to the public microservices.

