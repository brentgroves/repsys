# complete status

```
multipass exec -n repsys11-c2-n1 -- sudo networkctl -a status
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

Jul 11 22:15:02 repsys11-c2-n1 systemd-networkd[690]: lo: Link UP
Jul 11 22:15:02 repsys11-c2-n1 systemd-networkd[690]: lo: Gained carrier

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
                    HW Address: 52:54:00:a8:40:63
                           MTU: 1500 (min: 68, max: 65535)
                         QDisc: mq
  IPv6 Address Generation Mode: eui64
          Queue Length (Tx/Rx): 2/2
              Auto negotiation: no
                         Speed: n/a
                       Address: 10.127.233.66 (DHCP4 via 10.127.233.1)
                                fd42:9872:e9ef:7908:5054:ff:fea8:4063
                                fe80::5054:ff:fea8:4063
                       Gateway: 10.127.233.1
                                fe80::216:3eff:fe72:3876
                           DNS: 10.127.233.1
                                fe80::216:3eff:fe72:3876
                Search Domains: lxd
             Activation Policy: up
           Required For Online: yes
               DHCP4 Client ID: IAID:0x49721f47/DUID
             DHCP6 Client IAID: 0x49721f47
             DHCP6 Client DUID: DUID-EN/Vendor:0000ab114ea25eb8fd38096b0000

Jul 12 23:37:28 repsys11-c2-n1 systemd-networkd[690]: enp5s0: DHCPv6 lease lost
Jul 12 23:37:28 repsys11-c2-n1 systemd-networkd[690]: enp5s0: DHCPv4 address 10.127.233.66/24 via 10.127.233.1
Jul 15 21:50:22 repsys11-c2-n1 systemd-networkd[690]: enp5s0: Re-configuring with /run/systemd/network/10-netplan-default.network
Jul 15 21:50:22 repsys11-c2-n1 systemd-networkd[690]: enp5s0: DHCP lease lost
Jul 15 21:50:22 repsys11-c2-n1 systemd-networkd[690]: enp5s0: DHCPv6 lease lost
Jul 15 21:50:22 repsys11-c2-n1 systemd-networkd[690]: enp5s0: DHCPv4 address 10.127.233.66/24 via 10.127.233.1
Jul 15 21:50:22 repsys11-c2-n1 systemd-networkd[690]: enp5s0: Re-configuring with /run/systemd/network/10-netplan-default.network
Jul 15 21:50:22 repsys11-c2-n1 systemd-networkd[690]: enp5s0: DHCP lease lost
Jul 15 21:50:22 repsys11-c2-n1 systemd-networkd[690]: enp5s0: DHCPv6 lease lost
Jul 15 21:50:22 repsys11-c2-n1 systemd-networkd[690]: enp5s0: DHCPv4 address 10.127.233.66/24 via 10.127.233.1

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
                    HW Address: 52:54:00:90:6f:18
                           MTU: 1500 (min: 68, max: 65535)
                         QDisc: mq
  IPv6 Address Generation Mode: eui64
          Queue Length (Tx/Rx): 2/2
              Auto negotiation: no
                         Speed: n/a
                       Address: 10.1.0.129
                                fe80::5054:ff:fe90:6f18
                           DNS: 10.1.2.69
                                10.1.2.70
                                172.20.0.39
                Search Domains: BUSCHE-CNC.COM
             Activation Policy: up
           Required For Online: no
             DHCP6 Client DUID: DUID-EN/Vendor:0000ab114ea25eb8fd38096b0000

Jul 12 23:07:26 repsys11-c2-n1 systemd-networkd[690]: enp6s0: Re-configuring with /run/systemd/network/10-netplan-extra0.network
Jul 12 23:07:26 repsys11-c2-n1 systemd-networkd[690]: enp6s0: DHCPv6 lease lost
Jul 12 23:37:28 repsys11-c2-n1 systemd-networkd[690]: enp6s0: Re-configuring with /run/systemd/network/10-netplan-extra0.network
Jul 12 23:37:28 repsys11-c2-n1 systemd-networkd[690]: enp6s0: DHCPv6 lease lost
Jul 12 23:37:28 repsys11-c2-n1 systemd-networkd[690]: enp6s0: Re-configuring with /run/systemd/network/10-netplan-extra0.network
Jul 12 23:37:28 repsys11-c2-n1 systemd-networkd[690]: enp6s0: DHCPv6 lease lost
Jul 15 21:50:22 repsys11-c2-n1 systemd-networkd[690]: enp6s0: Re-configuring with /run/systemd/network/10-netplan-extra0.network
Jul 15 21:50:22 repsys11-c2-n1 systemd-networkd[690]: enp6s0: DHCPv6 lease lost
Jul 15 21:50:22 repsys11-c2-n1 systemd-networkd[690]: enp6s0: Re-configuring with /run/systemd/network/10-netplan-extra0.network
Jul 15 21:50:22 repsys11-c2-n1 systemd-networkd[690]: enp6s0: DHCPv6 lease lost

● 19: cali8b98edb9a6d                                                   
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

Jul 12 23:37:43 repsys11-c2-n1 systemd-networkd[690]: cali8b98edb9a6d: Link DOWN
Jul 12 23:37:43 repsys11-c2-n1 systemd-networkd[690]: cali8b98edb9a6d: Lost carrier
Jul 12 23:37:45 repsys11-c2-n1 systemd-networkd[690]: cali8b98edb9a6d: Link UP
Jul 12 23:37:45 repsys11-c2-n1 systemd-networkd[690]: cali8b98edb9a6d: Gained carrier
Jul 12 23:37:47 repsys11-c2-n1 systemd-networkd[690]: cali8b98edb9a6d: Gained IPv6LL
Jul 15 21:50:35 repsys11-c2-n1 systemd-networkd[690]: cali8b98edb9a6d: Link DOWN
Jul 15 21:50:35 repsys11-c2-n1 systemd-networkd[690]: cali8b98edb9a6d: Lost carrier
Jul 15 21:50:41 repsys11-c2-n1 systemd-networkd[690]: cali8b98edb9a6d: Link UP
Jul 15 21:50:41 repsys11-c2-n1 systemd-networkd[690]: cali8b98edb9a6d: Gained carrier
Jul 15 21:50:42 repsys11-c2-n1 systemd-networkd[690]: cali8b98edb9a6d: Gained IPv6LL

● 20: calia2107ec30b5                                                   
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

Jul 12 23:37:43 repsys11-c2-n1 systemd-networkd[690]: calia2107ec30b5: Link DOWN
Jul 12 23:37:43 repsys11-c2-n1 systemd-networkd[690]: calia2107ec30b5: Lost carrier
Jul 12 23:37:46 repsys11-c2-n1 systemd-networkd[690]: calia2107ec30b5: Link UP
Jul 12 23:37:46 repsys11-c2-n1 systemd-networkd[690]: calia2107ec30b5: Gained carrier
Jul 12 23:37:48 repsys11-c2-n1 systemd-networkd[690]: calia2107ec30b5: Gained IPv6LL
Jul 15 21:50:36 repsys11-c2-n1 systemd-networkd[690]: calia2107ec30b5: Link DOWN
Jul 15 21:50:36 repsys11-c2-n1 systemd-networkd[690]: calia2107ec30b5: Lost carrier
Jul 15 21:50:41 repsys11-c2-n1 systemd-networkd[690]: calia2107ec30b5: Link UP
Jul 15 21:50:41 repsys11-c2-n1 systemd-networkd[690]: calia2107ec30b5: Gained carrier
Jul 15 21:50:43 repsys11-c2-n1 systemd-networkd[690]: calia2107ec30b5: Gained IPv6LL

● 23: vxlan.calico                                                      
                     Link File: /usr/lib/systemd/network/99-default.link
                  Network File: n/a
                          Type: vxlan
                         State: routable (unmanaged)
                  Online state: unknown
                        Driver: vxlan
                    HW Address: 66:1f:05:c8:a7:d1
                           MTU: 1450 (min: 68, max: 65535)
                         QDisc: noqueue
  IPv6 Address Generation Mode: eui64
                           VNI: 4096
                         Local: 10.1.0.129
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
                       Address: 10.1.226.0
                                fe80::641f:5ff:fec8:a7d1
             Activation Policy: up
           Required For Online: yes

Jul 12 23:37:51 repsys11-c2-n1 systemd-networkd[690]: vxlan.calico: Link DOWN
Jul 12 23:37:51 repsys11-c2-n1 systemd-networkd[690]: vxlan.calico: Lost carrier
Jul 12 23:37:51 repsys11-c2-n1 systemd-networkd[690]: vxlan.calico: Link UP
Jul 12 23:37:51 repsys11-c2-n1 systemd-networkd[690]: vxlan.calico: Gained carrier
Jul 12 23:37:53 repsys11-c2-n1 systemd-networkd[690]: vxlan.calico: Gained IPv6LL
Jul 15 21:50:46 repsys11-c2-n1 systemd-networkd[690]: vxlan.calico: Link DOWN
Jul 15 21:50:46 repsys11-c2-n1 systemd-networkd[690]: vxlan.calico: Lost carrier
Jul 15 21:50:46 repsys11-c2-n1 systemd-networkd[690]: vxlan.calico: Link UP
Jul 15 21:50:46 repsys11-c2-n1 systemd-networkd[690]: vxlan.calico: Gained carrier
Jul 15 21:50:48 repsys11-c2-n1 systemd-networkd[690]: vxlan.calico: Gained IPv6LL
```
