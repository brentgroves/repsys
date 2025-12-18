# **[Considerations for Running SQL Server on Kubernetes](https://www.mssqltips.com/sqlservertip/6775/run-sql-server-on-kubernetes/)**

## references

<https://www.mssqltips.com/sqlservertip/5607/docker-container-names-internals-and-configuring-storage-for-sql-server-part-4/>

## How does Kubernetes work?

Kubernetes is mainly an orchestration tool. You might say you have hundreds of containers running applications and databases. Kubernetes offers a highly scalable, reliable control plane to run these containers. Many SQL Server container images have been published and made public some years back. One very popular container repository is the Docker hub site.

## Key Benefits of Running SQL Server in Containers

Here is a **[great tip that explains the containers for SQL Servers](https://www.mssqltips.com/sqlservertip/5907/getting-started-with-windows-containers-for-sql-server--part-1/)** on Windows and Linux. One of the key benefits of having images of SQL Servers on containers is that you skip the installation and configuration part. Basically, you have an image of your database server and its run and availability is orchestrated by the Kubernetes Cluster.

Inside the Kubernetes Cluster, there is a control plane that manages and orchestrates the nodes, which in turn is running the pods. Pods are where your SQL Server container is running and your data and logs are sitting on persistent volumes under the hood.

Ideally, when considering if running SQL Servers in Kubernetes is appropriate for your use case, make sure to test and deploy with a POC or staging environment. Make sure to understand the gears that are running behind the scenes. Understand what happens when the pods, where your SQL container is, die, the data loss acceptable and storage configurations. Here is a good link on **[SQL internals for containers](https://www.mssqltips.com/sqlservertip/5607/docker-container-names-internals-and-configuring-storage-for-sql-server--part-4/)**.
