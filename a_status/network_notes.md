# Network Notes

## Fabric

Each switch needs these vlans configured.

```yaml
name: alb-ot-vm
  vlan: 1220
  isid_nsi: 6540220
name: avi-ot-vm
  vlan: 220
  isid_nsi: 6560220
```

## core switch

There are 2 configured identically.

```yaml
port: 1
  destination: top edge
port: 9
  destination: bottom edge
```

## top edge

```yaml
ip: 10.11
port: 28
  destination: bottom r620
  vlans:
    - 1220-untagged
    - 220-untagged
    - 50-untagged
port: 29
  destination: middle r620
  vlans:
    - 1220-untagged
    - 220-untagged
    - 50-untagged
port: 30
  destination: top r620
  vlans:
    - 1220-untagged
    - 220-untagged
    - 50-untagged
```

## bottom edge

```yaml
ip: 10.?
port: 25
  destination: laptop
  vlans:
    - 1220-untagged
```
