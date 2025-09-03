# network notes

## laptop lxd minimal setup

```bash
lxc profile show default
name: default
description: Default LXD profile
config: {}
devices:
  eth0:
    name: eth0
    network: lxdbr0
    type: nic
  root:
    path: /
    pool: default
    type: disk
used_by:
- /1.0/instances/ubuntu-container
- /1.0/instances/win11
```

## microcloud lxd setup

```bash
lxc profile show default 
name: default
description: Default LXD profile
config:
  migration.stateful: "true"
devices:
  eth0:
    name: eth0
    network: default
    type: nic
  root:
    path: /
    pool: remote
    type: disk
used_by:
- /1.0/instances/win11
- /1.0/instances/v1
- /1.0/instances/v3
- /1.0/instances/ubuntu
```
