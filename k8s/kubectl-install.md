# **[Install kubectl](https://microk8s.io/docs/working-with-kubectl)**

**[Report System Install](./report-system-install.md)**\
**[Ubuntu 22.04 Desktop](../linux/ubuntu22-04/desktop-install.md)**\
**[Ubuntu 22.04 Server](../linux/ubuntu22-04/server-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

Note: our dotfiles has an alias to microk8s kubectl set to kc so you can use this locallly.

```bash
sudo snap install kubectl  --classic
```

## generate microk8s config

```bash
ssh brent@repsys11
cd ~
mkdir .kube
cd .kube
microk8s config > repsys11_home.yaml
nvim rephub1.yaml
```

## add contexts to reports3.yaml

```yaml
- context:
    cluster: microk8s-cluster
    namespace: mayastor
    user: admin
  name: mayastor
- context:
    cluster: microk8s-cluster
    namespace: mysql
    user: admin
  name: mysql
- context:
    cluster: microk8s-cluster
    namespace: mongo
    user: admin
  name: mongo
- context:
    cluster: microk8s-cluster
    namespace: mosquitto
    user: admin
  name: mosquitto
- context:
    cluster: microk8s-cluster
    namespace: test
    user: admin
  name: test
```

## test with scc

scc.sh rephub1_home.yaml microk8s
kubectl get all

## add to source control

### github

```bash
# From development system
cd ~/src/k8s/all-config-files
rm repsys11_home.yaml
# From K8s node get new config file
lftp brent@repsys11
get /home/brent/.kube/repsys11_home.yaml
exit
# Remove previous config files from nodes and hosts
ssh brent@repsys11
rm ~/.kube/*.yaml
exit
# Deploy all config files to other nodes and hosts
lftp brent@repsys11
cd .kube
mput *.yaml

# Optional commit changes to dev ops repo

```bash
cd ~/src
git clone git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/kube

cd ~/src/repsys/k8s/kubectl/all-config-files
cp reports3.yaml ~/src/kube/
checkin changes

```

## copy kubeconfig files to all clusters

```bash
ssh brent@reports5
~/startday.sh
pushd ~/src/k8s/all-config-files
mkdir -p ~/.kube
rm ~/.kube/*.yaml
cp ./*.yaml ~/.kube/
cd ..
# scc.sh is also in the ~/src/repsys/shell_scripts dir but it does not change much
cp ./scc.sh ~/

# optional location of config files
cd ~/src
git clone <git@ssh.dev.azure.com>:v3/MobexGlobal/MobexCloudPlatform/kube
cd kube
cp* ~/.kube
```

## test config with scc

```bash
scc.sh repsys11_home.yaml microk8s

scc.sh reports3.yaml mayastor
scc.sh reports3.yaml microk8s
scc.sh reports-aks-mobex.yaml reports-aks-mobex

kubectl get all

```

## manual way

```bash
kubectl config current-context

kubectl config set-context \
mysql-context \
--namespace=mysql-namespace \
--cluster=microk8s-cluster \
--user=dev-user
```
