# **[Kubelet](https://www.windriver.com/solutions/learning/what-is-a-kubelet#:~:text=A%20kubelet%20is%20a%20critical,node%20in%20a%20Kubernetes%20cluster.)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## What Is a Kubelet?

A kubelet is a critical component within Kubernetes architecture. It is the primary node agent — the administrative agent that monitors application servers and routes administrative requests to servers — that runs on each node in a Kubernetes cluster. It plays a pivotal role in ensuring that the containers are running and properly managed within the node. Essentially, it’s the key liaison between the Kubernetes active controller and the nodes within the cluster.

This node agent is responsible for overseeing the execution of containers on the node by interacting with the container runtime, which could be Docker, containerd, or another compliant runtime. The kubelet receives Podspecs, which are specifications for a set of one or more containers, from the Kubernetes active controller, then ensures that the containers described in those Podspecs are launched and operating as expected.

The kubelet performs other essential tasks, including monitoring the health of containers, ensuring that they’re in the desired state according to the Podspecs, managing container lifecycles (starting, stopping, and restarting), and reporting back to the control plane about the node’s status. It also manages resources such as CPU, memory, and storage on the node by handling Pod resource consumption and limits, ensuring that the containers do not exhaust the node’s resources.

In short, the kubelet is a crucial component that acts as the node-level supervisor within a Kubernetes cluster, responsible for the proper execution and management of containers. It ensures that the node maintains the desired state as defined by the Kubernetes active controller.

## What Is a Node Agent?

A node agent, in the realm of computer systems and network management, refers to a software component or entity responsible for handling specific tasks and maintaining operations within a computing node or a network node. Its primary function is to monitor, manage, and control activities and resources on the node it operates on.

In the context of distributed systems such as Kubernetes, a node agent — such as the kubelet — plays a critical role in managing the individual nodes within a cluster. Specifically, the kubelet acts as a node-level agent responsible for overseeing the execution of containers within each node. It communicates with the control plane, adhering to instructions and specifications for deploying and managing containers, ensuring that they run as defined by the received Podspecs.
