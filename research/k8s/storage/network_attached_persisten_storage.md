## Network-attached persistent storage

Kubernetes and cloud-native environments require that storage volumes be network-attached to the compute instances, to guarantee data durability. Otherwise, if using local storage, data may be lost in a Pod failure event. See the figure below:

![](https://redis.io/docs/latest/images/rs/kubernetes-overview-network-attached-persistent-storage.png)
