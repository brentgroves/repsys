# **[What are managed identities for Azure resources?](https://learn.microsoft.com/en-us/entra/identity/managed-identities-azure-resources/overview)**

A common challenge for developers is the management of secrets, credentials, certificates, and keys used to secure communication between services. Managed identities eliminate the need for developers to manage these credentials.

While developers can securely store the secrets in Azure Key Vault, services need a way to access Azure Key Vault. Managed identities provide an automatically managed identity in Microsoft Entra ID for applications to use when connecting to resources that support Microsoft Entra authentication. Applications can use managed identities to obtain Microsoft Entra tokens without having to manage any credentials.

Here are some of the benefits of using managed identities:

- You don't need to manage credentials. Credentials aren’t even accessible to you.
- You can use managed identities to authenticate to any resource that supports Microsoft Entra authentication, including your own applications.
- Managed identities can be used at no extra cost.

Managed identities for Azure resources is the new name for the service formerly known as Managed Service Identity (MSI).

Managed identity types
There are two types of managed identities:

- **System-assigned.** Some Azure resources, such as virtual machines allow you to enable a managed identity directly on the resource. When you enable a system-assigned managed identity:

  - A service principal of a special type is created in Microsoft Entra ID for the identity. The service principal is tied to the lifecycle of that Azure resource. When the Azure resource is deleted, Azure automatically deletes the service principal for you.
  - By design, only that Azure resource can use this identity to request tokens from Microsoft Entra ID.
  - You authorize the managed identity to have access to one or more services.
  - The name of the system-assigned service principal is always the same as the name of the Azure resource it is created for. For a deployment slot, the name of its system-assigned identity is <app-name>/slots/<slot-name>.

- **User-assigned.** You may also create a managed identity as a standalone Azure resource. You can create a user-assigned managed identity and assign it to one or more Azure Resources. When you enable a user-assigned managed identity:

  - A service principal of a special type is created in Microsoft Entra ID for the identity. The service principal is managed separately from the resources that use it.
  - User-assigned identities can be used by multiple resources.
  - You authorize the managed identity to have access to one or more services.

The following table shows the differences between the two types of managed identities:

| Property                       | System-assigned managed identity                                                                                                                                   | User-assigned managed identity                                                                                                                                                                                                                                                                                                                           |
|--------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Creation                       | Created as part of an Azure resource (for example, Azure Virtual Machines or Azure App Service).                                                                   | Created as a stand-alone Azure resource.                                                                                                                                                                                                                                                                                                                 |
| Life cycle                     | Shared life cycle with the Azure resource that the managed identity is created with. When the parent resource is deleted, the managed identity is deleted as well. | Independent life cycle. Must be explicitly deleted.                                                                                                                                                                                                                                                                                                      |
| Sharing across Azure resources | Can’t be shared. It can only be associated with a single Azure resource.                                                                                           | Can be shared. The same user-assigned managed identity can be associated with more than one Azure resource.                                                                                                                                                                                                                                              |
| Common use cases               | Workloads contained within a single Azure resource. Workloads needing independent identities. For example, an application that runs on a single virtual machine.   | Workloads that run on multiple resources and can share a single identity. Workloads needing pre-authorization to a secure resource, as part of a provisioning flow. Workloads where resources are recycled frequently, but permissions should stay consistent. For example, a workload where multiple virtual machines need to access the same resource. |

## How can I use managed identities for Azure resources?

You can use managed identities by following the steps below:

1. Create a managed identity in Azure. You can choose between system-assigned managed identity or user-assigned managed identity.
    a. When using a user-assigned managed identity, you assign the managed identity to the "source" Azure Resource, such as a Virtual Machine, Azure Logic App or an Azure Web App.
2. Authorize the managed identity to have access to the "target" service.
3. Use the managed identity to access a resource. In this step, you can use the Azure SDK with the Azure.Identity library. Some "source" resources offer connectors that know how to use Managed identities for the connections. In that case, you use the identity as a feature of that "source" resource.
