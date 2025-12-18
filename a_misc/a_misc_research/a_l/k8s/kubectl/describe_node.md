# **[Master Kubernetes Node Commands: The Ultimate kubectl Commands and Cheat Sheet for Node Operations](https://www.kerno.io/learn/master-kubernetes-with-ease-the-ultimate-kubectl-commands-and-cheat-sheets-guide)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Master Kubernetes Node Commands: The Ultimate kubectl Commands and Cheat Sheet for Node Operations

## kubectl describe node

kubectl describe node "node_name"
The kubectl describe node [node-name] command provides detailed information about a specific node in a Kubernetes cluster. This command outputs a wealth of data, including the node's labels, annotations, conditions (like memory pressure, disk pressure, and readiness), addresses (like internal IP), capacity (such as CPU and memory resources), and the status of the pods running on the node. It's an invaluable tool for diagnosing issues and understanding the state of a node in depth.

Example Use in a Real System:
Suppose you're administering a Kubernetes cluster that's running several critical applications. You notice that one of the nodes is showing irregular resource usage. To investigate further, you use kubectl describe node to get detailed information about this particular node.

By running kubectl describe node [node-name], you can see a comprehensive view of the node's status, including its resource allocation (CPU, memory), conditions that might be affecting its performance, and any events related to the node. This detailed view could reveal issues like high memory usage or network problems, helping you to pinpoint the cause of the irregularities and take appropriate corrective actions.

```bash
kubectl describe node repsys11-c2-n3
Name:               repsys11-c2-n3
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=repsys11-c2-n3
                    kubernetes.io/os=linux
                    microk8s.io/cluster=true
                    node.kubernetes.io/microk8s-controlplane=microk8s-controlplane
Annotations:        node.alpha.kubernetes.io/ttl: 0
                    projectcalico.org/IPv4Address: 10.127.233.169/24
                    projectcalico.org/IPv4VXLANTunnelAddr: 10.1.187.128
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Tue, 27 Aug 2024 18:40:19 -0400
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  repsys11-c2-n3
  AcquireTime:     <unset>
  RenewTime:       Thu, 29 Aug 2024 18:08:04 -0400
Conditions:
  Type                 Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----                 ------  -----------------                 ------------------                ------                       -------
  NetworkUnavailable   False   Thu, 29 Aug 2024 17:20:20 -0400   Thu, 29 Aug 2024 17:20:20 -0400   CalicoIsUp                   Calico is running on this node
  MemoryPressure       False   Thu, 29 Aug 2024 18:05:25 -0400   Tue, 27 Aug 2024 18:40:19 -0400   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure         False   Thu, 29 Aug 2024 18:05:25 -0400   Tue, 27 Aug 2024 18:40:19 -0400   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure          False   Thu, 29 Aug 2024 18:05:25 -0400   Tue, 27 Aug 2024 18:40:19 -0400   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready                True    Thu, 29 Aug 2024 18:05:25 -0400   Thu, 29 Aug 2024 17:20:21 -0400   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  10.1.0.141
  Hostname:    repsys11-c2-n3
Capacity:
  cpu:                2
  ephemeral-storage:  81106868Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             16360536Ki
  pods:               110
Allocatable:
  cpu:                2
  ephemeral-storage:  80058292Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             16258136Ki
  pods:               110
System Info:
  Machine ID:                 1e611355ac14480ebadb8d4770372e67
  System UUID:                1e611355-ac14-480e-badb-8d4770372e67
  Boot ID:                    ad3055ff-5f23-4325-8396-ed98bb30213e
  Kernel Version:             5.15.0-119-generic
  OS Image:                   Ubuntu 22.04.4 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://1.6.28
  Kubelet Version:            v1.30.4
  Kube-Proxy Version:         v1.30.4
Non-terminated Pods:          (2 in total)
  Namespace                   Name                               CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                               ------------  ----------  ---------------  -------------  ---
  default                     rabbitmqcluster-sample-server-0    1 (50%)       2 (100%)    2Gi (12%)        2Gi (12%)      39m
  kube-system                 calico-node-sgzfx                  250m (12%)    0 (0%)      0 (0%)           0 (0%)         47m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests     Limits
  --------           --------     ------
  cpu                1250m (62%)  2 (100%)
  memory             2Gi (12%)    2Gi (12%)
  ephemeral-storage  0 (0%)       0 (0%)
  hugepages-1Gi      0 (0%)       0 (0%)
  hugepages-2Mi      0 (0%)       0 (0%)
Events:              <none>

```

## kubectl top node

```bash
kubectl top node repsys11-c2-n1

NAME             CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
repsys11-c2-n1   271m         27%    2495Mi          15%       

kubectl top nodes              

NAME             CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
repsys11-c2-n1   306m         30%    2495Mi          15%       
repsys11-c2-n2   252m         12%    2349Mi          14%       
repsys11-c2-n3   258m         12%    2488Mi          15% 
```
