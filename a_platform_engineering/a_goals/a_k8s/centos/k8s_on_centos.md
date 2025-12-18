# **[Deploying a Kubernetes Cluster on CentOS](https://hackernoon.com/how-to-deploy-kubernetes-cluster-on-centos)**

**[Back to Research List](../../research/research_list.md)**\
**[Back to Current Status](../../development/status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

This article outlines a comprehensive procedure for deploying a Kubernetes cluster on CentOS, focusing on installing container runtime, configuring Kubernetes, creating the cluster, and connecting worker nodes. Kubernetes is an open-source system for automating the deployment, scaling, and management of containerized applications. The deployment process involves setting up necessary prerequisites, installing and configuring software components, and ensuring proper network and system settings for seamless operation.

Kubernetes is a powerful orchestration tool for managing containerized applications across a cluster of nodes, providing high availability and scalability. This article presents a step-by-step guide to deploying a Kubernetes cluster on CentOS, detailing the installation of the container runtime (Containerd), configuring Kubernetes components, and establishing the cluster network.

Prerequisites:

- At least 2 CentOS servers (in this example we will use 3 servers: 1 master node and 2 worker nodes).
- User with sudo or root privileges on each server.
