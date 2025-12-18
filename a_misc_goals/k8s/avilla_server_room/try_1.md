# Microk8s Linamar install try 1

- used r620_202 server
- setup network with access to vlan 50 and 220
- installed microk8s successfull
  - microk8s inspect showed no issues
  - microk8s status showed not running
  - kubectl pods did not start in kubesystem ns did not check others.
- Filed a bug report. **[Issue installing microk8s on network with multiple VLAN #4939](https://github.com/canonical/microk8s/issues/4939)**
