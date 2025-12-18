# MicroStack Request

Submitted : 2025-05-17 18:24:36
Request Number : REQ0203411

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Issue: For **[MicroStack](https://canonical.com/microstack/docs)** to work as intended it must have access to the following **[domains](https://discourse.ubuntu.com/t/proxy-acl-access/43948)**.

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP access to the domains needed for MicroStack to work correctly.

Reason: MicroStack is used to install Kubernetes but it is also **[managed by Kubernetes](https://ubuntu.com/blog/kubernetes-vs-openstack)**.

Affected Application: Automated ETL and Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used to run Structures Information System software such as the Automated ETL and Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request TCP access to the **[ACL list](https://discourse.ubuntu.com/t/proxy-acl-access/43948)** MicroStack needs to run.

## Key points about the firewall rule

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Destinations:
  - streams.canonical.com
  - *canonical.com
  - archive.ubuntu.com
  - security.ubuntu.com
  - cloud-images.ubuntu.com
  - *ubuntu.com
  - api.charmhub.io
  - *charmhub.io
  - docker.io
  - *docker.io
  - production.cloudflare.docker.com
  - *docker.com
  - quay.io
  - *quay.io
  - ghcr.io
  - *ghcr.io
  - pkg-containers.githubusercontent.com
  - *githubusercontent.com
  - registry.k8s.io
  - *k8s.io
  - pkg.dev
  - *pkg.dev
  - amazonaws.com
  - *amazonaws.com
  - registry.jujucharms.com
  - *jujucharms.com
  - api.snapcraft.io
  - *snapcraft.io
  - snapcraftcontent.com
  - *snapcraftcontent.com
  - builds.coreos.fedoraproject.org
  - *fedoraproject.org
  - download.cirros-cloud.net
  - *cirros-cloud.net
  - maas.io
  - *maas.io
  - contracts.canonical.com
  - images.lxd.canonical.com

## Verify

```bash
# Monitor HTTP traffic including request and response headers and message body (source):
cd ~
sudo tcpdump -A -s 0 'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)' -w out.pcap -Z brent
# sudo tcpdump -X -s 0 'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)' -w out.pcap` -Z brent
``

```bash
sudo snap install openstack
sunbeam prepare-node-script --bootstrap
sunbeam prepare-node-script --bootstrap | bash -x && newgrp snap_daemon
sunbeam cluster bootstrap
sunbeam configure --openrc demo-openrc
sunbeam launch ubuntu --name test
```

## Examine packet capture file

```bash
tcpdump -r out.pcap 
```
