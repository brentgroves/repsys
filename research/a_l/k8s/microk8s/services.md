# **[configuring microk8s services](https://microk8s.io/docs/configuring-services)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Configuring MicroK8s services

MicroK8s brings up Kubernetes as a number of different services run through systemd. The configuration of these services is read from files stored in the $SNAP_DATA/args directory, which normally points to /var/snap/microk8s/current/args.

To reconfigure a service you will need to edit the corresponding file and then restart MicroK8s. For example, to add debug level logging to containerd:

```bash

cat /var/snap/microk8s/current/args/containerd 
--config ${SNAP_DATA}/args/containerd.toml
--root ${SNAP_COMMON}/var/lib/containerd
--state ${SNAP_COMMON}/run/containerd
--address ${SNAP_COMMON}/run/containerd.sock

echo '-l=debug' | sudo tee -a /var/snap/microk8s/current/args/containerd
microk8s stop
microk8s start

sudo systemctl status snap.microk8s.daemon-kubelite

● snap.microk8s.daemon-kubelite.service - Service for snap application microk8s.daemon-kubelite
     Loaded: loaded (/etc/systemd/system/snap.microk8s.daemon-kubelite.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-08-27 22:40:12 UTC; 23h ago
   Main PID: 2122770 (kubelite)
      Tasks: 12 (limit: 19125)
     Memory: 223.4M
        CPU: 1h 43min 2.909s
     CGroup: /system.slice/snap.microk8s.daemon-kubelite.service
             └─2122770 /snap/microk8s/7040/kubelite --scheduler-args-file=/var/snap/microk8s/7040/args/kube-scheduler --controller-manager-args-file=/var/snap/microk8s/7040/args/kube-controller-manager ->

Aug 28 21:47:52 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:47:52.421564 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:49:22 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:49:22.420030 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:50:28 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:50:28.422347 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:51:54 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:51:54.422005 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:53:19 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:53:19.420928 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:54:39 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:54:39.422314 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:55:57 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:55:57.421760 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:57:20 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:57:20.421902 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 21:58:48 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 21:58:48.421390 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o>
Aug 28 22:00:12 repsys11-c2-n3 microk8s.daemon-kubelite[2122770]: E0828 22:00:12.421016 2122770 dns.go:153] "Nameserver limits exceeded" err="Nameserver limits were exceeded, some nameservers have been o
```

The following systemd services will be run by MicroK8s. Starting with release 1.21, many individual services listed below were consolidated into a single kubelite service.

snap.microk8s.daemon-scheduler
The Kubernetes scheduler is a workload-specific function which takes into account individual and collective resource requirements, quality of service requirements, hardware/software/policy constraints, affinity and anti-affinity specifications, data locality, inter-workload interference, deadlines, and so on. Workload-specific requirements will be exposed through the API as necessary.

Starting with release 1.21, daemon-scheduler was consolidated into daemon-kubelite.

The kube-scheduler daemon started using the arguments in ${SNAP_DATA}/args/kube-scheduler. These are explained fully in the upstream kube-scheduler documentation.

snap.microk8s.daemon-kubelet
The kubelet is the primary “node agent” that runs on each node. The kubelet takes a set of PodSpecs(a YAML or JSON object that describes a pod) that are provided and ensures that the containers described in those PodSpecs are running and healthy. The kubelet doesn’t manage containers which were not
created by Kubernetes.

Starting with release 1.21, daemon-kubelet was consolidated into the daemon-kubelite.

The kubelet daemon is started using the arguments in ${SNAP_DATA}/args/kubelet. These are fully documented in the upstream
kubelet documentation.

snap.microk8s.daemon-kubelite
Used in release 1.21 and later. The kubelite daemon runs as subprocesses the scheduler, controller, proxy, kubelet, and apiserver services. Each of these individual services can be configured using arguments in the matching ${SNAP_DATA}/args/ directory:

scheduler ${SNAP_DATA}/args/kube-scheduler
controller ${SNAP_DATA}/args/kube-controller-manager
proxy ${SNAP_DATA}/args/kube-proxy
kubelet ${SNAP_DATA}/args/kubelet
apiserver ${SNAP_DATA}/args/kube-apiserver
snap.microk8s.daemon-containerd
Containerd is the container runtime used by MicroK8s to manage images and execute containers.

The containerd daemon started using the configuration in
${SNAP_DATA}/args/containerd and ${SNAP_DATA}/args/containerd-
