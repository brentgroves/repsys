# software cd

create iso from cd using gnome disks

```bash
lxc config device add win11 install disk source=/home/brent/Downloads/nport52.iso boot.priority=10
lxc config show win11 --expanded

architecture: x86_64
config:
  limits.cpu: "4"
  limits.memory: 8GiB
  security.secureboot: "false"
  volatile.cloud-init.instance-id: f49c7cba-d1b8-4cef-b312-c4c359e5ee2d
  volatile.eth0.hwaddr: 00:16:3e:1c:e5:fb
  volatile.last_state.power: STOPPED
  volatile.last_state.ready: "false"
  volatile.uuid: ddc84431-a0f7-47a4-aad6-d8a1a7609c8d
  volatile.uuid.generation: ddc84431-a0f7-47a4-aad6-d8a1a7609c8d
  volatile.vsock_id: "3435766421"
devices:
  eth0:
    name: eth0
    network: lxdbr0
    type: nic
  install:
    boot.priority: "10"
    source: /home/brent/Downloads/nport52.iso
    type: disk
  root:
    path: /
    pool: default
    size: 120GiB
    type: disk
  vtpm:
    path: /dev/tpm0
    type: tpm
ephemeral: false
profiles:
- default
stateful: false
description: ""
```

## open software folder

open
NPort Administration Suite:

1. Component List
1. Utililties
2. Real Com Mode Support Package
3. IP Serial Lib Package

2. Utilities
 Provides Configure, Monitor, and COM mapping administration utilities for NPort.

3. Real Com Mode Support Package
 Provides a misc lib for Real COM management.

4. IP Serial Lib Package
 Provides a Library to support TCP Server Mode access. Include several examples.

12-08-2003
