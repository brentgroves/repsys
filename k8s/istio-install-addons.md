# **[Getting Started Istio](https://istio.io/latest/docs/setup/getting-started/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

This guide lets you quickly evaluate Istio. If you are already familiar with Istio or interested in installing other configuration profiles or advanced deployment models, refer to our which Istio installation method should I use? FAQ page.

## references

- **[microk8s istio](https://gist.github.com/Realiserad/391855c4a0fb0072994e5ad2a53d65c0)**

## **[Cleanup](./istio-cleanup.md)**

## Install Istio

1. Go to the Istio release page to download the installation file for your OS, or download and extract the latest release automatically (Linux or macOS):

```bash
pushd .
cd ~/Downloads
curl -L https://istio.io/downloadIstio | sh -
# Downloading istio-1.23.0 from https://github.com/istio/istio/releases/download/1.23.0/istio-1.23.0-linux-amd64.tar.gz ...

# Istio 1.23.0 Download Complete!

# Istio has been successfully downloaded into the istio-1.23.0 folder on your system.
```

## Step 2

Move to the Istio package directory. For example, if the package is istio-1.23.0:

```bash
# remove old version
sudo rm /usr/local/bin/istioctl
sudo cp istio-1.23.2/bin/istioctl /usr/local/bin/

```

The installation directory contains:

- Sample applications in samples/
- The istioctl client binary in the bin/ directory.

```bash
ls ~/Downloads/istio-1.23.2                   
bin  LICENSE  manifests  manifest.yaml  README.md  samples  tools
```

## View the dashboard

Istio integrates with **[several different telemetry applications](https://istio.io/latest/docs/ops/integrations/)**. These can help you gain an understanding of the structure of your service mesh, display the topology of the mesh, and analyze the health of your mesh.

Use the following instructions to deploy the **[Kiali dashboard](https://istio.io/latest/docs/ops/integrations/kiali/)**, along with **[Prometheus](https://istio.io/latest/docs/ops/integrations/prometheus/)**, **[Grafana](https://istio.io/latest/docs/ops/integrations/grafana/)**, and **[Jaeger](https://istio.io/latest/docs/ops/integrations/jaeger/)**.

### 1. Install Kiali and the other addons and wait for them to be deployed

```bash
pushd .
cd ~/Downloads/istio-1.23.0
kubectl apply -f samples/addons
kubectl rollout status deployment/kiali -n istio-system
Waiting for deployment "kiali" rollout to finish: 0 of 1 updated replicas are available...
deployment "kiali" successfully rolled out
```

### 2. Access the Kiali dashboard

```bash
istioctl dashboard kiali
```

### 3. select Graph

In the left navigation menu, select Graph and in the Namespace drop down, select default

To see trace data, you must send requests to your service. The number of requests depends on Istio’s sampling rate and can be configured using the Telemetry API. With the default sampling rate of 1%, you need to send at least 100 requests before the first trace is visible. To send 100 requests to the productpage service, use the following command:

```bash
pushd .
cd ~/src/repsys/k8s/istio/

export GATEWAY_URL=10.1.0.144
# http://10.1.0.144/productpage
# before pressing enter remove \ after productpage";
cat <<EOF > ./test.sh 
#!/bin/bash
for i in {1..100}
do
   curl -s -o /dev/null "http://$GATEWAY_URL/productpage";
done
EOF
chmod 777 test.sh 
./test.sh
```
