# OCI Container Registries Network Config Request

Submitted : 2025-03-14 07:40:52
Request Number : REQ0193968

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP access to **[OCI container registries](https://opencontainers.org/about/overview/)** to install **[MicroK8s](https://microk8s.io/docs/install-offline)** and the software it manages.

Reason: Kubernetes needs access to OCI container registries to download container images of software it will manage.

Affected Application: Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used to run Structures Information System software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request TCP access to major OCI container registries.

## Key points about the firewall rule

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Destinations:
*k8s.io
*docker.io
*quay.io
*gcr.io
*mcr.microsoft.com
*ghcr.io

## Details

```bash
# OCI container registries
curl -vv telnet://docker.io:443
curl -vv telnet://k8s.io:443
curl -vv telnet://registry.k8s.io:443
curl -vv telnet://test.odbc.plex.com:19995
curl -vv telnet://quay.io:443
curl -vv telnet://gcr.io:443
curl -vv telnet://mcr.microsoft.com:443
curl -vv telnet://ghcr.io:443

sudo tcpdump -i any -nn dst host docker.io
sudo tcpdump -i any -nn dst host k8s.io
sudo tcpdump -i any -nn dst host registry.k8s.io
sudo tcpdump -i any -nn dst host test.odbc.plex.com
sudo tcpdump -i any -nn dst host gcr.io
sudo tcpdump -i any -nn dst host mcr.microsoft.com
sudo tcpdump -i any -nn dst host ghcr.io
```

## Test Process

1. Add firewall rule
2. microk8s start

```bash
ssh brent@10.188.50.201
sudo cat /etc/netplan/50-cloud-init.yaml 
ip a show eno1
microk8s start
microk8s status
# not running
```

John Biel
