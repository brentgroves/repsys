# 3 VLAN

Configured edge switch port 28,29,31 with vlans: 50,220, and 1220

- all networked access to all machines ceased.

```bash
network:
  version: 2
  ethernets:
    eno1:
      dhcp4: false
      addresses:
      - 10.188.50.201/24    
      routes:
      - to: default
        via: 10.188.50.254
      nameservers:
        addresses:
        - 10.225.50.203
        - 10.224.50.203
```

1. Change edge switch back to vlans 50 and 220 only.

- still no network access.

2. next attempt at 3 VLANS on one port only.
