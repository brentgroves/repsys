# Redis Operator

## references

<https://operatorhub.io/operator/redis-operator>

<https://github.com/ot-container-kit/redis-operator>

<https://ot-redis-operator.netlify.app/>

## Overview

Redis Operator is a software to set up and manage Redis on Kubernetes.
A Golang based redis operator that will make/oversee Redis standalone/cluster/replication/sentinel mode setup on top of the Kubernetes. It can create a redis cluster setup with best practices on Cloud as well as the Bare-metal environment. Also, it provides an in-built monitoring capability using redis-exporter.

Documentation is available here:- <https://ot-container-kit.github.io/redis-operator/>

The type of Redis setup which is currently supported:

- Redis Cluster
- Redis Standalone
- Redis Replication
- Redis Sentinel

This operator only supports versions of redis =>6.

## Purpose

There are multiple problems that people face while setting up redis setup on Kubernetes, specially cluster type setup. The purpose of creating this opperator is to provide an easy and production ready interface for redis setup that include best-practices, security controls, monitoring, and management.

## Why Redis Operator?

Here the features which are supported by this operator:-

- Redis cluster, replication and standalone mode setup
- Redis cluster and replication failover and recovery
- Inbuilt monitoring with redis exporter
- Password and password-less setup of redis
- TLS support for additional security layer
- Ipv4 and Ipv6 support for redis setup
- Detailed monitoring grafana dashboard

![](https://ot-redis-operator.netlify.app/images/redis-operator-architecture.png)

## Getting Started

If you want to deploy redis-operator from scratch to a local Minikube cluster, begin with the Getting started document. It will guide your through the setup step-by-step.

The configuration of Redis setup should be described in **[CRD](https://github.com/OT-CONTAINER-KIT/redis-operator/blob/master/config/crd/bases)** definitions. All the examples related to redis standalone and cluster setup can be found inside **[example](https://github.com/OT-CONTAINER-KIT/redis-operator/blob/master/example)** folder.

## Quickstart

The setup can be done by using helm. If you want to see more example, please go through the **[example](https://github.com/OT-CONTAINER-KIT/redis-operator/blob/master/example)** folder.

But you can simply use the helm chart for installation.

## Add the helm chart

```bash
$ helm repo add ot-helm https://ot-container-kit.github.io/helm-charts/
# Deploy the redis-operator
$ helm upgrade redis-operator ot-helm/redis-operator --install --namespace ot-operators
After deployment, verify the installation of operator

helm test redis-operator --namespace ot-operators
```

## Installation

Instructions for installation of Redis Operator.
Redis Operator is developed as CRD(Custom Resource Definition) to deploy and manage Redis in standalone/cluster mode. So CRD is an amazing feature of Kubernetes which allows us to create our own resources and APIs in Kubernetes. For further information about CRD, please go through the official documentation.

There are four different Objects available under redis.redis.opstreelabs.in/v1beta1:

- Redis
- Redis Cluster
- Redis Replication
- Redis Sentinel

<https://operatorhub.io/operator/redis-operator>

<https://github.com/ot-container-kit/redis-operator>
