# Oracle Container Registry Network Config Request

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP access to the Oracle container registry which holds the **[MySQL Operator images](https://dev.mysql.com/doc/mysql-operator/en/)** needed to install **[MySQL InnoDB Cluster](https://dev.mysql.com/doc/refman/8.4/en/mysql-innodb-cluster-introduction.html)**.

Reason: MicroK8s needs access to the Oracle container registry so the it can install MySQL InnoDB image which is one of the data sources used in the Structures K8s Cluster.

Affected Application: Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used to run Structures Information System software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request TCP access to the Oracle container image registry which holds the MySQL InnoDB image which is needed for the Structures microservices.

## Key points about the firewall rule

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Destinations:
  - container-registry.oracle.com
  - *oracle.com
  - id55cllpgrte.compat.objectstorage.us-phoenix-1.oraclecloud.com
  - *oraclecloud.com

## Details

```bash
# OCI container registries
curl -vv telnet://container-registry.oracle.com:443
curl -vv telnet://oracle.com:443
curl -vv telnet://id55cllpgrte.compat.objectstorage.us-phoenix-1.oraclecloud.com:443
curl -vv telnet://oraclecloud.com:443

sudo tcpdump -i any -nn dst host container-registry.oracle.com
sudo tcpdump -i any -nn dst host oracle.com
sudo tcpdump -i any -nn dst host id55cllpgrte.compat.objectstorage.us-phoenix-1.oraclecloud.com
sudo tcpdump -i any -nn dst host oraclecloud.com

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
