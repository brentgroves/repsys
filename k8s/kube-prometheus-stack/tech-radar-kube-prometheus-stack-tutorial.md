# Kube-prometheus stack

## References

https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack
<https://spacelift.io/blog/prometheus-kubernetes>
<https://github.com/digitalocean/Kubernetes-Starter-Kit-Developers/blob/main/04-setup-observability/prometheus-stack.md>
<https://medium.com/israeli-tech-radar/how-to-create-a-monitoring-stack-using-kube-prometheus-stack-part-1-eff8bf7ba9a9>
<https://gitlab.tikalk.dev/matan.amiel/kube-prometheus-stack/-/tree/main>

<https://grafana.com/docs/grafana/latest/setup-grafana/installation/kubernetes/>
<https://stackoverflow.com/questions/67373856/unable-to-access-prometheus-dashboard-port-forwarding-doesnt-work>
<https://grafana.com/docs/grafana/latest/setup-grafana/sign-in-to-grafana/#:~:text=To%20sign%20in%20to%20Grafana%20for%20the%20first%20time%2C%20follow,admin%20for%20username%20and%20password>.
<https://docs.syseleven.de/metakube-accelerator/building-blocks/observability-monitoring/kube-prometheus-stack>
https://code.syseleven.de/syseleven/building-blocks/helmfiles/kube-prometheus-stack

## Uninstall Helm Chart

microk8s helm uninstall kube-prometheus-stack -n monitoring
microk8s helm uninstall loki

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
    ruleSelectorNilUsesHelmValues: false
    podMonitorSelectorNilUsesHelmValues: false
    probeSelectorNilUsesHelmValues: false
    scrapeConfigSelectorNilUsesHelmValues: false
```

Please use these **[values](https://gitlab.tikalk.dev/matan.amiel/kube-prometheus-stack/-/blob/main/values.yaml)**

- Run the Helm Deployment Command.

```bash

pushd
cd ~/src/repsys/k8s/kube-prometheus-stack
microk8s helm install prom-test prometheus-community/kube-prometheus-stack
microk8s helm upgrade --install -f values.yaml kube-prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring
Release "kube-prometheus-stack" does not exist. Installing it now.
NAME: kube-prometheus-stack
LAST DEPLOYED: Fri Nov 17 22:09:18 2023
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
NOTES:
kube-prometheus-stack has been installed. Check its status by running:
  kubectl --namespace monitoring get pods -l "release=kube-prometheus-stack"
kubectl get all -n monitoring
Visit https://github.com/prometheus-operator/kube-prometheus for instructions on how to create & configure Alertmanager and Prometheus instances using the Operator.

kubectl get all -n monitoring
popd
```

After we deploy the Kube-Prometheus stack, we get as default apps:

- Grafana
- Prometheus
- Alert Manager.

## Testing

```bash
kubectl port-forward svc/prometheus-operated 9090:9090 -n monitoring
Verify the application is working by running these commands:
* kubectl --namespace monitoring port-forward daemonset/promtail 3101
* curl http://127.0.0.1:3101/metrics

```

You’ll have to look at the Prometheus and Grafana dashboard.

**![Prometheus dashboard](https://miro.medium.com/v2/resize:fit:720/format:webp/1*wyHyaosqq0aQO11ECxy9QQ.png)**

```bash
kubectl port-forward svc/prom-test-grafana 3000:80 
admin/
kubectl port-forward svc/kube-prometheus-stack-grafana 3000:3000 -n monitoring

kubectl  get services --all-namespaces
NAMESPACE        NAME                                             TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                                    AGE
monitoring       kube-prometheus-stack-grafana                    ClusterIP      10.152.183.181   <none>        80/TCP                                                                     14m
monitoring       kube-prometheus-stack-prometheus                 ClusterIP      10.152.183.131   <none>        9090/TCP,8080/TCP                                                          14m
monitoring       alertmanager-operated                            ClusterIP      None             <none>        9093/TCP,9094/TCP,9094/UDP                                                 14m

```

## Create a self ServiceMonitor

- The ServiceMonitor defines an application that scrapes metrics from Kubernetes.

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: prometheus-self
  labels:
    app: kube-prometheus-stack-prometheus
spec:
  endpoints:
  - interval: 30s
    port: web
  selector:
    matchLabels:
      app: kube-prometheus-stack-prometheus
```

- Run ServiceMonitor manifest in this command:

```bash
kubectl get all -l app=kube-prometheus-stack-prometheus
kubectl apply -f service-monitor.yaml -n monitoring

```

## Integration of Promtail and Loki to Grafana

### Intro to Loki

Loki uses Promtail as its primary log collector, but it can also accept log flows from other sources, such as Syslog or other log senders.
It offers high uptime and supports data replication across multiple replicas for durability and fault tolerance. Loki is tightly integrated with Grafana, allowing you to visualize log metrics.

```bash
# Add a new Helm Repository
microk8s helm repo add grafana https://grafana.github.io/helm-charts
"grafana" has been added to your repositories
helm repo update
```

## Run the Helm Deployment Command

<https://github.com/grafana/helm-charts/tree/main/charts/loki-distributed>
helm repo add grafana <https://grafana.github.io/helm-charts>

```bash
pushd
cd ~/src/repsys/k8s/kube-prometheus-stack
microk8s helm upgrade --install -f loki-distributed.yaml loki grafana/loki-distributed -n monitoring

coalesce.go:223: warning: destination for loki-distributed.compactor.affinity is a table. Ignoring non-table value (podAntiAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - labelSelector:
        matchLabels:
          {{- include "loki.compactorSelectorLabels" . | nindent 10 }}
      topologyKey: kubernetes.io/hostname
  preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 100
      podAffinityTerm:
        labelSelector:
          matchLabels:
            {{- include "loki.compactorSelectorLabels" . | nindent 12 }}
        topologyKey: failure-domain.beta.kubernetes.io/zone
)
popd
```

After we deploy Loki, we need to update the Kube-Prometheus-stack values file to add additional Data Sources.

This configuration defines a default additional data source that connects to a Loki log aggregation system. It specifies the URL for accessing Loki and sets the access method to the proxy.

```bash
```

microk8s helm upgrade loki-distributed --install -f values.yaml --set loki.structuredConfig.storage_config.aws.bucketnames=my-loki-bucket
