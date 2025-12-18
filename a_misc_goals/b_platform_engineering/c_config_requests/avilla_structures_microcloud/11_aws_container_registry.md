# AWS Container Registry Network Config Request

RITM0194104
Submitted : 2025-03-14 16:28:49
Request Number : REQ0194058
The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP access to the AWS container registry which hols the **[Calico OCI image](https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengsettingupcalico.htm)** needed to install **[MicroK8s](https://microk8s.io/docs/install-offline)** and the software it manages.

Reason: MicroK8s needs access to the AWS container registry so the it can install Calico OCI image which is part of its core services.

Affected Application: Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used to run Structures Information System software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request TCP access to the AWS container image registry which holds the Calico OCI image which is needed for MicroK8s networking support.

## Key points about the firewall rule

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Destinations:
  - prod-registry-k8s-io-us-east-2.s3.dualstack.us-east-2.amazonaws.com
  - *amazonaws.com
  - us-central1-docker.pkg.dev
  - *pkg.dev

## Details

```bash
# OCI container registries
curl -vv telnet://prod-registry-k8s-io-us-east-2.s3.dualstack.us-east-2.amazonaws.com:443
curl -vv telnet://amazonaws.com:443
curl -vv telnet://us-central1-docker.pkg.dev:443
curl -vv telnet://pkg.dev:443

sudo tcpdump -i any -nn dst host prod-registry-k8s-io-us-east-2.s3.dualstack.us-east-2.amazonaws.com
sudo tcpdump -i any -nn dst host amazonaws.com
sudo tcpdump -i any -nn dst host us-central1-docker.pkg.dev
sudo tcpdump -i any -nn dst host pkg.dev
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
