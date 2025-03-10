# Avilla Structures Data Center Network Configuration

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**


## Hardware Summary

- 3 R620 Dell PowerEdge Ubuntu Servers
- 2 with identical configurations for redundancy
- 1 for development

### Network Flow Chart

The following is a mermaid diagram and can be viewed from <https://mermaid.live/>

```mermaid
flowchart TB

    Internet[Internet]<--> FG[Fortigate]

    FG <--> |Accept/Drop| NI13[Network Interface - en03 - 10.188.50.200]

    C1NI[Network Interface - en01 - 10.188.220.100] <--> NI11[Network Interface - en01 - 10.188.220.200];

    subgraph CNC1[Okuma CNC]
    subgraph GCODE1[RDX Job]
    T1[Critical Tool]
    end
    end 

    T1[Critical Tool]-->SP1[Serial Port]

    subgraph MOXA1[Moxa Serial Device Server]
    SP1[Serial Port]<-->C1NI
    end

    subgraph DPE1[Dell PowerEdge Ubuntu Servers]
    NI13[Network Interface - en03 - 10.188.50.200] <--> |port 80/443| IPT[IPTABLES];

    NI11 <--> udp[udp client];
    udp[udp client] <-->|port 3306| I1[Istio Service Mesh Gateway]
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
    I1[Istio Service Mesh Gateway] <--> DB1[MySQL]
    I1[Istio Service Mesh Gateway] <--> R1[Report Requester]
    I1[Istio Service Mesh Gateway] <--> TM1[Tool Management]
    I1[Istio Service Mesh Gateway] <--> TT1[Tool Tracker]

    DB1[MySQL]
    R1[Report Requester]
    TM1[Tool Management]
    TT1[Tool Tracker]
    end


    end

    end
    
