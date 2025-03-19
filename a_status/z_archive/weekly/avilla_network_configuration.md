# Avilla Structures On-Prem Kubernetes Cluster Status

Approval for the Avilla Structures On-Prem Kubernetes Cluster IP Firewall config request has been granted for the week of Feb 10th, or later.  This week we will have unrestricted internet access to set up our 3 Dell R620 PowerEdge Servers using IP addresses on the Avilla OT VLAN. After this week, Justin will attempt to create a firewall ruleset based on the attached spreadsheet that will give our K8s Cluster the access it needs for day-to-day operations. 

Thank you all for your help with this.

- Sincerely,
Brent Groves

## Players

- Justin Langille
- Jared Davis
- Christian Trujillo
- Kevin Young
- Dan Martin
- Heather Luttrell

The following is a configuration summary and network Flow diagram of the setup we intend to create.  

## Software (excluding K8s platform applications)

- Automated Report System
- Tool Management System
- Tool Tracker MES

## Hardware Summary

- 3 R620 Dell PowerEdge Ubuntu Servers
- 2 with identical configurations for redundancy
- 1 for development

### Network Flow Chart

The following is a mermaid diagram and can be viewed from <https://mermaid.live/>

```mermaid
flowchart TB

    Internet[Internet]<--> FG[Fortigate]

    FG <--> |Accept/Drop| NI11[Network Interface - en01 - 10.188.220.200];

    FG <--> |Accept/Drop| C1NI[Network Interface - en01 - 10.188.220.100];

    C1NI <--> NI11

    subgraph CNC1[Okuma CNC]
    subgraph GCODE1[RDX Job]
    T1[Critical Tool]
    end
    end 

    T1[Critical Tool]-->MOXA1

    subgraph MOXA1[Moxa Serial Device Server]
    C1NI
    end

    subgraph DPE1[Dell PowerEdge Ubuntu Servers]
    NI11 <--> IPT[IPTABLES]


    IPT<-->|Port Forward - NAT| I1[Istio Service Mesh Gateway]


    subgraph PN[Private Network]
    NI12[Network Interface - en02 - 10.1.1.1]<--> |bridged| MVP[Machine and VM Provisioner]

    NI12<--> |bridged| K8SN1[K8S Node #1]
    NI12<--> |bridged| NVM[New VM]

    subgraph MVP[MAAS]
    AMP[Automated Machine Provisioner]
    end

    subgraph NVM[New VM]
    NP[Needs Provisioned]
    end

    subgraph K8SN1[K8S Production]
    I1[Istio Service Mesh Gateway] <--> R1[Report Requester]
    I1[Istio Service Mesh Gateway] <--> TM1[Tool Management]
    I1[Istio Service Mesh Gateway] <--> TT1[Tool Tracker]

    R1[Report Requester]
    TM1[Tool Management]
    TT1[Tool Tracker]
    end


    end

    end
    
```