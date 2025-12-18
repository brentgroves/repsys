# Dell VPRO

## LXC

It uses nftables and not iptables-nft because it was available when I installed

```bash
lxc info | grep firewall
- network_firewall_filtering
- firewall_driver
  firewall: nftables
```
