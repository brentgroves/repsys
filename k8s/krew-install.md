# Install Kubectl Krew plugin

## references

<https://min.io/docs/minio/kubernetes/upstream/reference/kubectl-minio-plugin.html>

<https://min.io/docs/minio/kubernetes/upstream/reference/kubectl-minio-plugin/kubectl-minio-init.html>

<https://krew.sigs.k8s.io/docs/user-guide/setup/install/>

## Remove

See **[users guide](https://krew.sigs.k8s.io/docs/user-guide/setup/install/)**

## Run Krew install script

Run this command to download and install krew:

```bash
pushd ~/src/reports/k8s/krew
./krew-install.sh
```

Run kubectl krew to check the installation.

```bash
kubectl krew
```

Make sure to add it to your path

```bash
export PATH="${PATH}:${HOME}/.krew/bin"
```
