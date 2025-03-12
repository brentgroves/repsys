# **[Issue installing microk8s on network with multiple VLAN #4939](https://github.com/canonical/microk8s/issues/4939)**

**[microk8s issues](https://github.com/canonical/microk8s/issues)**

#### Summary

MicroK8s will not run on the Ubuntu 24.04 server with the below network configurations on either a bare metal server or a multipass Ubuntu 24.04 server VM. The bare metal server and multipass VM both work as expected in our network environment in which the bare metal server is attached to a port configured to allow traffic from both default VLAN 50 and VLAN 220 of an extreme network switch.

#### What Should Happen Instead?

After a successful install in which `microk8s inspect` reports no issues microk8s should run.

#### Reproduction Steps

We are able to consistently reproduce this issue in our network environment.

1. Fresh Ubuntu 24.04 server install onto a bare metal server.
2. Configure the network with a NETPLAN config file.
3. Test that the server has access to all of the VLAN and that the other computers on the same VLAN can access it.
4. sudo snap install microk8s --classic --channel=1.32/stable
5. The microk8s inspect command shows no obvious errors
6. microk8s status shows not running.

#### Introspection Report

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
cp: cannot stat '/var/snap/microk8s/7399/var/kubernetes/backend/localnode.yaml': No such file or directory
...

```
#### Can you suggest a fix?
No, but if you can examine the report tarball and see the problem you could update the microk8s inspect command to report the error.

#### Are you interested in contributing with a fix?
I am not able to help now, but I plan on studying the status code more in the future.

<!-- Thank you for making MicroK8s better -->
Thank you also.
