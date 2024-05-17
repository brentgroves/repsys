# **[Cloud Substrate](https://juju.is/docs/juju/cloud)**

Cloud (substrate)
See also: How to **[manage a cloud](https://juju.is/docs/juju/manage-clouds)**

To Juju, a cloud (or backing cloud) is any entity that has an API that can provide compute, networking, and optionally storage resources in order for application units to be deployed on them. This includes public clouds such as Amazon Web Services, Google Compute Engine, Microsoft Azure and Kubernetes as well as private OpenStack-based clouds. Juju can also make use of environments which are not clouds per se, but which Juju can nonetheless treat as a cloud. MAAS and LXD fit into this last category. Because of this, in Juju a cloud is sometimes also called, more generally, a substrate.

Supported clouds
See: **[List of supported clouds](https://juju.is/docs/juju/juju-supported-clouds)**

Cloud differences
While Juju aims to make all clouds feel the same, some differences still persist depending on whether the cloud is a machine cloud or a Kubernetes cloud or a specific cloud as opposed to another.

Machine clouds vs. Kubernetes clouds
Cloud foo vs. cloud bar

Machine clouds vs. Kubernetes clouds
Juju makes a fundamental distinction between ‘machine’ clouds – that is, clouds based on bare metal machines (BMs; e.g., MAAS), virtual machines (VMs; e.g., AWS EC2), or system containers (e.g., LXD) – and ‘Kubernetes’ clouds – that is, based on containers (e.g., AWS EKS).

See more: Machine

While the user experience is still mostly the same – bootstrap a Juju controller into the cloud, add a model, deploy charms, scale, upgrade, etc. – this difference affects the required system requirements (e.g., for a Juju controller, 4GB vs. 6GB memory), the way you connect the cloud to Juju (add-cloud + add-credentials vs. add-k8s), what charms you can deploy (‘machine’ charms vs. ‘Kubernetes’ charms), and – occasionally – what operations you may perform and/or how (e.g., enable-ha is currently supported just for machine controllers; scaling an application is done via add-unit on machines and via scale-application on K8s).
