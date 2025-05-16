# **[Try microstack](https://canonical.com/microstack?_gl=1*vzb68q*_gcl_au*MTczMDcyNjk4MC4xNzQ0NzQ3NzU2*_ga*MzM1MDA1MDIwLjE3NDQ3NDc3NTQ.*_ga_5LTL1CNEJM*czE3NDc0MTUzNzkkbzMkZzEkdDE3NDc0MTUzNzkkajYwJGwwJGgw#get-started)**

## Project and community

MicroStack is an Open Source project that welcomes usage discussion, project feedback, and especially contributions!

Join the user forum or the chat group on **[Matrix](https://matrix.to/#/#openstack-sunbeam:ubuntu.com)** use google account
We abide by the Ubuntu Code of Conduct
Get involved in improving the software or the documentation
Don’t hesitate to reach out if you have questions about integrating MicroStack into your own cloud project.

## Try MicroStack

Refer to MicroStack **[documentation](https://canonical.com/microstack/docs)** for exact requirements regarding hardware and operating system.

## 1. Install the snap

```bash
sudo snap install openstack --channel 2024.1/beta
```

## 2. Prepare a machine

```bash
sunbeam prepare-node-script | bash -x && newgrp snap_daemon
```

## 3. Bootstrap OpenStack

```bash
sunbeam cluster bootstrap --accept-defaults

Error: Missing Juju controller on LXD
Bootstrap Juju controller on LXD:
    juju bootstrap localhost
```
