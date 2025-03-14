# Microk8s Linamar install try 3

## references

- **[Installing MicroK8s Offline or in an airgapped environment](https://microk8s.io/docs/install-offline)**

## Try 3

- Used r620_201 server
- setup r620_201_basic.yaml network
- remove microk8s
- reboot
- Added firewall rules
- installed microk8s successfull
  - microk8s inspect showed no issues
  - microk8s status showed not running
  - kubectl pods did not start in kubesystem ns did not check others.
- removed microk8s
- Added firewall rules
  - AWS Calico container registries
    - prod-registry-k8s-io-us-east-2.s3.dualstack.us-east-2.amazonaws.com
    - *amazonaws.com
    - us-central1-docker.pkg.dev
    - *pkg.dev

- microk8s start
- microk8s status shows not running
- purged microk8s and rebooted.
- rebooted machine
- installed microk8s

```bash
sudo snap install microk8s --classic --channel=1.32/stable
[sudo] password for brent: 
microk8s (1.32/stable) v1.32.2 from Canonical✓ installed
microk8s inspect
Inspecting system
Inspecting Certificates
Inspecting services
  Service snap.microk8s.daemon-cluster-agent is running
  Service snap.microk8s.daemon-containerd is running
  Service snap.microk8s.daemon-kubelite is running
  Service snap.microk8s.daemon-k8s-dqlite is running
  Service snap.microk8s.daemon-apiserver-kicker is running
  Copy service arguments to the final report tarball
Inspecting AppArmor configuration
Gathering system information
  Copy processes list to the final report tarball
  Copy disk usage information to the final report tarball
  Copy memory usage information to the final report tarball
  Copy server uptime to the final report tarball
  Copy openSSL information to the final report tarball
  Copy snap list to the final report tarball
  Copy VM name (or none) to the final report tarball
  Copy current linux distribution to the final report tarball
  Copy asnycio usage and limits to the final report tarball
  Copy inotify max_user_instances and max_user_watches to the final report tarball
  Copy network configuration to the final report tarball
Inspecting kubernetes cluster
  Inspect kubernetes cluster
Inspecting dqlite
  Inspect dqlite
cp: cannot stat '/var/snap/microk8s/7731/var/kubernetes/backend/localnode.yaml': No such file or directory

Building the report tarball
  Report tarball is at /var/snap/microk8s/7731/inspection-report-20250314_212615.tar.gz
```

- check status

```bash

microk8s kubectl get ns
NAME              STATUS   AGE
default           Active   3m
kube-node-lease   Active   3m
kube-public       Active   3m
kube-system       Active   3m

microk8s kubectl get all
NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.152.183.1   <none>        443/TCP   3m28s

microk8s kubectl get all -n kube-system
NAME                                           READY   STATUS    RESTARTS   AGE
pod/calico-kube-controllers-5947598c79-kdspq   1/1     Running   0          2m4s
pod/calico-node-t82dn                          1/1     Running   0          2m4s
pod/coredns-79b94494c7-twdrh                   1/1     Running   0          2m4s

NAME               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                  AGE
service/kube-dns   ClusterIP   10.152.183.10   <none>        53/UDP,53/TCP,9153/TCP   2m9s

NAME                         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/calico-node   1         1         1       1            1           kubernetes.io/os=linux   2m10s

NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/calico-kube-controllers   1/1     1            1           2m10s
deployment.apps/coredns                   1/1     1            1           2m9s

NAME                                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/calico-kube-controllers-5947598c79   1         1         1       2m4s
replicaset.apps/coredns-79b94494c7                   1         1         1       2m4s

microk8s status
microk8s is running
high-availability: no
  datastore master nodes: 127.0.0.1:19001
  datastore standby nodes: none
addons:
  enabled:
    dns                  # (core) CoreDNS
    ha-cluster           # (core) Configure high availability on the current node
    helm                 # (core) Helm - the package manager for Kubernetes
    helm3                # (core) Helm 3 - the package manager for Kubernetes
  disabled:
    cert-manager         # (core) Cloud native certificate management
    cis-hardening        # (core) Apply CIS K8s hardening
    community            # (core) The community addons repository
    dashboard            # (core) The Kubernetes dashboard
    gpu                  # (core) Alias to nvidia add-on
    host-access          # (core) Allow Pods connecting to Host services smoothly
    hostpath-storage     # (core) Storage class; allocates storage from host directory
    ingress              # (core) Ingress controller for external access
    kube-ovn             # (core) An advanced network fabric for Kubernetes
    mayastor             # (core) OpenEBS MayaStor
    metallb              # (core) Loadbalancer for your Kubernetes cluster
    metrics-server       # (core) K8s Metrics Server for API access to service metrics
    minio                # (core) MinIO object storage
    nvidia               # (core) NVIDIA hardware (GPU and network) support
    observability        # (core) A lightweight observability stack for logs, traces and metrics
    prometheus           # (core) Prometheus operator for monitoring and logging
    rbac                 # (core) Role-Based Access Control for authorisation
    registry             # (core) Private image registry exposed on localhost:32000
    rook-ceph            # (core) Distributed Ceph storage using Rook
    storage              # (core) Alias to hostpath-storage add-on, deprecated
  ```

- core images required to bring up MicroK8s

  ```bash
  docker.io/calico/cni:v3.28.1
  docker.io/calico/kube-controllers:v3.28.1
  docker.io/calico/node:v3.28.1
  docker.io/cdkbot/hostpath-provisioner:1.5.0
  docker.io/coredns/coredns:1.12.0
  docker.io/library/busybox:1.28.4
  registry.k8s.io/ingress-nginx/controller:v1.12.0
  registry.k8s.io/metrics-server/metrics-server:v0.7.2
  registry.k8s.io/pause:3.10
  ```
