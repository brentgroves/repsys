# **[Controllers](https://www.uffizzi.com/kubernetes-multi-tenancy/kubernetes-controllers)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## What are Kubernetes Controllers?

Controllers are critical components underpinning the architecture of Kubernetes clusters. They are binaries responsible for maintaining the cluster's desired state for a subset of Kubernetes objects. For example, the DaemonSet Controller is accountable for analyzing changes to DaemonSet objects and actioning them by creating Pods for every Worker Node in the cluster.

The default Controllers built-in to all Kubernetes clusters are located within the Kube Controller Manager component. This component contains a collection of default Controllers responsible for handling standard Kubernetes functionality. It's possible to install additional Controllers (Operators) to extend the cluster's functionality, which we'll discuss later in the article.

Controllers typically operate in a control loop with a general sequence of events:

- **Observe:** Each Controller in the cluster will be designed to observe a specific set of Kubernetes objects. For example, the Deployment Controller will observe Deployment objects, and the Service Controller will observe Service objects, etc. Every object in a Kubernetes cluster has an associated Controller responsible for watching it to analyze its configuration.
- **Compare:** The Controller will compare the object configuration with the current state of the cluster to determine if changes are necessary. For example, if a ReplicaSet is configured to have five replicas (copies of a pod) , the ReplicaSet Controller will constantly monitor the number of active Pod replicas in the cluster. If a pod is deleted, the ReplicaSet Controller will recognize a difference between the desired state and the current state of the cluster.
- **Action:** The Controller will apply changes to the cluster to ensure the cluster's current state matches the desired state of the Kubernetes objects. Following the above example, if a Pod is deleted and, therefore, "drifted" from the cluster's current state, the ReplicaSet Controller will mitigate this drift by launching a replacement Pod. In this case, the ReplicaSet Controller's objective is to ensure the number of active Pods in the cluster matches the number of replicas in the ReplicaSets.
- **Repeat:** All of the above steps are being completed in an infinite loop by all Controllers in the Kubernetes cluster. The Controllers ensure the cluster's current state always matches the desired state specified in the Kubernetes object configuration.
