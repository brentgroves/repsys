# **[OpenFlow Protocol Overview](https://exatel.pl/en/knowledge/blog/articles/openflow-protocol-overview/)**

OpenFlow is one of the most popular SDN (Software-Defined Networking) protocols. It enables remote control of the OpenFlow switch data layer and managing QoS mechanisms. The first section of the article briefly introduces the layered network model and a reference SDN network model. Next, I will present the OpenFlow protocol used for SDN-OF (OpenFlow) switch communication. Finally, I will discuss the OpenFlow switch logical structure.

## Layered network model

A layered network model diagram is shown in Figure 1. It consists of 3 layers:

- control layer,
- management layer,
- data layer.

The data layer implements packet processing and forwards them between network devices. The control layer is responsible for determining traffic flow rules applied within the data layer. The management layer implements configuration functionalities, failure detection and repair, status and resource load monitoring, as well as control access to network elements. It should be noted that all components executing the functionalities of both the data and control layers are subject to management.
