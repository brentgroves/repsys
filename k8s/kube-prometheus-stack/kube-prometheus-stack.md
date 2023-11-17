# Kube-prometheus stack

## References

<https://medium.com/israeli-tech-radar/how-to-create-a-monitoring-stack-using-kube-prometheus-stack-part-1-eff8bf7ba9a9>

## Introduction

In this article, we will teach about creating a monitoring stack using Grafana, Prometheus, AlertManager, and integration with Promtail and Loki.

## How does the story begin?

By way of introduction, I’m a DevOps engineer at Tikal Knowledge.
My story started when one of Tikal’s customers needed a monitoring solution. So I did some research and discovered that there are so many ways to implement a simple log display.

First, I tested a few options. Each of these options is complicated.
Maybe there isn’t an easy thing…

## Prerequisites

- Knowledge of Kubernetes
- K3d-cluster or any Kubernetes provider
- helm

## Goals & Objectives

Obtain logs and create an easy monitor with Grafana and Prometheus.

## Where did these challenges begin?

This began when I saw a lot of configurations and values that needed to be defined. Until I found the Kube-Prometheus-stack and tried this way
YES! It works great, more than anticipated, and is easy to install.

**![Prometheus-Grafana](https://miro.medium.com/v2/resize:fit:720/format:webp/1*EPHj4qLIyooRFebYERN3dA.png)**

## Intro to Kube-Prometheus-stack

Kube-Prometheus-stack, also as Prometheus Operator, is a popular open-source project providing complete monitoring and alerting solutions for Kubernetes clusters. It combines tools and components to create a monitoring stack for Kubernetes environments.

Will use the official Helm Chart Kube-Prometheus-stack,
with a customized value file.

To deploy the monitoring stack, follow these steps:

- Creating Namespace called monitoring

```bash
kubectl create ns monitoring
```

- Add a new Helm Repository

```bash
microk8s helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
"prometheus-community" has been added to your repositories

microk8s helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "prometheus-community" chart repository
Update Complete. ⎈Happy Helming!⎈

```

## Edit the Values

- These settings indicate that the selectors mentioned
(rule, service monitor, pod monitor, and scrape config) will have independent configurations and will not be based on Helm graphic values.

```block
    ruleSelectorNilUsesHelmValues: false
    serviceMonitorSelectorNilUsesHelmValues: false
    podMonitorSelectorNilUsesHelmValues: false
    probeSelectorNilUsesHelmValues: false
    scrapeConfigSelectorNilUsesHelmValues: false
```

Please use these **[values](https://gitlab.tikalk.dev/matan.amiel/kube-prometheus-stack/-/blob/main/values.yaml)**

- Run the Helm Deployment Command.

```bash

pushd
cd /home/brent/src/repsys/k8s/kube-prometheus-stack
microk8s helm upgrade --install -f values.yaml kube-prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring
popd
```
