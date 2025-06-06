# **[Terraform](https://www.ibm.com/topics/terraform)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research List](../research_list.md)**\
**[Back Main](../../README.md)**

## references

- **[Terraform documentation](https://developer.hashicorp.com/terraform/language/providers)**

## **[Terraform Licensing](https://logz.io/blog/terraform-is-no-longer-open-source-is-opentofu-opentf-the-successor/)**

Under BSL 1.1, users still get access to the source code, and retain the right to run these projects locally, conduct testing, and even employ them in production environments. However, the catch is profound: organizations competing with HashiCorp’s cloud offerings, such as env0, are denied access to the latest project versions.

## Can we use the terraform Infrastructure as code system to recreate our Azure AKS Cloud resources needed for our report system?

Terraform would be a good way to automate creation or recreation of our entire Azure Cloud infrastructure in a reproducable way. It could be used to tear down and rebuild all of our Azure Cloud resources. So, after all of our OSS and custom apps have been deployed to our Azure AKS and we have a working report system it would be a good idea to be able to quickly recreate it if something goes wrong with the K8s cluster.

## What is Terraform?

Terraform, an open source “Infrastructure as Code” tool created by HashiCorp, allows programmers to build, change and version infrastructure safely and efficiently.

Terraform is a declarative coding tool that enables developers to use a high-level configuration language called HashiCorp Configuration Language (HCL) to describe the desired “end-state” cloud or on-premises infrastructure for running an application. It then generates a plan for reaching that end-state and runs the plan to provision the infrastructure.

Terraform uses a simple syntax, provisions infrastructure across multiple cloud and on-premises data centers and safely and efficiently reprovision infrastructure in response to configuration changes. This is why it is currently one of the most popular infrastructure automation tools available. If your organization plans to deploy a hybrid cloud or multicloud environment, you’ll likely want or need to get to know Terraform.

## Why Infrastructure as Code (IaC)?

To better understand the advantages of Terraform, it helps to first understand the benefits of Infrastructure as Code (IaC). IaC allows developers to code infrastructure to make provisioning automated, faster and repeatable. It’s a key component of Agile and DevOps practices such as version control, continuous integration and continuous deployment.

Infrastructure as code can help with the following:

- **Improve speed:** Automation is faster than manually navigating an interface when you need to deploy or connect resources.
- **Improve reliability:** If your infrastructure is large, it becomes easy to misconfigure a resource or provision services in the wrong order. With IaC, the resources are always provisioned and configured exactly as declared.
- **Prevent configuration drift:** Configuration drift occurs when the configuration that provisioned your environment no longer matches the actual environment. (See ‘Immutable infrastructure’)
- **Support experimentation, testing and optimization:** Because Infrastructure as Code makes provisioning new infrastructure faster and easier, you can make and test experimental changes without investing lots of time and resources; and if you like the results, you can quickly scale up the new infrastructure for production.

## Why Terraform?

There are a few key reasons developers choose to use Terraform over other Infrastructure as Code tools:

- **Open source:** Terraform is backed by large communities of contributors who build plug-ins to the platform. Regardless of which cloud provider you use, it’s easy to find plug-ins, extensions and professional support. This also means Terraform evolves quickly, with new benefits and improvements added consistently.
- **Platform agnostic:** This means you can use it with any cloud services provider. Most other IaC tools are designed to work with single cloud provider.
- **Immutable infrastructure:** Most Infrastructure as Code tools create mutable infrastructure, meaning the infrastructure that can change to accommodate changes such as a middleware upgrade or a new storage server. The danger with mutable infrastructure is configuration drift. This means that as the changes pile up, the actual provisioning of different servers or other infrastructure elements ‘drifts’ further from the original configuration, making bugs or performance issues difficult to spot and fix. Terraform provisions immutable infrastructure, which means that with each change to the environment, the current configuration is replaced with a new one that accounts for the change and the infrastructure is reprovisioned. Even better, previous configurations can be retained as versions to enable rollbacks if necessary or desired.

## Terraform modules

Terraform modules are small, reusable Terraform configurations for multiple infrastructure resources that are used together. Terraform modules are useful because they allow complex resources to be automated with reusable, configurable constructs. Writing even a very simple Terraform file results in a module. A module can call other modules—called child modules—which can make assembling configuration faster and more concise. Modules can also be called multiple times, either within the same configuration or in separate configurations.

## Terraform providers

Terraform providers are plugins that implement resource types. Providers contain all the code needed to authenticate and connect to a service—typically from a public cloud provider—on behalf of the user. You can find providers for the cloud platforms and services you use, add them to your configuration and then use their resources to provision infrastructure. Providers are available for nearly every major cloud provider, SaaS offering and more, developed or supported by the Terraform community or individual organizations. Refer to the **[Terraform documentation](https://developer.hashicorp.com/terraform/language/providers)** (link resides outside ibm.com) for a detailed list.

## Terraform versus Kubernetes

Sometimes, there confusion between Terraform and Kubernetes and what they do. The truth is that they are not alternatives and work effectively together.

Kubernetes is an open source container orchestration system that lets developers schedule deployments onto nodes in a compute cluster and actively manages containerized workloads to make sure that their state matches the users’ intentions.

Terraform is an Infrastructure as Code tool with a broader reach, which lets developers automate complete infrastructure that spans multiple public clouds and private clouds.

Terraform can automate and manage Infrastructure-as-a-Service (IaaS), Platform-as-a-Service (PaaS), or even Software-as-a-Service (SaaS) level capabilities and build all these resources across all those providers in parallel. You can use Terraform to automate the provisioning of Kubernetes—particularly managed Kubernetes clusters on cloud platforms—and to automate the deployment of applications into a cluster.

## Terraform versus Ansible

Terraform and Ansible are both Infrastructure as Code tools, but there are a couple significant differences between the two:

- While Terraform is purely a declarative tool (see above), Ansible® combines both declarative and procedural configuration. In procedural configuration, you specify the steps, or the precise manner, in which you want to provision infrastructure to the desired state. Procedural configuration is more work but it provides more control.
- Terraform is open source; Ansible is developed and sold by Red Hat®.
