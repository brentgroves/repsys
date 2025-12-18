# Menu

**[Current Status](../a_status/current_status.md)**\
**[Back to Main](../README.md)**

- **[Azure Setup (Ask for Access)](../../azure/mobexglobal.com/azure_setup.md)**
- **[Install MicroK8s on multipass VM](./microk8s_on_multipass_vm_install.md)**
- **[create a debug pod](./create_debug_pod.md)**
- **[Kubectl](./kubectl-install.md)**
- **[Helm](./helm-install.md)**
- **[Host Path Storage](./host_path_storage/host_path_storage.md)**
- **[K8s Credentials Secret](./credentials/credentials.md)**

## InnoDB require a primary key for all tables

- Want to try InnoDB with repsys schema.
- Must have a stateful set install first so we can have something to work with.
- Do a backup and restore table by table only backup tables we use.
- Add a primary key to all tables that don't have one.
- Restore table backups into InnoDB.

- **[Temp MySQL Statefulset](./mysql-statefulset-install.md)**

## START HERE

- **[MySQL InnoDB Operator](./mysql-operator-install.md)**
- **[MySQL InnoDB Cluster](./mysql-innodb-cluster-install.md)**
- **[Postgres Operator](./postgres-operator-install.md)**
- **[Redis Sentinel](./redis_sentinel.md)**
- **[K8s API Metrics Server](./metrics-server.md)**
- **[K9s](k9s-install.md)**
- **[K8s Observability](./kube-prometheus-stack-install.md)**
- **[Kured](./kured-install.md)**
- **[Kubectl Krew plugin](./krew-install.md)**
- **[Rook Microceph](./rook-microceph-install.md)**
- **[Minio S3 compatible Object Storage](./minio-install.md)**
- **[MetalB and Kong IC](./metalb-kong-install.md)**
- **[MetalB and NGinx (Alt to Kong IC)](./metalb-ingress-install.md)**
- **[Mattermost](./mattermost_install.md)**
