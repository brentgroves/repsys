# Install kubectl

Note: our dotfiles has an alias to microk8s kubectl set to kc so you can use this locallly.

sudo snap install kubectl  --classic

<https://microk8s.io/docs/working-with-kubectl>
If you’d prefer to use your host’s kubectl command, running the following command will output the kubeconfig file from MicroK8s.

## generate microk8s config

ssh brent@reports51
cd ~
mkdir .kube
cd .kube
microk8s config > reports5.yaml
exit
From development system
cd ~/.kube
lfpt brent@reports51
get /home/brent/.kube/reports5.yaml

## add contexts to reports5.yaml

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

## test with scc

scc.sh reports5.yaml microk8s
kubectl get all

## add to source control

### github

cd ~/src/linux-utils/kubectl/all-config-files
cp ~/.kube/reports5.yaml .
checkin changes

### dev ops

```bash
cd ~/src
git clone git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/kube

cd ~/src/linux-utils/kubectl/all-config-files
cp reports5.yaml ~/src/kube/
checkin changes

```

## copy kubeconfig files for all clusters

```bash
ssh brent@reports5
pushd ~/src/linux-utils/kubectl/all-config-files
git pull
mkdir -p ~/.kube
cp ./*.yaml ~/.kube/
cd ..
cp ./scc.sh ~/.kube/
sudo cp ./scc.sh /usr/local/bin
cd ~/src
git clone <git@ssh.dev.azure.com>:v3/MobexGlobal/MobexCloudPlatform/kube
cd kube
cp* ~/.kube
```

## test config with scc

```bash
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
