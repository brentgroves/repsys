# reports3 deployment notes

This cluster has been used in 2023 to run the TB.  It was working well until March 2024 when the TLS certificates expired and the Mayastor pvs became unusable.  In fact no deployments seemed to work.

## March 2024 rebuild

This cluster is going to use Mayastor as the default storage class. A MySQL 8.0 server will be installed since the MySQL dw can not be run from the MySQL InnoDB cluster since its tables do not all contain a primary key.  It is my intention to recreate the current MySQL dw in the MySQL InnoDB cluster but this could take some time.

- installed MicroK8s from channel 1.28/stable, version installed was 1.28.7
- enabled host path storage
- Install MySQL 8.0 server stateful set on reports31 and used /mnt/data localstorage and mysql-storageclass with a pv nodeAffinity of reports31.
- enabled Mayastor storage and set size to 40GB.
- Installed a 1 instance MySQL InnoDB cluster using its operator to local storage.
- Modified the NGinx Ingress Controller to route traffic to the MySql InnoDB cluster router.
