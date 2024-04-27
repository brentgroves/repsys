# **[K8s self-healing](https://kublr.com/blog/reliable-self-healing-kubernetes-explained/)**

One of the great benefits of Kubernetes is its self-healing ability. If a containerized app or an application component goes down, Kubernetes will instantly redeploy it, matching the so-called desired state.

But what if a Kubernetes component or a node goes down? Kubernetes doesn’t monitor itself nor does it have access to your infrastructure. And, guess what. While infrastructure provisioning and self-healing are key to highly available reliable clusters, it’s still not standard in some of the most popular Kubernetes solutions.

You may now be confused since many vendors claim their platform is self-healing. They are. In fact, Kubernetes provides self-healing by default. What you may not know is that there are three distinct self-healing layers and Kubernetes only covers one. Let’s explore them one by one.

## (1) The Application Layer

This is where Kubernetes’ self-healing ability comes into play. If you properly containerize your apps and a pod (where containers are placed) crashes, Kubernetes will reschedule it as soon as possible — as long as there is sufficient available infrastructure. This latter part is key and part of the third layer that we’ll explore. More to that in a bit. What you need to keep in mind, is that when vendors talk about their self-healing platform, chances are they are talking about the app layer and, as we’ll see, that is not enough.

## (2) The Kubernetes Component Layer

Let’s move one layer down to Kubernetes components themselves. Each node runs a number of Kubernetes components needed to keep Kubernetes operational. This includes the kubelet, kube-proxy, and container runtime. If one of these components goes down, the node may become unresponsive. While Kubernetes will take note, minutes may pass before it does. During this time, you may experience service disruption.

Properly rolling out Kubernetes with tools such as Terraform or kops is not enough. You need a component that is continuously and proactively monitoring the health status of all Kubernetes components ensuring prompt recovery with minimal impact on the rest of the cluster. In Kublr’s case, the Kublr Agent does that.

## (3) The Infrastructure Layer

Now, let’s move another layer down, to the infrastructure. At any time, a VM or disk may go down. While Kubernetes will reschedule your apps as soon as it realizes the node is no longer available (which may take 5 minutes), it can’t spin up a new node by itself. All it can do is reschedule on existing infrastructure. If there isn’t enough available capacity, tough luck.

To provision new infrastructure when needed, you’ll need an external mechanism to ensure self-healing nodes. When using the cloud, you can leverage cloud tools to monitor VMs and automatically restart or spin up a new one in case of an unresponsive node. In Azure it may be scale sets. In AWS and GCP it’s autoscaling groups. All you need to do is make sure that the system that provisions Kubernetes clusters, properly leverages those capabilities.

On-prem with VMware or on bare metal, you’ll need some external system like Kublr to proactively monitor your infrastructure and take preventive or corrective action when needed. With VMware, for instance, the system may provision a new virtual node if the old one doesn’t respond anymore, etc.

As we’ve seen, Kubernetes ensures self-healing pods, and if a pod goes down, Kubernetes will restart a new one. However, if an entire node goes down, Kubernetes generally isn’t able to spin a new one up. From a self-healing point of view, infrastructure could turn into the weakest link in the chain, jeopardizing the reliability of your applications. That’s because your clusters are only as reliable as the underlying infrastructure. Meaning the best Kubernetes management solution cannot protect you from poor infrastructure provisioning.
