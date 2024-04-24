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
- **[Ingress (Kong or NGinx](./Ingress_choices.md)**
- **[MySQL InnoDB Operator](./mysql-operator-install.md)**
- **[MySQL InnoDB Cluster](./mysql-innodb-cluster-install.md)**
- **[Redis Operator](./redis_operator-install.md)**
- **[Redis Stand Alone](./redis_sentinel.md)**
START HERE
There are several tutorials on deploying a go app to k8s but they are older. Try to follow the tutorials and use the newer golang images from <https://docs.docker.com/language/golang/> and use vscode container tech for dev.
https://thechief.io/c/editorial/whats-the-best-ide-for-kubernetes-users/
- **[Deploy Go app to k8s](https://www.bogotobogo.com/GoLang/GoLang_Web_Building_Docker_Image_and_Deploy_to_Kubernetes.php)**
- **[Deploy Go app to k8s](https://reintech.io/blog/deploying-a-go-application-to-kubernetes)**
- **[Docker Go Test](https://docs.docker.com/language/golang/)**
OLD WAY
IS FOUND IN REPORTING/K8S/REPORTS-CRON AND DOCKERFILES REPORTS-APP AND REPORTS-VOL-INIT
- **[Go client for K8s API](https://medium.com/cloud-native-daily/working-with-kubernetes-using-golang-a3069d51dfd6)**
- **[Create k8s operator in go](https://www.faizanbashir.me/guide-to-create-kubernetes-operator-with-golang)**
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
