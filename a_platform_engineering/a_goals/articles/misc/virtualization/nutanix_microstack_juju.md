
# Nutanix / OpenStack / JuJu

Hi Team,

This is a short description of 2 Software-defined infrastructures and a lifecycle management tool that I thought you would find interesting. The Information System team is testing MicroStack. MicroStack and MicroCloud are being considered to host the Structures Kubernetes Cluster.

Team:

Christian. Trujillo, IT Structures Manager
Brent Hall, System Administrator Senior
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor, Mills River
Mitch Harper, Desktop and Systems Support Technician, Mills River
Thomas.Creal, Desktop and Systems Support Technician, Mills River
Matthew Bump, Muscle Shoals, Engineering Supervisor II / IT
Carlos Morales, IT Administrator, Muscle Shoals
Sam Jackson, Information Systems Developer, Southfield
Matt Irey, Desktop and System Support Technician, Fruitport
David Maitner,  Desktop and System Support Technician, Fruitport
Carl Stangland, Desktop and System Support Technician, Indiana
Lucas Tuma, IT Administrator, Strakonice
Aleksandar Gavrilov, IT Administrator, Skopje

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

## IAAS / Software Defined Infrastructure

There are many categories of virtualization software, at least six, but three of which are Hypervisor, Software-Defined Network (SDN), and storage. These providers unify these services and provide one API or user interface to manage them.

## Downside

Each of these software programs is very configurable and feature-rich.  When you unify them, you lose the configuration options of each one. For example, with Open Virtual Switch (OVS), you can create any SDN you could possibly desire, but when you manage OVS through a higher-level API or user interface, you are limited to its basic features.

## **[Nutanix](https://www.nutanix.com/what-we-do#:~:text=Our%20software%2Ddefined%20infrastructure%20brings,secure%2C%20resilient%2C%20and%20adaptive.)**

A unified platform to run applications and manage data across on-premises data centers and public clouds.

Uses:

- AHV / KVM hypervisors
- Open Virtual Switch (OVS)
- AOS storage
- CentOS

Notes:

- Hyper-converged infrastructure (HCI) is a software-defined IT infrastructure that virtualizes all of the elements of conventional "hardware-defined" systems.
- Comes with physically enclosed servers.
- The hardware and software have been tested together thoroughly.
- Nutanix makes drivers for OpenStack so you can combine and unify both.
- Good support.
...

## **[OpenStack](https://www.openstack.org/#:~:text=Cloud%20Infrastructure%20for%20Virtual%20Machines,READ%20MORE)**

OpenStack supports several different virtualization service combinations. MicroStack uses the combination given below.

Uses:

- libvirt+QEMU hypervisors
- Open Virtual Switch (OVS) / Open Virtual Network (OVN)
- Ceph storage
- Ubuntu

Notes:

- Uses **Juju** to deploy in five steps.
- Also uses **MicroK8s** to manage the MicroStack deployment and upgrades.
- Can also deploy Kubernetes.
- Has one API to manage all services.
- Canonical provides an ACL list of internet domains needed for MicroStack to work with a Proxy Server.
- OpenStack is one of the largest open-source projects.

## **[Juju](https://juju.is/#:~:text=Revolutionise%20the%20speed%20and%20quality,on%20any%20infrastructure%20using%20charms.)**

Canonical Juju is an open-source orchestration engine developed by Canonical Ltd. It simplifies deployment, configuration, and management of applications and services across various infrastructures, including virtual machines, Kubernetes, and cloud environments.

### Application Management

Juju helps manage the entire lifecycle of applications, from deployment to upgrades, on different platforms.

### Model-Driven Approach

Juju uses a model-driven approach, allowing users to define the state of their applications and relationships.

### Charms

Juju uses "charms,"  operators that **encapsulate the operational knowledge** for deploying and managing specific applications.

### Infrastructure Agnostic

Juju supports various infrastructures, including virtual machines, Kubernetes clusters, and cloud providers.

### Open Source

Juju is an open-source project, meaning its code is free and anyone can contribute to it.

### Juju compared to similar tools

Juju’s focus is on system lifecycle management

Most existing tools focus on solving the problem of deployment or configuration management, while Juju’s focus is on the entire system lifecycle, from application deployment and integration to Day 2 operations like backup, upgrades, migrations, or scaling.

Juju integrates well with Terraform, extending our system lifecycle management framework with infrastructure as code capabilities.

![i6](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_1500,h_849/https://assets.ubuntu.com/v1/62922bad-How%20juju%20compares.svg)

...
