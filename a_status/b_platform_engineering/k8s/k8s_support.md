# Kubernetes, or K8s, Platform Services Support Team

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

## Purpose of Team

Manage the Platform Services common to all Microservices.

- **[Authentication and Authorization](https://auth0.com/blog/why-auth0-by-okta/)**
- **[Zero-Trust Service Mesh Gateway](https://istio.io/latest/about/service-mesh/)**
- **[Job Queue](https://www.ibm.com/think/topics/redis#:~:text=Redis%20(REmote%20DIctionary%20Server)%20is,speed%2C%20reliability%2C%20and%20performance.)**
- **[Email service](https://mailtrap.io/email-sending/)**
- **[Postfix with public key security and Amazon Route53 programmatic DNS txt record creation](https://contabo.com/blog/linux-mail-server-setup-and-configuration/)**.
- **[SMS Notification Service](https://novu.co/)**

Learn everything we can to be ready when something goes wrong.

Kubernetes is a great place to run software securely.  On the downside, it is also a complex system, so it is good to understand how it works to fix issues as best we can.

## Players

John Biel: Manager, Network
Kiran Ambati: Network Architect
Ramarao Guttikonda: K8s admin
Christian Smith: Global Directory IT
Adrian Wise: System Admin, Technical Services Manager.
Aamir Ghaffar: IT Systems Architect
Justin Langille, Network Technician
Christian. Trujillo, IT Structures Manager
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor

## Our K8s versions

I believe we have decided to go with **[K3s](https://www.cloudzero.com/blog/k3s-vs-k8s/#:~:text=K3s%20is%20a%20lightweight%2C%20easy,Credit%3A%20How%20K3s%20works)** for Linus and we are using **[Canonical's MicroK8s](https://ubuntu.com/tutorials/install-a-local-kubernetes-with-microk8s#:~:text=MicroK8s%20is%20a%20CNCF%20certified,of%20libraries%20and%20binaries%20needed.)** for the Structures Avilla platform. Both versions are CNCF certified upstream Kubernetes deployment and not **[Forked versions](https://d2iq.com/blog/pure-open-source-kubernetes)**, which is great.  The Structures team is also evaluating the **[Azure Kubernetes](https://learn.microsoft.com/en-us/azure/aks/)** managed version of k8s.

## Where can we learn how it works?

- **[K3s code](https://github.com/k3s-io/k3s)**
- **[Visual Studio Code extion for k8s](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools)**
- **[Azure Kubernetes](https://learn.microsoft.com/en-us/azure/aks/)**
- **[Build MicroK8s](https://github.com/canonical/microk8s/blob/master/docs/build.md)**
- **[Configure Services](https://microk8s.io/docs/configuring-services)**
- **[Configuring CNI](https://microk8s.io/docs/change-cidr)**

Given our complex network, start learning this networking part of K8s.

- **[Configuring Host Interfaces](https://microk8s.io/docs/configure-host-interfaces)**

## **[Kubernetes Definition](https://www.cloudzero.com/blog/k3s-vs-k8s/#:~:text=K3s%20is%20a%20lightweight,%20easy,Credit:%20How%20K3s%20works)**

Kubernetes, or K8s, is an open-source, portable, scalable container orchestration platform. With K8s, you can reliably manage distributed systems for your applications, enabling declarative configuration and automatic deployment.
