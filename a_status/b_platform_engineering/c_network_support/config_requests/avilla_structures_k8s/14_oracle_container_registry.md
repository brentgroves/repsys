# Oracle Container Registry Network Config Request

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP access to the Oracle container registry which hols the **[Calico OCI image](https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengsettingupcalico.htm)** needed to install **[MicroK8s](https://microk8s.io/docs/install-offline)** and the software it manages.

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
  - container-registry.oracle.com
  - *oracle.com

## Details

```bash
# OCI container registries
curl -vv telnet://container-registry.oracle.com:443
curl -vv telnet://oracle.com:443

sudo tcpdump -i any -nn dst host container-registry.oracle.com
sudo tcpdump -i any -nn dst host oracle.com
```

## Test Process

1. Add firewall rule
2. verify operator was pulled successfully

```bash
kubectl get all -n mysql-operator

NAME                                  READY   STATUS         RESTARTS   AGE
pod/mysql-operator-7cbc8bd94d-jqzb6   0/1     ErrImagePull   0          45s
```

John Biel
