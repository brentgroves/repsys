# list

```bash
lxc image list --vm type=virtual-machine
lxc config show
lxc config show v1
architecture: x86_64
config:
  image.architecture: amd64
  image.description: ubuntu 24.04 LTS amd64 (release) (20250805)
  image.label: release
  image.os: ubuntu
  image.release: noble
  image.serial: "20250805"
  image.type: disk1.img
  image.version: "24.04"
  volatile.base_image: 01cbaaaa4d04ae2433dc4402ab61a4d9638637888d4759397e4fb036aa98f85b
  volatile.cloud-init.instance-id: 6d5d7d69-dd4e-4c8f-9cbd-31ecc79f1bae
  volatile.eth0.host_name: tapa488186c
  volatile.eth0.hwaddr: 00:16:3e:cb:cb:fd
  volatile.last_state.power: RUNNING
  volatile.uuid: 2ac30e39-13bf-4a4c-8bfa-5f2a6d50f21d
  volatile.uuid.generation: 2ac30e39-13bf-4a4c-8bfa-5f2a6d50f21d
  volatile.vsock_id: "545730999"
devices: {}
ephemeral: false
profiles:
- default
stateful: false
description: ""

lxc image info <image_fingerprint_or_alias>

lxc image info aeed887e1eb5
Fingerprint: aeed887e1eb5d7df9f0ff4e2d80a3231f40c0abb8ef9ec4e547b94c2be0c88ab
Size: 1140.47MiB
Architecture: x86_64
Type: virtual-machine
Public: no
Timestamps:
    Created: 2025/07/24 00:02 UTC
    Uploaded: 2025/07/24 22:34 UTC
    Expires: never
    Last used: 2025/07/24 22:34 UTC
Properties:
    os: Ubuntu
    release: noble
    requirements.cgroup: v2
    serial: 20250724_0002
    type: disk-kvm.img
    variant: desktop
    architecture: amd64
    description: Ubuntu noble amd64 (20250724_0002)
Aliases:
Cached: no
Auto update: disabled
Source:
    Server: https://images.lxd.canonical.com
    Protocol: simplestreams
    Alias: ubuntu/noble/desktop
Profiles:
    - default
```
