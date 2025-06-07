# **[Architecture](https://canonical-openstack.readthedocs-hosted.com/en/latest/explanation/architecture/)**

**[Back to Research List](../../../../../research_list.md)**\
**[Back to Current Tasks](../../../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../../../README.md)**

## Architecture

This section provides an overview of the Canonical OpenStack architecture.

Canonical OpenStack can be deployed as a single-node cloud or can span across multiple nodes to provide capacity and resilience in a multi-node solution.

## Key concepts

Even though Canonical OpenStack is an enterprise-grade product that is available with a broad range of commercial services, it is built on top of a variety of open source projects and is available free of charge. The following sections provide an overview of these projects and Canonical’s involvement in their development.

## OpenStack

Canonical OpenStack is built on top of the pure upstream OpenStack project, guaranteeing API compatibility. Canonical has been involved in OpenStack and the wider OpenInfra community since the very early beginnings of the project and is the third largest contributor to OpenStack code over all time.

In the Canonical OpenStack development process Canonical packages the upstream code and makes it available in the form of various artifacts that are then used to deploy and operate the product. Only mature and well-maintained services are included to ensure production-grade stability.

## Ubuntu

Canonical OpenStack is only available on top of the Ubuntu operating system (OS). Ubuntu is the most popular OS for OpenStack deployments according to the Open Infrastructure Foundation (OIF). Canonical is the publisher and maintainer of Ubuntu, providing its engineering resources and thought leadership in this integral part of the open source ecosystem.

## Sunbeam

Canonical OpenStack is built on top of Sunbeam. Sunbeam is an upstream OpenStack project under the governance of the **[OIF](https://www.openstack.org/analytics/)**. The project aims to lower the barrier to entry for people with no previous OpenStack background and fully revolutionize the operational experience. Canonical is the maintainer and the biggest contributor to the Sunbeam project.

## Software architecture

Canonical OpenStack uses cloud-native architecture to isolate individual components from each other and fully decouple the software from the underlying OS. In the background the product uses various technologies, open-source projects and other Canonical products that are required to form an end-to-end cloud solution.

Rocks
**[Rocks](https://documentation.ubuntu.com/rockcraft/en/stable/)** are OCI-compliant container images that are built to be secure and stable by design. Canonical OpenStack uses Rocks for the purpose of hosting OpenStack’s control plane services as well as some other software components (i.e. the observability stack).

Snaps
**[Snaps](https://snapcraft.io/docs)** are application container images that are designed to be strictly confined and secure by default. Canonical OpenStack uses snaps for the purpose of hosting OpenStack’s data plane processes as well as many other software components being used in the RA.

Charms
**[Charms](https://juju.is/docs/sdk)** are operators – software that wraps an application and that contains all of the instructions necessary for deploying, configuring, scaling, integrating, etc. the application. Canonical OpenStack uses Charms for the purpose of deploying and operating many other artifacts, including Rocks and Snaps.
