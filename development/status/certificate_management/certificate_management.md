# Certificate Management Team

## references

- Filed a bug report. **[Issue installing microk8s on network with multiple VLAN #4939](https://github.com/canonical/microk8s/issues/4939)**

## players

- Matt Irey, <mirey@linamar.com>
- David Maitner

- Researched Fortigate Proxy pertaining to certificates with Justin L.
- Discussing Mach2 user computer trust-store updates with Fruitport DST.
- Creating Network config request to temporarily allow my laptop to access Fruitport's OT network for certificate testing.

10.188.40.230 network config to 10.184.220.211

10.240. wifi ot vlan
10.184.220.211

goal: root and intermediate in trust

- 50 computers (no wyse server)
- image: win10.1809

1. go around and install it to all pcs.
2. reimage automatically

## Steps

1. create server certificate for fruitport mach2 server
