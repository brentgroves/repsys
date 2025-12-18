# **[Architect multitenant solutions on Azure](https://learn.microsoft.com/en-us/azure/architecture/guide/multitenant/overview)

A multitenant solution is one used by multiple customers, or tenants. Tenants are distinct from users. Multiple users from a single organization, company, or group form a single tenant. Examples of multitenant applications include:

- **Business-to-business (B2B)** solutions, such as accounting software, work tracking, and other software as a service (SaaS) products.
- **Business-to-consumer (B2C)** solutions, such as music streaming, photo sharing, and social network services.
- **Enterprise-wide platform** solutions, such as a shared Kubernetes cluster that's used by multiple business units within an organization.

When you build your own multitenant solution in Azure, there are several elements you need to consider that factor into your architecture.

In this series, we provide guidance about how to design, build, and operate your own multitenant solutions in Azure.

In this series, we use the term tenant to refer to your tenants, which might be your customers or groups of users. Our guidance is intended to help you to build your own multitenant software solutions on top of the Azure platform.

Microsoft Entra ID also includes the concept of a tenant to refer to individual directories, and it uses the term multitenancy to refer to interactions between multiple Microsoft Entra tenants. Although the terms are the same, the concepts are not. When we need to refer to the Microsoft Entra concept of a tenant, we disambiguate it by using the full term Microsoft Entra tenant.

## Scope

Azure is itself a multitenant service, and some of our guidance is based on our experience with running large multitenant solutions. However, the focus of this series is on helping you build your own multitenant services, while harnessing the power of the Azure platform.

Additionally, when you design a solution, there are many areas you need to consider. The content in this section is specific to how you design for multitenancy. We don't cover all of the features of the Azure services, or all of the architectural design considerations for every application. You should read this guide in conjunction with the Microsoft Azure Well-Architected Framework and the documentation for each Azure service that you use.
