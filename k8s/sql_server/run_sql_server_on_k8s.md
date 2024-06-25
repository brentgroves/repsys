# **[Considerations for Running SQL Server on Kubernetes](https://www.mssqltips.com/sqlservertip/6775/run-sql-server-on-kubernetes/)**

## How does Kubernetes work?

Kubernetes is mainly an orchestration tool. You might say you have hundreds of containers running applications and databases. Kubernetes offers a highly scalable, reliable control plane to run these containers. Many SQL Server container images have been published and made public some years back. One very popular container repository is the Docker hub site.

## Key Benefits of Running SQL Server in Containers

Here is a great tip that explains the containers for SQL Servers on Windows and Linux. One of the key benefits of having images of SQL Servers on containers is that you skip the installation and configuration part. Basically, you have an image of your database server and its run and availability is orchestrated by the Kubernetes Cluster.
