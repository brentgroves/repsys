# isdev-alb

```yaml
system: "Dell Laptop"
ram: 16GB
hostname: isdev
adapter 1:
    - vlan: 40
    - link: enxa0cec85afc3c
    - ip: dhcp: 10.187.40.18
    - subnet: 10.187.40.0/24
    - dns: 10.225.50.203 10.224.50.203 10.254.0.204
    - office_switch: 2
adapter 3: 
    vlan: 586
    link: enx803f5d090eb3
    ip: 172.24.189.200
    subnet: 
        - 172.24.188.0/23
        - 255.255.254.0
    dns: 
        - 8.8.8.8
        - 8.8.4.4
    - office_switch: 4
    routes: 
        - default: 172.24.189.254
    dns: 
        - 8.8.8.8
        - 8.8.4.4

```
