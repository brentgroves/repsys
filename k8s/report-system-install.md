# Observable Report System on our K8s Private Cloud

- **[Azure Setup](../../azure/mobexglobal.com/azure_setup.md)**
- **[Ubuntu 22.04 Server Install](./linux/ubuntu22-04/server-install.md)**
- **[MicroK8s](./microk8s_1.28_install.md)**
- **[Kubectl](./kubectl-install.md)**
- **[Helm](./helm-install.md)**
- **[Enable host path storage](./host_path_storage/host_path_storage.md)**
- **[Don't Enable Mayastor because of issues with InnoDB](./mayastor-install-2.0.0.md)**
- **[Deploy K8s db_credentials secret](./db_credentials/db_credentials.md)**
- **[MySQL 8.0 server via stateful set](./mysql-8.0-statefulset-install.md)**

Note: The router has problems.  It can't survive a scheduled reboot. Until this can be resolved use the statefulset deployment.
- **[MySQL InnoDB Operator](./mysql-operator-install.md)**
- **[MySQL InnoDB Cluster](./mysql-innodb-cluster-install.md)**
- **[Ingress Choices](./Ingress_choices.md)**

- **[K8s API Metrics Server](./metrics-server.md)**
- **[K9s](k9s-install.md)**
- **[Observability](./kube-prometheus-stack-install.md)**
- **[Kured](./kured-install.md)**
- **[Kubectl Krew plugin](./krew-install.md)**
- **[Rook Microceph](./rook-microceph-install.md)**
- **[Minio S3 compatible Object Storage](./minio-install.md)**

## Notes

Deploy the MySQL 8.0 server and import mydw.  Later recreate mydw in the MySQL InnoDB Cluster. You should make a copy of each table and give it a primary key then copy the mydw non-keyed data into it.

- **[Postgres Operator](./postgres-operator-install.md)**
- **[MetalB load balancer and NGINX ingress controller](./metalb-ingress-install.md)**
- **[MetalB load balancer and Kong ingress controller](./metalb-kong-install.md)**
- **[Redis Operator](./redis_operator-install.md)**
- **[What is Vault](../linux/vault/what_is_vault.md)**
