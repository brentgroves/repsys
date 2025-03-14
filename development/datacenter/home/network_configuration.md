# Home Data Center Network Configuration

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**


## Hardware Summary

- 1 R410 Dell PowerEdge Ubuntu Server
- 3 Dell Optiplex Ubuntu Servers
- 1 Dell Optiplex 7040 (Development System)
- 1 Dell Precision 3600 (K8S node 1)
- 1 Dell Precision 3610 (K8S node 2)
- 1 Dell Precision 7810 (K8S node 3)
- 1 Ligtel Optical Network Terminal (ONT)
- 1 The Calix GigaSpire u4/u4m
  - 80x.11ax, 4x4 Wi-Fi 6 antenna array, with 2x2 @ 5 GHz and 2x2 @ 2.4 GHz​
  - 2 x GigE LAN ports​
  - 1 x GigE WAN port​
  - 1 x USB 3.0 (Type A)
  - Enhanced PuF security
  - Managed by Calix Service Cloud
- 1 TrendNet GigaBit Switch
- 1 Dell PowerConnect 3548  

### Network Flow Chart

The following is a mermaid diagram and can be viewed from <https://mermaid.live/>

```mermaid
flowchart TB

    Internet[Internet]<--> ONT[Ligtel Optical Network Terminal - ONT]
    ONT<-->CLX[Calix Wi-Fi/Lan Router]
    CP1[Port 1]<-->TP1[Port 1]


    TP3[Port 3]<-->NI16[Network Interface - en01 - 192.168.1.60];
    TP4[Port 4]<-->NI11[Network Interface - en01 - 192.168.1.65];

    DPCSP5[Port 5]<-->NI13[Network Interface - en01 - 10.1.1.201];
    DPCSP3[Port 3]<-->NI14[Network Interface - en01 - 10.1.1.202];
    DPCSP1[Port 1]<-->NI15[Network Interface - en01 - 10.1.1.203];

    subgraph CLX[Calix Wi-Fi/Lan Router]
    CP1
    end

    subgraph TGS[TrendNet GigaBit Switch]
    TP1
    TP3
    TP4

    end

    subgraph DOP1[Dell Optiplex 7040 - Development]
    NI16[Network Interface - en01 - 192.168.1.60];
    end

    subgraph DP3[Dell Precision T7810]
    NI15[Network Interface - en01 - 10.1.1.8]<-->K8SN2[K8S node]
    end
    subgraph DP2[Dell Precision T3610]
    NI14[Network Interface - en01 - 10.1.1.7]<-->K8SN3[K8S node];
    end
    subgraph DPT1[Dell Precision T3600]
    NI13[Network Interface - en01 - 10.1.1.6]<-->K8SN4[K8S node];
    end

    NI12[Network Interface - en02 - 10.1.1.1]<-->DPCSP11[Port11];

    subgraph R410[Dell PowerEdge R410 - Rack Server]
    NI11 <--> |Port Forward - NAT| IPT[IPTABLES] 
    IPT[IPTABLES]<-->|Port Forward - NAT| MAAS1[Automated Machine Provisioner - 10.1.1.2]
    NI12
    NI12<-->|bridged VM| MAAS1[Automated Machine Provisioner - 10.1.1.3]
    NI12<--> |bridged VM| K8SN1[K8S node - 10.1.1.4]
    NI12<--> |bridged VM| NVM1[New VM - 10.1.1.5]
    end


    subgraph DPC[Dell PowerConnect 3548 - Switch]
    DPCSP11
    DPCSP5
    DPCSP3
    DPCSP1
    end
```
