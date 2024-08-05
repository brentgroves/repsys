# **[lxd reset](https://discuss.linuxcontainers.org/t/lxd-4-1-reset-lxd-init/8210)**

I unsucessfuly tried to reset lxd after making an error on the lxd init process. How can I do that ?

What do you want changed?

lxd init is only a convenient way to do a bunch of commands at once:

lxc config set
lxc network create
lxc storage create
lxc profile device add
So it’s often far easier to undo and reconfigure the bits you need than wipe everything clean and run init again.

```bash
lxc network show lxdbr0

name: lxdbr0
description: ""
type: bridge
managed: true
status: Created
config:
  ipv4.address: 10.223.105.1/24
  ipv4.nat: "true"
  ipv6.address: fd42:9d25:8ccd:5ac8::1/64
  ipv6.nat: "true"
used_by:
- /1.0/profiles/default
locations:
- none
```

Also, can you show:

ps fauxww
iptables -L -n -v
If I had to guess, your lxd init went fine but you have docker or firewalld messing with your firewall blocking DHCP from your container.

## Remove

You can remove LXD (including all container and VM instances!) by running:

```bash
sudo snap remove lxd --purge
```

You can add a new dir storage pool using:

lxc storage add mypool dir
This will use the /var/lib/lxd/storage-pools/mypool directory for instances.
If you want to use a different directory add the source=/path/to/dir argument to the command above.

Then you can create instances using that pool using:

lxc launch ... -s mypool
If you want that pool to be the default pool for new instances you can modify the default profile using:

lxc profile device set default root pool=mypool
