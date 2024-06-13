# Status

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

## **[Reporting System IP Request](../../report_system/r620s.md)**

- 12 for r620s
- 4 for Albion dev system and k8s cluster
- 4 for Avilla dev system and k8s cluster

## Linamar PKI

- Lint certificate chain
- Lint kors43 SAN server certificate
- Fix any errors
- Test certificate chain
- Format kors43 certificate chain for jboss/Niagara
- Ask Sam to import certificate chain on kors43 using Niagara front-end

## Network packet

- Client uses name servers to determine IP address of destination service
- Client sends network packet to IP address
- Networking devices route network packet to destination network using routing protocals such as:
  - Routing Information Protocol (RIP)
  - Interior Gateway Protocol (IGRP)
  - Open Shortest Path First (OSPF)
  - Exterior Gateway Protocol (EGP)
  - Enhanced Interior Gateway Routing Protocol (EIGRP)
  - Border Gateway Protocol (BGP)
  - Intermediate System-to-Intermediate System (IS-IS)
- Once the network packet has arrived at the destination network the network routing device uses the ARP protocol/table to determine the HW address of the network interface that is assigned to the destination IP address.
- Once the HW (MAC) address is known the network routing can also use MAC tables to determine the port of layer 2 switch in which the network interface device is attached to.
- Once the network packet arrives on the destination host's kernel via the network interface device then it's firewall determines whether to accept/reject/forward the network packet.

## service-level agreement (SLA)

A service-level agreement (SLA) is a contract between a service provider and its customers that documents what services the provider will furnish and defines the service standards the provider is obligated to meet.

## SentinelOne, Inc

SentinelOne, Inc. is an American cybersecurity company listed on NYSE based in Mountain View, California. The company was founded in 2013 by Tomer Weingarten, Almog Cohen and Ehud Shamir. Weingarten acts as the company's CEO. Vats Srivatsan is the company's COO.

## NEXT

- **[port forwarding with nftables](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/sec-configuring_port_forwarding_using_nftables)**
- Ask for 20 IP and change-over not to occur on 2nd week of month.

- **[Go Backend with IAM](../../../../go_zit_backend/README.md#next)**\
Read more about how to **[generate a key file](../../../research/m_z/zitadel/key_file.md)**.

- **[Go Frontend with IAM](../../../research/m_z/zitadel/zitadel_article.md)**\
Research Zitadel IAM

- **[Go web app in Docker](https://semaphoreci.com/community/tutorials/how-to-deploy-a-go-web-application-with-docker)**

- Verify TB Power BI report runs from alb-utl and add it to repsys volume/powerbi dir.
- **[Test k8s.io from within Cluster](https://github.com/kubernetes/client-go/blob/master/examples/in-cluster-client-configuration/main.go)**
  - read database passwords from k8s secret and write to k8s log.
- Remove password from mutex tutorial.

- **[Out-of-Cluster K8s API access](https://github.com/kubernetes/client-go/blob/master/examples/out-of-cluster-client-configuration/README.md)**

## Project List

- **[Report System](../../../projects/report_system/report_system.md)**
- **[Observability System](../../../projects/observability_system/observability_system.md)**
- Mean Time to Failure

## Development

- **[Setup Development System](../../report_system/setup_dev_system/setup_dev_system.md)**
- **[Virtual Network](../../report_system/virtual_network.md)**
- **[All Software MindMap](../../report_system/all_sw_mindmap.md)**
- **[All Software Gantt](../../report_system/all_sw_gantt.md)**
- **[Report Creation Sequence Diagram](../../report_system/report_creation_sequece_diagram.md)**
- **[Trial Balance Runner Flow Chart](../../report_system/trial_balance_runner_flow_chart.md)**
- **[Task List](../../report_system/task_list.md)**
- **[Requester Mockup](../../report_system/requester_mockup/requester_mockup.md)**

## IT Admin

- **[PKI](../../../it_admin/pki/pki_menu.md)**

## Tutorials

- **[Go Tutorials](../../../volumes/go/tutorials/tutorial_list.md)**
- **[Zitadel with Go (Backend)](../../../research/m_z/zitadel/go_backend/go_backend.md)**
- **[Zitadel with Go (Frontend)](../../../research/m_z/zitadel/go_frontend/go_frontend.md)**
- **[Handling Mutexes in Distributed Systems with Redis and Go](../../../volumes/go/tutorials/redis_sentinel/mutex/tutorial_redis_mutex_go.md)**
- **[In-Cluster K8s API access](../../../volumes/go/tutorials/k8s/in_cluster_client_configuration/in-cluster-client-configuration.md)**
- **[Out-of-Cluster K8s API access](../../../volumes/go/tutorials/k8s/out-of-cluster-client-configuration/out-of-cluster-client-configuration.md)**
- **[Containerize your Go app and use semaphore for CI/CD.](../../../volumes/go/tutorials/docker/go_web_docker/go_web_docker.md)**

## Research

- **[Research List](../../../research/research_list.md)**\
A list of all research for repsys.

- **[KVM networking](../../../research/m_z/virtualization/kvm/kvm_networking.md)**
There are a few different ways to allow a virtual machine access to the external network.

1. The default virtual network configuration is known as Usermode Networking. NAT is performed on traffic through the host interface to the outside network.

2. Alternatively, you can configure Bridged Networking to enable external hosts to directly access services on the guest operating system.

If you are confused, the libvirt Networking Handbook provides a good outline.

- **[Linux routing and traffic control](../../../research/m_z/virtualization/networking/routing/introduction_to_iproute2.md)** \
The 2.2 and above Linux kernels include a completely redesigned network subsystem. This new networking code brings Linux performance and a feature set with little competition in the general OS arena. In fact, the new routing, filtering, and classifying code is more featureful than the one provided by many dedicated routers and firewalls and traffic shaping products.

- **[Configure Static IPs](../../../research/m_z/virtualization/multipass/config_static_ips.md)** \
This document explains how to create instances with static IPs in a new network, internal to the host. With this approach, instances get an extra IP that does not change with restarts. By using a separate, local network we avoid any IP conflicts. Instances retain the usual default interface with a DHCP-allocated IP, which gives them connectivity to the outside.

- **[Create a bridge using iproute2](../../../research/m_z/virtualization/networking/bridge/iproute2_bridge.md)**\
This section describes the management of a network bridge using the ip tool from the iproute2 package

- **[Virtio-networking and OVS](../../../research/m_z/virtualization/networking/virtio/virtio-part1.md)**

  Virtio was developed as a standardized open interface for virtual machines (VMs) to access simplified devices such as block devices and network adaptors. Virtio-net is a virtual ethernet card and is the most complex device supported so far by virtio.

  In this post we will provide a high level solution overview of the virtio-networking architecture, based on establishing an interface between the host kernel and the VM guest kernel. We will present the basic building blocks including KVM, qemu and libvirt. We will look at the virtio spec and vhost protocol, and Open vSwitch (OVS) for connecting different VMs and connecting the outside world.

![](https://www.redhat.com/rhdc/managed-files/2019-09-10-virtio-intro-fig4.jpg)

- **[Mattermost](../../../research/m_z/mattermost/mattermost.md)** \
  Mattermost is an open-source, self-hostable online chat service with file sharing, search, and integrations. It is designed as an internal chat for organisations and companies, and mostly markets itself as an open-source alternative to Slack and Microsoft Teams. Wikipedia
