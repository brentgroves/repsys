# complete status

```bash

multipass exec -n microk8s-vm -- sudo networkctl -a status
● 1: lo                                                         
                     Link File: n/a
                  Network File: n/a
                          Type: loopback
                         State: carrier (unmanaged)
                  Online state: unknown
                    HW Address: 00:00:00:00:00:00
                           MTU: 65536
                         QDisc: noqueue
  IPv6 Address Generation Mode: eui64
          Queue Length (Tx/Rx): 1/1
                       Address: 127.0.0.1
                                ::1
             Activation Policy: up
           Required For Online: yes

Jul 11 22:15:00 microk8s-vm systemd-networkd[689]: lo: Link UP
Jul 11 22:15:00 microk8s-vm systemd-networkd[689]: lo: Gained carrier

● 2: enp5s0                                                                    
                     Link File: /usr/lib/systemd/network/99-default.link
                  Network File: /run/systemd/network/10-netplan-default.network
                          Type: ether
                         State: routable (configured)
                  Online state: online                                         
                          Path: pci-0000:05:00.0
                        Driver: virtio_net
                        Vendor: Red Hat, Inc.
                         Model: Virtio network device
                    HW Address: 52:54:00:b7:ef:90
                           MTU: 1500 (min: 68, max: 65535)
                         QDisc: mq
  IPv6 Address Generation Mode: eui64
          Queue Length (Tx/Rx): 2/2
              Auto negotiation: no
                         Speed: n/a
                       Address: 10.127.233.200 (DHCP4 via 10.127.233.1)
                                fd42:9872:e9ef:7908:5054:ff:feb7:ef90
                                fe80::5054:ff:feb7:ef90
                       Gateway: 10.127.233.1
                                fe80::216:3eff:fe72:3876
                           DNS: 10.127.233.1
                                fe80::216:3eff:fe72:3876
                Search Domains: lxd
             Activation Policy: up
           Required For Online: yes
               DHCP4 Client ID: IAID:0x49721f47/DUID
             DHCP6 Client IAID: 0x49721f47
             DHCP6 Client DUID: DUID-EN/Vendor:0000ab11cd86ad425e510a3f0000

Jul 12 23:34:57 microk8s-vm systemd-networkd[689]: enp5s0: DHCPv6 lease lost
Jul 12 23:34:57 microk8s-vm systemd-networkd[689]: enp5s0: DHCPv4 address 10.127.233.200/24 via 10.127.233.1
Jul 15 21:21:25 microk8s-vm systemd-networkd[689]: enp5s0: Re-configuring with /run/systemd/network/10-netplan-default.network
Jul 15 21:21:25 microk8s-vm systemd-networkd[689]: enp5s0: DHCP lease lost
Jul 15 21:21:25 microk8s-vm systemd-networkd[689]: enp5s0: DHCPv6 lease lost
Jul 15 21:21:25 microk8s-vm systemd-networkd[689]: enp5s0: DHCPv4 address 10.127.233.200/24 via 10.127.233.1
Jul 15 21:21:25 microk8s-vm systemd-networkd[689]: enp5s0: Re-configuring with /run/systemd/network/10-netplan-default.network
Jul 15 21:21:25 microk8s-vm systemd-networkd[689]: enp5s0: DHCP lease lost
Jul 15 21:21:25 microk8s-vm systemd-networkd[689]: enp5s0: DHCPv6 lease lost
Jul 15 21:21:25 microk8s-vm systemd-networkd[689]: enp5s0: DHCPv4 address 10.127.233.200/24 via 10.127.233.1

● 3: enp6s0                                                                    
                     Link File: /usr/lib/systemd/network/99-default.link
                  Network File: /run/systemd/network/10-netplan-extra0.network
                          Type: ether
                         State: routable (configured)
                  Online state: unknown
                          Path: pci-0000:06:00.0
                        Driver: virtio_net
                        Vendor: Red Hat, Inc.
                         Model: Virtio network device
                    HW Address: 52:54:00:a6:3d:3e
                           MTU: 1500 (min: 68, max: 65535)
                         QDisc: mq
  IPv6 Address Generation Mode: eui64
          Queue Length (Tx/Rx): 2/2
              Auto negotiation: no
                         Speed: n/a
                       Address: 10.1.0.128
                                fe80::5054:ff:fea6:3d3e
                           DNS: 10.1.2.69
                                10.1.2.70
                                172.20.0.39
                Search Domains: BUSCHE-CNC.COM
             Activation Policy: up
           Required For Online: no
             DHCP6 Client DUID: DUID-EN/Vendor:0000ab11cd86ad425e510a3f0000

Jul 12 23:03:25 microk8s-vm systemd-networkd[689]: enp6s0: Re-configuring with /run/systemd/network/10-netplan-extra0.network
Jul 12 23:03:25 microk8s-vm systemd-networkd[689]: enp6s0: DHCPv6 lease lost
Jul 12 23:34:57 microk8s-vm systemd-networkd[689]: enp6s0: Re-configuring with /run/systemd/network/10-netplan-extra0.network
Jul 12 23:34:57 microk8s-vm systemd-networkd[689]: enp6s0: DHCPv6 lease lost
Jul 12 23:34:57 microk8s-vm systemd-networkd[689]: enp6s0: Re-configuring with /run/systemd/network/10-netplan-extra0.network
Jul 12 23:34:57 microk8s-vm systemd-networkd[689]: enp6s0: DHCPv6 lease lost
Jul 15 21:21:25 microk8s-vm systemd-networkd[689]: enp6s0: Re-configuring with /run/systemd/network/10-netplan-extra0.network
Jul 15 21:21:25 microk8s-vm systemd-networkd[689]: enp6s0: DHCPv6 lease lost
Jul 15 21:21:25 microk8s-vm systemd-networkd[689]: enp6s0: Re-configuring with /run/systemd/network/10-netplan-extra0.network
Jul 15 21:21:25 microk8s-vm systemd-networkd[689]: enp6s0: DHCPv6 lease lost

● 25: califef1684cded                                                   
                     Link File: /usr/lib/systemd/network/99-default.link
                  Network File: n/a
                          Type: ether
                         State: degraded (unmanaged)
                  Online state: unknown
                        Driver: veth
                    HW Address: ee:ee:ee:ee:ee:ee
                           MTU: 1450 (min: 68, max: 65535)
                         QDisc: noqueue
  IPv6 Address Generation Mode: eui64
          Queue Length (Tx/Rx): 1/1
              Auto negotiation: no
                         Speed: 10Gbps
                        Duplex: full
                          Port: tp
                       Address: fe80::ecee:eeff:feee:eeee
             Activation Policy: up
           Required For Online: yes

Jul 12 23:35:18 microk8s-vm systemd-networkd[689]: califef1684cded: Link DOWN
Jul 12 23:35:18 microk8s-vm systemd-networkd[689]: califef1684cded: Lost carrier
Jul 12 23:35:22 microk8s-vm systemd-networkd[689]: califef1684cded: Link UP
Jul 12 23:35:22 microk8s-vm systemd-networkd[689]: califef1684cded: Gained carrier
Jul 12 23:35:23 microk8s-vm systemd-networkd[689]: califef1684cded: Gained IPv6LL
Jul 15 21:21:53 microk8s-vm systemd-networkd[689]: califef1684cded: Link DOWN
Jul 15 21:21:53 microk8s-vm systemd-networkd[689]: califef1684cded: Lost carrier
Jul 15 21:21:55 microk8s-vm systemd-networkd[689]: califef1684cded: Link UP
Jul 15 21:21:55 microk8s-vm systemd-networkd[689]: califef1684cded: Gained carrier
Jul 15 21:21:56 microk8s-vm systemd-networkd[689]: califef1684cded: Gained IPv6LL

● 26: caliaa3ea81deeb                                                   
                     Link File: /usr/lib/systemd/network/99-default.link
                  Network File: n/a
                          Type: ether
                         State: degraded (unmanaged)
                  Online state: unknown
                        Driver: veth
                    HW Address: ee:ee:ee:ee:ee:ee
                           MTU: 1450 (min: 68, max: 65535)
                         QDisc: noqueue
  IPv6 Address Generation Mode: eui64
          Queue Length (Tx/Rx): 1/1
              Auto negotiation: no
                         Speed: 10Gbps
                        Duplex: full
                          Port: tp
                       Address: fe80::ecee:eeff:feee:eeee
             Activation Policy: up
           Required For Online: yes

Jul 12 23:35:17 microk8s-vm systemd-networkd[689]: caliaa3ea81deeb: Link DOWN
Jul 12 23:35:17 microk8s-vm systemd-networkd[689]: caliaa3ea81deeb: Lost carrier
Jul 12 23:35:21 microk8s-vm systemd-networkd[689]: caliaa3ea81deeb: Link UP
Jul 12 23:35:21 microk8s-vm systemd-networkd[689]: caliaa3ea81deeb: Gained carrier
Jul 12 23:35:22 microk8s-vm systemd-networkd[689]: caliaa3ea81deeb: Gained IPv6LL
Jul 15 21:21:53 microk8s-vm systemd-networkd[689]: caliaa3ea81deeb: Link DOWN
Jul 15 21:21:53 microk8s-vm systemd-networkd[689]: caliaa3ea81deeb: Lost carrier
Jul 15 21:21:55 microk8s-vm systemd-networkd[689]: caliaa3ea81deeb: Link UP
Jul 15 21:21:55 microk8s-vm systemd-networkd[689]: caliaa3ea81deeb: Gained carrier
Jul 15 21:21:57 microk8s-vm systemd-networkd[689]: caliaa3ea81deeb: Gained IPv6LL

● 27: cali7c6f95a7773                                                   
                     Link File: /usr/lib/systemd/network/99-default.link
                  Network File: n/a
                          Type: ether
                         State: degraded (unmanaged)
                  Online state: unknown
                        Driver: veth
                    HW Address: ee:ee:ee:ee:ee:ee
                           MTU: 1450 (min: 68, max: 65535)
                         QDisc: noqueue
  IPv6 Address Generation Mode: eui64
          Queue Length (Tx/Rx): 1/1
              Auto negotiation: no
                         Speed: 10Gbps
                        Duplex: full
                          Port: tp
                       Address: fe80::ecee:eeff:feee:eeee
             Activation Policy: up
           Required For Online: yes

Jul 12 23:35:17 microk8s-vm systemd-networkd[689]: cali7c6f95a7773: Link DOWN
Jul 12 23:35:17 microk8s-vm systemd-networkd[689]: cali7c6f95a7773: Lost carrier
Jul 12 23:35:21 microk8s-vm systemd-networkd[689]: cali7c6f95a7773: Link UP
Jul 12 23:35:21 microk8s-vm systemd-networkd[689]: cali7c6f95a7773: Gained carrier
Jul 12 23:35:23 microk8s-vm systemd-networkd[689]: cali7c6f95a7773: Gained IPv6LL
Jul 15 21:21:53 microk8s-vm systemd-networkd[689]: cali7c6f95a7773: Link DOWN
Jul 15 21:21:53 microk8s-vm systemd-networkd[689]: cali7c6f95a7773: Lost carrier
Jul 15 21:21:55 microk8s-vm systemd-networkd[689]: cali7c6f95a7773: Link UP
Jul 15 21:21:55 microk8s-vm systemd-networkd[689]: cali7c6f95a7773: Gained carrier
Jul 15 21:21:57 microk8s-vm systemd-networkd[689]: cali7c6f95a7773: Gained IPv6LL

● 28: cali20506ab8061                                                   
                     Link File: /usr/lib/systemd/network/99-default.link
                  Network File: n/a
                          Type: ether
                         State: degraded (unmanaged)
                  Online state: unknown
                        Driver: veth
                    HW Address: ee:ee:ee:ee:ee:ee
                           MTU: 1450 (min: 68, max: 65535)
                         QDisc: noqueue
  IPv6 Address Generation Mode: eui64
          Queue Length (Tx/Rx): 1/1
              Auto negotiation: no
                         Speed: 10Gbps
                        Duplex: full
                          Port: tp
                       Address: fe80::ecee:eeff:feee:eeee
             Activation Policy: up
           Required For Online: yes

Jul 12 23:35:17 microk8s-vm systemd-networkd[689]: cali20506ab8061: Link DOWN
Jul 12 23:35:17 microk8s-vm systemd-networkd[689]: cali20506ab8061: Lost carrier
Jul 12 23:35:21 microk8s-vm systemd-networkd[689]: cali20506ab8061: Link UP
Jul 12 23:35:21 microk8s-vm systemd-networkd[689]: cali20506ab8061: Gained carrier
Jul 12 23:35:22 microk8s-vm systemd-networkd[689]: cali20506ab8061: Gained IPv6LL
Jul 15 21:21:53 microk8s-vm systemd-networkd[689]: cali20506ab8061: Link DOWN
Jul 15 21:21:53 microk8s-vm systemd-networkd[689]: cali20506ab8061: Lost carrier
Jul 15 21:21:55 microk8s-vm systemd-networkd[689]: cali20506ab8061: Link UP
Jul 15 21:21:55 microk8s-vm systemd-networkd[689]: cali20506ab8061: Gained carrier
Jul 15 21:21:57 microk8s-vm systemd-networkd[689]: cali20506ab8061: Gained IPv6LL

● 31: vxlan.calico                                                      
                     Link File: /usr/lib/systemd/network/99-default.link
                  Network File: n/a
                          Type: vxlan
                         State: routable (unmanaged)
                  Online state: unknown
                        Driver: vxlan
                    HW Address: 66:93:9c:9e:2f:c8
                           MTU: 1450 (min: 68, max: 65535)
                         QDisc: noqueue
  IPv6 Address Generation Mode: eui64
                           VNI: 4096
                         Local: 10.1.0.128
              Destination Port: 4789
             Underlying Device: enp6s0
                      Learning: no
                           RSC: no
                        L3MISS: no
                        L2MISS: no
                           TTL: auto
          Queue Length (Tx/Rx): 1/1
              Auto negotiation: no
                         Speed: n/a
                       Address: 10.1.254.64
                                fe80::6493:9cff:fe9e:2fc8
             Activation Policy: up
           Required For Online: yes

Jul 12 23:35:30 microk8s-vm systemd-networkd[689]: vxlan.calico: Link DOWN
Jul 12 23:35:30 microk8s-vm systemd-networkd[689]: vxlan.calico: Lost carrier
Jul 12 23:35:30 microk8s-vm systemd-networkd[689]: vxlan.calico: Link UP
Jul 12 23:35:30 microk8s-vm systemd-networkd[689]: vxlan.calico: Gained carrier
Jul 12 23:35:31 microk8s-vm systemd-networkd[689]: vxlan.calico: Gained IPv6LL
Jul 15 21:22:04 microk8s-vm systemd-networkd[689]: vxlan.calico: Link DOWN
Jul 15 21:22:04 microk8s-vm systemd-networkd[689]: vxlan.calico: Lost carrier
Jul 15 21:22:04 microk8s-vm systemd-networkd[689]: vxlan.calico: Link UP
Jul 15 21:22:04 microk8s-vm systemd-networkd[689]: vxlan.calico: Gained carrier
Jul 15 21:22:06 microk8s-vm systemd-networkd[689]: vxlan.calico: Gained IPv6LL
```
