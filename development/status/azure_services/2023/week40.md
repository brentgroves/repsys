# Report System

An in-house report system deployed running on a local Kubernetes Cluster.

## Why

- Live data not data from a Plex snapshot
- Unlimited compute time allowing more complex reports
- Reporting from a central Data Warehouse that collects data from any data source including other Linamar ERP systems.
- Report repository allowing storage and retrieval of old reports and the making of new comparitive reports.

The Report System Schedule:

- Work on the "report runner" as described below.
- Work on the "report SPA"
- Ask IT to create a K8s cluster and deploy reporting system over several weeks.
  - Download Ubuntu 22.04 server
  - Create 4 Ubuntu server VM
  - Install MicroK8s Kubernetes Cluster
  - Install AWS developed EBS dynamic storage, Mayastor.
  - Deploy MySQL
  - Deploy the report runner.
  - Deploy the report API.
  - Deploy the report SPA.
  
## IT k8s Administrator

Brendan is excited about helping to look after the reporting K8s cluster.

- Gave Brendan permisions to: devcon2, Azure Dev Ops project, and the reports5 k8s cluster.
  - sudo priviledges
  - Add Brendan's ed25519 public key to all reports5 nodes user's authorized_keys file using ssh-copy-id command.
  - Add Brendan's RSA public key to Azure Dev Ops Mobex Global Project.
  - Add to microk8s group. verify with:

```bash
        rdp devcon2 at 10.1.0.120
        open terminal
        ssh bcieslik@reports51
        microk8s status
        microk8s is running
        high-availability: yes
        datastore master nodes: 172.20.88.66:19001 172.20.88.67:19001 172.20.88.68:19001
        datastore standby nodes: 172.20.88.65:19001

```

Notes: The nodes are linked by static IP addresses so If there VMs are moved to a different hypervisor the IP addresses must stay the same.

- to monitor the reporting system.
- train himself on k8s
