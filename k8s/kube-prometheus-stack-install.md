# Kube-prometheus-stack

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## References

<https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack>
<https://spacelift.io/blog/prometheus-kubernetes>
<https://github.com/digitalocean/Kubernetes-Starter-Kit-Developers/blob/main/04-setup-observability/prometheus-stack.md>
<https://medium.com/israeli-tech-radar/how-to-create-a-monitoring-stack-using-kube-prometheus-stack-part-1-eff8bf7ba9a9>
<https://gitlab.tikalk.dev/matan.amiel/kube-prometheus-stack/-/tree/main>

<https://grafana.com/docs/grafana/latest/setup-grafana/installation/kubernetes/>
<https://stackoverflow.com/questions/67373856/unable-to-access-prometheus-dashboard-port-forwarding-doesnt-work>
<https://grafana.com/docs/grafana/latest/setup-grafana/sign-in-to-grafana/#:~:text=To%20sign%20in%20to%20Grafana%20for%20the%20first%20time%2C%20follow,admin%20for%20username%20and%20password>.
<https://docs.syseleven.de/metakube-accelerator/building-blocks/observability-monitoring/kube-prometheus-stack>
<https://code.syseleven.de/syseleven/building-blocks/helmfiles/kube-prometheus-stack>

## Active Kube-prometheus-stack

Installs the **[kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)**, a collection of Kubernetes manifests, Grafana dashboards, and **[Prometheus rules]** combined with documentation and scripts to provide easy to operate end-to-end Kubernetes cluster monitoring with **[Prometheus](https://prometheus.io/)** using the **[prometheus operator](https://github.com/prometheus-operator/kube-prometheus)**.

See the **[kube-prometheus](https://github.com/prometheus-operator/kube-prometheus)** README for details about components, dashboards, and alerts.

Note: This chart was formerly named prometheus-operator chart, now renamed to more clearly reflect that it installs the kube-prometheus project stack, within which Prometheus Operator is only one component.

## Prerequisites

Kubernetes 1.19+
Helm 3+

## Uninstall Helm Chart

```bash
# helm uninstall [RELEASE_NAME]
helm uninstall kube-prometheus-stack -n monitoring

```

This removes all the Kubernetes components associated with the chart and deletes the release.

See helm uninstall for command documentation.

CRDs created by this chart are not removed by default and should be manually cleaned up:

```bash
kubectl delete crd alertmanagerconfigs.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd probes.monitoring.coreos.com
kubectl delete crd prometheusagents.monitoring.coreos.com
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd scrapeconfigs.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd thanosrulers.monitoring.coreos.com
```

## Add Helm Repository

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

## Install Helm Chart

```bash

pushd
cd ~/src/repsys/k8s/
kubectl create ns monitoring 
helm install prom-stack prometheus-community/kube-prometheus-stack -n monitoring
NAME: prom-stack
LAST DEPLOYED: Wed Nov 29 16:34:44 2023
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
NOTES:
kube-prometheus-stack has been installed. Check its status by running:
  kubectl --namespace monitoring get pods -l "release=prom-stack"

Visit https://github.com/prometheus-operator/kube-prometheus for instructions on how to create & configure Alertmanager and Prometheus instances using the Operator.

kubectl get all -n monitoring
kubectl get secret --namespace monitoring prom-stack-grafana -o jsonpath='{.data.admin-password}' | base64 -d 
popd
```

After we deploy the Kube-Prometheus stack, we get as default apps:

- Grafana
- Prometheus
- Alert Manager.

## You’ll have to look at the Prometheus and Grafana dashboard

**![Prometheus dashboard](https://miro.medium.com/v2/resize:fit:720/format:webp/1*wyHyaosqq0aQO11ECxy9QQ.png)**

```bash
kubectl port-forward svc/prom-test-grafana 3000:80 
admin/
kubectl port-forward svc/kube-prometheus-stack-grafana 3000:3000 -n monitoring

## Testing

```bash
kubectl port-forward svc/prometheus-operated 9090:9090 -n monitoring
Verify the application is working by running these commands:
curl http://127.0.0.1:9090

kubectl port-forward service/prom-stack-grafana 3000:80 -n monitoring
# get password
kubectl get secret --namespace monitoring prom-stack-grafana -o jsonpath='{.data.admin-password}' | base64 -d 

curl http://127.0.0.1:3000
admin/prom-operator

# look at all the node dashboard


```
