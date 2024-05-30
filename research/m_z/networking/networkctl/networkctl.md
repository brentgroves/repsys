# **[networkctl](https://www.tecmint.com/networkctl-check-linux-network-interface-status/)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Networking Menu](../networking_menu.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

Note: Before running networkctl, ensure that systemd-networkd is running, otherwise you will get incomplete output indicated by the following error.

You can check the status of systemd-networkd by running the following systemctl command.

```bash
sudo systemctl status systemd-networkd
```

If systemd-networkd is not running, you can start, enable it to start at boot time, and verify the status using the following commands.

```bash
sudo systemctl start systemd-networkd
sudo systemctl enable systemd-networkd
sudo systemctl status systemd-networkd
```

## Listing Network Connections in Linux

To get the status information about your all network connections, run the following networkctl command without any argument.

```bash
networkctl
```

The above command will list all the network interfaces along with their statuses.

![](https://www.tecmint.com/wp-content/uploads/2018/07/Check-Network-Connection-Status.png)

In the above output, you can see three network interfaces: lo (loopback), enp7s0 (Ethernet), and virbr0 (virtual network). Each interface has information about its index (IDX), name (LINK), type, operational status, and setup status.

2. Listing Active Network Connections in Linux
To display information about the specified links, such as type, state, kernel module driver, hardware and IP address, configured DNS, server, and more, use the status command. If you don’t specify any links, routable links are shown by default.

```bash
networkctl status
```

![](https://www.tecmint.com/wp-content/uploads/2018/07/Check-All-Network-Connection-Status.png)

To list various details of specific network interface called enp7s0, you can run the following command, which will list network configuration files, type, state, IP addresses (both IPv4 and IPv6), broadcast addresses, gateway, DNS servers, domain, routing information, maximum transmission unit (MTU), and queuing discipline (QDisc).

```bash
networkctl status enp6s0

● 3: enp6s0
                   Link File: /usr/lib/systemd/network/99-default.link
                Network File: /run/systemd/network/10-netplan-extra0.network
                       State: routable (configured)
                Online state: online                                         
                        Type: ether
                        Path: pci-0000:06:00.0
                      Driver: virtio_net
                      Vendor: Red Hat, Inc.
                       Model: Virtio 1.0 network device
            Hardware Address: 5c:13:55:48:43:58
                         MTU: 1500 (min: 68, max: 65535)
                       QDisc: mq
IPv6 Address Generation Mode: eui64
    Number of Queues (Tx/Rx): 2/2
            Auto negotiation: no
                     Address: 10.13.31.13
                              fe80::5e13:55ff:fe48:4358
           Activation Policy: up
         Required For Online: yes
           DHCP6 Client DUID: DUID-EN/Vendor:0000ab11fa956945a47e6700

May 29 18:37:58 test1 systemd-networkd[715]: enp6s0: Link UP
May 29 18:37:58 test1 systemd-networkd[715]: enp6s0: Gained carrier
May 29 18:37:58 test1 systemd-networkd[715]: enp6s0: Configuring with /run/systemd/network/10-netplan-extra0.network.
May 29 18:37:58 test1 systemd-networkd[715]: enp6s0: DHCPv6 lease lost
May 29 18:38:00 test1 systemd-networkd[715]: enp6s0: Gained IPv6LL
May 30 06:36:09 test1 systemd-networkd[715]: enp6s0: DHCPv6 lease lost
May 30 06:36:09 test1 systemd-networkd[5396]: enp6s0: Link UP
May 30 06:36:09 test1 systemd-networkd[5396]: enp6s0: Gained carrier
May 30 06:36:09 test1 systemd-networkd[5396]: enp6s0: Gained IPv6LL
May 30 06:36:09 test1 systemd-networkd[5396]: enp6s0: Configuring with /run/systemd/network/10-netplan-extra0.network.
```

![](https://www.tecmint.com/wp-content/uploads/2018/07/Check-Network-Interface-Status.png)
