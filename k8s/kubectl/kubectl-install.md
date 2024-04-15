# Install kubectl

## References

<https://microk8s.io/docs/working-with-kubectl>

## Kubectl install

```bash
sudo snap install kubectl  --classic

# generate microk8s config file from any k8s node
ssh brent@reports11
cd ~
mkdir .kube
cd .kube
microk8s config > reports1.yaml
exit
```

## Add the new config file to source control

```bash
# From development system
pushd ~/src/rypsys/k8s/kubectl/all-config-files
lftp brent@reports11
get /home/brent/.kube/reports1.yaml
exit
# add contexts to reports1.yaml
code ~/src/repsys/k8s/kubectl/all-config-files
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
# commit changes to source control
```

## copy all clusters kube config file

```bash
# remove config files from .kube directory
ssh brent@repsys12
rm .kube/*.yaml
exit
# from dev system
cd ~/src/repsys/k8s/kubectl/all-config-files
# upload kube config files to server .config dir
lftp brent@repsys12
:~> cd .kube
:~> mput *.yaml
exit
```
