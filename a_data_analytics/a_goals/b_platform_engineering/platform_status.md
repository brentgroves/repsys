# Structures Platform Engineering support for the Mach2 MES

Hi Team,

This is a suggestion from working to validate a TLS certificate programmatically from the Structures K8s Cluster.

Thank you.

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Suggestion

Allow easier access to our Mach2 management and monitoring web pages.

## How

Create a Linux VM on each location's server VLAN to forward HTTPS traffic to the Mach2 management and monitoring web pages.

## Mach2 servers

The Mach2 servers have been secured using a Windows Group Policy, which installs the Structures intermediate and root certificates on machines needing access. We can upgrade the authentication requirement for non-OT network clients to mTLS, but this would require setting up a proxy server.

- **[PKI](https://www.okta.com/identity-101/public-key-infrastructure/#:~:text=PKI%20certificates,Issuing%20CA's%20digital%20signature)**
- **[mTLS](https://goteleport.com/learn/what-is-mtls/#:~:text=authentication%20and%20encryption.-,What%20is%20mutual%20TLS%20authentication%20(mTLS)?,data%20across%20the%20public%20internet.)**
- **[MES](https://www.ibm.com/think/topics/mes-system#:~:text=in%20MES%20systems-,What%20is%20an%20MES?,processes%20on%20the%20shop%20floor.)**

## Details

Use a SystemD unit file to load port forwarding rules at boot.

- **SystemD:** Linux initialization system and service manager.
- **Iptables:** Command-line interface that manages the Linux kernel's packet filtering framework, known as Netfilter.  

```bash
# replace 10.187.50.x with Linux VM address.
# allow inbound and outbound forwarding
iptables -A FORWARD -p tcp -d 10.187.220.52 --dport 443 -j ACCEPT
iptables -A FORWARD -p tcp -s 10.187.220.52 --sport 443 -j ACCEPT

# route packets arriving at external IP/port to LAN machine
iptables -t nat -A PREROUTING  -p tcp -d 10.187.50.x --dport 443 -j DNAT --to-destination 10.187.220.52:443

# rewrite packets going to LAN machine (identified by address/port)
# to originate from gateway's internal address
iptables -t nat -A POSTROUTING -p tcp -d 10.187.220.52 --dport 443 -j SNAT --to-source 10.187.50.x
```

## Team

Christian. Trujillo, IT Structures Manager
Brent Hall, System Administrator Senior
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor
Sam Jackson, Information Systems Developer
Matt Irey, Desktop and System Support Technician
David Maitner,  Desktop and System Support Technician
Carl Stangland, Desktop and System Support Technician
