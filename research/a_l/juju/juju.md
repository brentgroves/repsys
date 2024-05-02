# Juju

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Welcome to Juju, your entrypoint into the Juju universe!

## references

<https://juju.is/blog/ansible-vs-terraform-vs-juju-fight-or-cooperation>

<https://juju.is/docs/juju>

![](https://discourse-charmhub-io.s3.eu-west-2.amazonaws.com/optimized/2X/7/738a914d2452961cb3d31bb3635b056ff7735b17_2_690x254.png)

## What is Juju

Juju is an open source orchestration engine for software operators that enables the deployment, integration and lifecycle management of applications at any scale, on any infrastructure, using special software operators called ‘charms’.

Juju provides a declarative and model-driven way to install, provision, maintain, update, upgrade, and integrate applications on and across Kubernetes containers, Linux containers, virtual machines, and bare metal machines, on public or private cloud.

As such, Juju makes it simple, intuitive, and efficient to manage the full lifecycle of complex applications in hybrid cloud.

For system operators and DevOps who manage applications in the cloud, Juju simplifies code; for CIOs, it helps align code with business decisions.

- For a collection of existing charms, see **[Charmhub](https://charmhub.io/)**. To build your own charm, see the Charm SDK docs.

## Ansible vs Terraform vs Juju: Competition or cooperation?

by **[Tytus Kurek](https://juju.is/blog/ansible-vs-terraform-vs-juju-fight-or-cooperation)** on 16 October 2019

Ansible vs Terraform vs Juju vs Chef vs SaltStack vs Puppet vs CloudFormation – there are so many tools available out there. What are these tools? Do I need all of them? Are they competing with each other or cooperating?

The answer is not really straightforward. It usually depends on your needs and the particular use case. While some of these tools (Ansible, Chef, StaltStack, Puppet) are pure configuration management solutions, the others (Juju, Terraform, CloudFormation) focus more on services orchestration. For the purpose of this blog, we’re going to focus on Ansible vs Terraform vs Juju comparison – the three major players which have dominated the market.

## Ansible

Ansible is a configuration management tool, currently maintained by Red Hat Inc. Although the core project is open-source, some commercial extensions, such as Ansible Tower, are available too. By supporting a variety of modules, Ansible can be used to manage both Unix-like and Windows hosts. Its architecture is serverless and agentless. Instead of using proprietary communication protocols, Ansible relies on SSH or remote PowerShell sessions to perform configuration tasks.

The tool implements an imperative DevOps paradigm. This means that Ansible users are responsible for defining all of the steps required to achieve their desired goal. This includes writing instructions on how to install applications, preparing templates of configuration files, etc. All these steps are usually implemented in a form of so-called playbooks, however, users can execute ad hoc commands too. Once written, the playbooks can be used to automate configuration tasks across multiple machines in various environments.

Although perfectly suited for traditional configuration management, Ansible cannot really orchestrate services. It was just designed for different purposes, with automation being in the core. Moreover, some of its modules are cloud-specific which makes a potential migration from one platform to the other difficult. Finally, due to its imperative nature, Ansible does not scale in large environments consisting of various interconnected applications.

## Terraform

In turn, Terraform is an open-source IaC (Infrastructure-as-Code) solution that was developed by HashiCorp. It allows users to provision and manage cloud, infrastructure, and service resources using simple, human-readable configuration language called HCL (HashiCorp Configuration Language). The resources are delivered by so-called providers. At the moment Terraform supports over 200 providers, including public clouds, private clouds and various SaaS (Software-as-a-Service) providers, such as DNS, MySQL or Vault.

Terraform uses a declarative DevOps paradigm which means that instead of defining exact steps to be executed, the ultimate state is defined. This is a huge progress compared to the traditional configuration management tools. However, Terraform’s declarative approach is limited to providers only. The applications being deployed still have to be installed and configured using traditional scripts and tools. Of course, pre-built images can be used too, when deploying applications in cloud environments. Those can be later customized according to the users’ requirements.

In addition to the initial deployment, Terraform can also be used to orchestrate deployed workloads. This functionality is provided by its execution plans and resource graphs. Thanks to the execution plans users can define exact steps to be performed and the order in which they will be executed. In turn, resource graphs allow to visualise those plans. Again, this is much more than what Ansible can do.

## Juju Canonical

![](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,c_fill,w_364,h_133/https://ubuntu.com/wp-content/uploads/4ec1/juju.png)

Contrary to both Ansible and Terraform, Juju is an application modelling tool, developed and maintained by Canonical. You can use it to model and automate deployments of even very complex environments consisting of various interconnected applications. Examples of such environments include OpenStack, Kubernetes or Ceph clusters. Apart from the initial deployment, you can also use Juju to orchestrate deployed services too. Thanks to Juju you can backup, upgrade or scale-out your applications as easily as executing a single command.

Like Terraform, Juju uses a declarative approach, but it brings it beyond the providers up to the applications layer. You can not only declare a number of machines to be deployed or number of application units, but also configuration options for deployed applications, relations between them, etc. Juju takes care of the rest of the job. This allows you to focus on shaping your application instead of struggling with the exact routines and recipes for deploying them. Forget the “How?” and focus on the “What?”.

The real power of Juju lies in charms – collections of scripts and metadata which contain a distilled knowledge of experts from Canonical and other companies. Charms contain all necessary logic required to install, configure, interconnect and operate applications. Canonical maintains a Charm Store with over 400 charms, but you can also write your own charms. This is because the whole framework and ecosystem is fully open-source.

While Juju’s role is to deploy and orchestrate applications, like Terraform it relies on a variety of providers to spin up machines (bare metal, VMs or containers) for hosting those applications. The supported providers include leading public clouds (AWS, Google Cloud, Azure, etc.) and various on-premise providers: LXD, MAAS, VMware vSphere, OpenStack and Kubernetes. In a very rare case, when your cloud environment is not natively supported by Juju, you can use a manual provider to let Juju deploy applications on top of your manually provisioned machines.

## Ansible vs Terraform vs Juju

Now, as we’ve arrived at the last section of this blog, could we somehow compare Ansible vs Terraform vs Juju? The answer is short – we cannot. This is because all of them were designed for different purposes and with a different focus in mind. It is fair to say that in some way they formed an evolution path of lifecycle management frameworks. It is really hard to perform Ansible vs Terraform vs Juju comparison then, as each of them is absolutely different.

Thus, if we cannot compare them, let’s maybe get back to the original questions and try to answer them instead.

## Do I need all of those tools?

Well, it really depends on your use case, so let’s try to sum up what these tools are for. Ansible is a configuration management tool and fits very well wherever traditional automation is required. On the other hand, Terraform focuses more on infrastructure provisioning, assuming that applications will be delivered in a form of pre-built images. Finally, Juju takes a completely different approach by using charms for applications deployments and operations.

## Are they competing with each other or cooperating?

There are definitely areas in which they cooperate. For example, Juju charms can use Ansible playbooks to maintain configuration files. Or you can use Juju-deployed applications (e.g. OpenStack) as a provider for Terraform. As data centers are becoming more and more complex, there’s definitely space for all of them. This is because all of them are great in what they are doing and what they were designed for.

## I want Juju, what next?

If you want to evolve your DevOps organisation and benefit from model-driven, declarative approach to applications deployments and operations, Juju is the answer. Simply visit the Juju website, watch the “Introduction To Juju: Automating Cloud Operations” webinar or contact us directly. Canonical’s DevOps experts are waiting to help you to move forward with the transformation of your organisation.

## In this documentation

Tutorial
Get started - a hands-on introduction to Juju for new users
How-to guides
Step-by-step guides covering key operations and common tasks
Explanation
Discussion and clarification of key topics Reference
Technical information - specifications, APIs, architecture
