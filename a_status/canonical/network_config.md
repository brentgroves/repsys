# MicroK8s Network Config Request

## references

- **[Installing MicroK8s Offline or in an airgapped environment](https://microk8s.io/docs/install-offline)**
- **[What is Squid Proxy](https://wiki.squid-cache.org/)**
- **[config examples](https://wiki.squid-cache.org/ConfigExamples/)**
- **[services and ports](https://microk8s.io/docs/services-and-ports)**

## core images required to bring up MicroK8s

```bash
docker.io/calico/cni:v3.28.1
docker.io/calico/kube-controllers:v3.28.1
docker.io/calico/node:v3.28.1
docker.io/cdkbot/hostpath-provisioner:1.5.0
docker.io/coredns/coredns:1.12.0
docker.io/library/busybox:1.28.4
registry.k8s.io/ingress-nginx/controller:v1.12.0
registry.k8s.io/metrics-server/metrics-server:v0.7.2
registry.k8s.io/pause:3.10
```

## all OCI container registries

```bash
*k8s.io
*docker.io
*quay.io
*gcr.io
*mcr.microsoft.com
*ghcr.io
```

## development software

```bash
*nodejs.org
*anaconda.com 
```

## Domains Access

```bash
# container registries
curl -vv telnet://docker.io:443
curl -vv telnet://k8s.io:443
curl -vv telnet://registry.k8s.io:443
curl -vv telnet://test.odbc.plex.com:19995
curl -vv telnet://quay.io:443
## don't know why this don't work
curl -vv telnet://gcr.io:443
curl -vv telnet://mcr.microsoft.com:443
curl -vv telnet://ghcr.io:443
# development software
curl -vv telnet://nodejs.org:443
curl -vv telnet://repo.anaconda.com:443

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

```

## references

- **[services and ports](https://microk8s.io/docs/services-and-ports)**
- **[Installing MicroK8s Offline or in an airgapped environment](https://microk8s.io/docs/install-offline)**
- **[What is Squid Proxy](https://wiki.squid-cache.org/)**
- **[config examples](https://wiki.squid-cache.org/ConfigExamples/)**
- **[services and ports](https://microk8s.io/docs/services-and-ports)**

Docker Hub (hub.docker.com), Quay (quay.io), Google Container Registry (gcr.io), Microsoft Container Registry (mcr.microsoft.com), and GitHub Container Registry (ghcr.io).

| Registry                      | Key Features                                              | Pricing       | Deployment Options         |
|-------------------------------|-----------------------------------------------------------|---------------|----------------------------|
| Amazon ECR                    | Private registry, image scanning, vulnerability detection | Paid          | On-premises, Cloud, Hybrid |
| Azure Container Registry      | Private registry, image scanning, vulnerability detection | Paid          | On-premises, Cloud, Hybrid |
| Docker Hub                    | Public registry, image scanning, vulnerability detection  | Free and Paid | Cloud                      |
| GitHub Package Registry       | Private registry, image scanning, vulnerability detection | Paid          | Cloud                      |
| GitLab Container Registry     | Private registry, image scanning, vulnerability detection | Paid          | On-premises, Cloud, Hybrid |
| Google Artifact Registry      | Private registry, image scanning, vulnerability detection | Paid          | Cloud                      |
| Harbor Container Registry     | Private registry, image scanning, vulnerability detection | Free and Paid | On-premises, Cloud, Hybrid |
| Red Hat Quay                  | Private registry, image scanning, vulnerability detection | Paid          | On-premises, Cloud, Hybrid |
| Sonatype Nexus Repository OSS | Private registry, image scanning, vulnerability detection | Free and Paid | On-premises, Cloud, Hybrid |

## **[List of public container registries](https://www.reddit.com/r/kubernetes/comments/gj0hrk/list_of_public_container_registries/)**

DockerHub
URL: hub.docker.com
Used: various containers

Quay (Public Redhat registry)
URL: *.quay.io
Used: cert-manager, nginx-ingress

GCR (Google Registry)
URL: *gcr.io
Used: dnsutils, kubernetes-dashboard, metrics server

MCR (microsoft registry)
URL: mcr.microsoft.com
Used: kube-proxy, omsagent
