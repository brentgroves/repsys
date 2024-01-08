# OpenStack

## references

<https://www.openstack.org/>

<https://www.redhat.com/en/topics/openstack>

<https://docs.openstack.org/install-guide/get-started-with-openstack.html>

## What is OpenStack?

OpenStack is an open source platform that uses pooled virtual resources to build and manage private and public clouds. The tools that comprise the OpenStack platform, called "projects," handle the core cloud-computing services of compute, networking, storage, identity, and image services. More than a dozen optional projects can also be bundled together to create unique, deployable clouds.

In virtualization, resources such as storage, CPU, and RAM are abstracted from a variety of vendor-specific programs and split by a hypervisor before being distributed as needed. OpenStack uses a consistent set of application programming interfaces (APIs) to abstract those virtual resources 1 step further into discrete pools used to power standard cloud computing tools that administrators and users interact with directly.

## Is OpenStack just a virtualization management platform?

Not quite. There are a lot of similarities, but they're not the same.

Yes, OpenStack and virtualization management platforms both sit on top of virtualized resources and can discover, report, and automate processes in vendor-disparate environments.

But while virtualization management platforms make it easier to manipulate the features and functions of virtual resources, OpenStack actually uses the virtual resources to run a combination of tools. These tools create a cloud environment that meets the National Institute of Standards and Technology's 5 criteria of **[cloud computing](https://www.nist.gov/programs-projects/cloud-computing)**: a network, pooled resources, a user interface, provisioning capabilities, and automatic resource control/allocation.

Cloud computing is a model for enabling convenient, on-demand network access to a shared pool of configurable computing resources (e.g., networks, servers, storage, applications, and services) that can be rapidly provisioned and released with minimal management effort or service provider interaction. This cloud model promotes availability and is composed of five essential characteristics (On-demand self-service, Broad network access, Resource pooling, Rapid elasticity, Measured Service); three service models (Cloud Software as a Service (SaaS), Cloud Platform as a Service (PaaS), Cloud Infrastructure as a Service (IaaS)); and, four deployment models (Private cloud, Community cloud, Public cloud, Hybrid cloud). Key enabling technologies include: (1) fast wide-area networks, (2) powerful, inexpensive server computers, and (3) high-performance virtualization for commodity hardware.

The Cloud Computing model offers the promise of massive cost savings combined with increased IT agility. It is considered critical that government and industry begin adoption of this technology in response to difficult economic constraints. However, cloud computing technology challenges many traditional approaches to datacenter and enterprise application design and management. Cloud computing is currently being used; however, security, interoperability, and portability are cited as major barriers to broader adoption.  

The long term goal is to provide thought leadership and guidance around the cloud computing paradigm to catalyze its use within industry and government. NIST aims to shorten the adoption cycle, which will enable near-term cost savings and increased ability to quickly create and deploy enterprise applications. NIST aims to foster cloud computing systems and practices that support interoperability, portability, and security requirements that are appropriate and achievable for important usage scenarios

## The NIST Cloud Federation Reference Architecture (NIST SP 500-332)

Published: February 13, 2020
Author(s): Robert B. Bohn, Craig A. Lee, Martial Michel

Abstract: This document presents the NIST Federated Cloud Reference Architecture model. This actor/role- based model used the guiding principles of the NIST Cloud Computing Reference Architecture to develop an eleven component model. This document describes these components individually and how they function as an ensemble. There are many possible deployments and governance options which lend themselves to create a suite of federation options from simple to complex. The basics of cloud federation can be described through the interactions of the actors in a layered three planes representation of trust, security, and resource sharing and usage. A discussion on possible future standards and use cases are also described in great detail.

## How does OpenStack work?

OpenStack is essentially a series of commands known as scripts. Those scripts are bundled into packages called projects that relay tasks that create cloud environments. In order to create those environments, OpenStack relies on 2 other types of software:

Virtualization that creates a layer of virtual resources abstracted from hardware
A base operating system (OS) that carries out commands given by OpenStack scripts
Think about it like this: OpenStack itself doesn't virtualize resources, but rather uses them to build clouds. OpenStack also doesn’t execute commands, but rather relays them to the base OS. All 3 technologies—OpenStack, virtualization, and the base OS—must work together. That interdependency is why so many OpenStack clouds are deployed using Linux®, which was the inspiration behind RackSpace and NASA’s decision to release OpenStack as open source software.

## The OpenStack components

OpenStack's architecture is made up of numerous open source projects. These projects are used to set up OpenStack's **[undercloud](https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/8/html/director_installation_and_usage/chap-introduction#sect-Undercloud)** and overcloud—used by sys admins and cloud users, respectively. Underclouds contain the core components sys admins need to set up and manage end users' OpenStack environments, known as overclouds.
