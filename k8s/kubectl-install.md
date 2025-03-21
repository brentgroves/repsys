# **[Install kubectl](https://microk8s.io/docs/working-with-kubectl)**

**[Current Status](../a_status/current_status.md)**\
**[Back to Menu](./menu.md)**

Issue: Access to port 16443 is blocked if you go through the Fortigate proxy. Must generate a config request for remote computers needing access.

Fix: Anything from vlan 40 to 50 doesn’t go through the firewall at all it just gets routed directly. turn off the 220 address because if this is the source address the frame will go through the firewall.

- microk8s on multipass vm generates a config file with a local network ip such as: <https://10.97.219.76:16443>.
- this address is reachable from k8sgw2 which is the host running the VM.
- but if you change the ip to <https://10.188.50.214:16443> you get an error and the vm is suspended.

```bash
kubectl get all 
E0320 18:11:12.623408  113886 memcache.go:265] "Unhandled Error" err=" couldn't get current server API group list: Get \"https://10.188.50.214:16443/api?timeout=32s\": dial tcp 10.188.50.214:16443: i/o timeout"
```

- Justin says fortigate proxy will not allow access to port 16443 unless a rule is added.

1. try again from 10.188.50.202 with the original config server ip of 10.97.219.76. This works.
2. try again from 10.188.50.202 when you change the config server ip to 10.188.50.214. That works.
3. Please add rule for
access port 16443: source: 10.187.40.123, destination: 10.188.50.214

Anything from vlan 40 to 50 doesn’t go through the firewall at all it just gets routed directly so you dont need to add a firewall rule.

```bash
ssh ubuntu@10.188.50.214
```

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
microk8s config > k8sn211.yaml
nvim k8sn211.yaml

```

## test with scc

```bash
scc.sh k8sn211.yaml microk8s
kubectl get all
```

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
