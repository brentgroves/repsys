# **[Extending Kubernetes with Custom Resource Definitions (CRDs)](https://www.loft.sh/blog/extending-kubernetes-with-custom-resource-definitions-crds)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

Kubernetes custom resource definitions (CRDs) let you add new object types to the Kubernetes API. Kubernetes comes with many different objects that represent the most common application components, such as pods, jobs, ConfigMaps, and secrets. But what if you want to express application-specific data, such as a DatabaseConnection or AuthToken, while preserving its structure and supporting custom behavior? This is where CRDs come in.

CRDs extend the API with support for arbitrary data types. Each CRD you create gets its own API endpoints that you can use to query, create, and edit instances of that resource. Custom resources are fully supported within kubectl, so you can run commands like kubectl get backgroundjobs to interact with your application's objects.

In this article, you'll learn why CRDs are useful and how they relate to controller and operator extensions. Controllers are used to implement custom control loop mechanisms, such as crontabs and job queues, while operators are Kubernetes-specific middleware for individual apps like databases and observability stacks. Both depend heavily on CRDs.

After covering the theory, you'll also see how to register your own CRD and create object instances with kubectl.

## Understanding Kubernetes Custom Resources

A custom resource is data stored in Kubernetes that doesn't match an object kind included in the default distribution. You may have already used custom resources provided by popular community projects. For example, cert-manager automates SSL certificate management using Certificate and Issuer resources. Certificates represent real SSL certificates; you can obtain one by creating a CertificateRequest, another CRD provided by cert-manager.

You can use custom resources to encapsulate data required by your own applications, too. They store and retrieve structured data via dedicated API endpoints. Compared to generic solutions such as ConfigMaps, custom resources offer clearer intent, better separation of responsibilities, and an improved management experience when you're creating many instances of a particular data structure.

They're also the foundation for extending Kubernetes with your own controllers and operators.

Custom resources aren't the right choice for every scenario, though. For example, you don't need to create custom resources for arbitrary config values used by your app. In this situation, a plain ConfigMap will be easier to work with. Custom resources should be reserved for unique functionality that's scoped to the namespace or cluster level. They're ideal for data that fits the Kubernetes declarative operation model, requires its own API, and will be managed with ecosystem tools such as kubectl and the Kubernetes dashboard.

## ConfigMaps

A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.

A ConfigMap allows you to decouple environment-specific configuration from your container images, so that your applications are easily portable.
