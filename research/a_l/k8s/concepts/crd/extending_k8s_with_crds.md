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

Custom resources aren't the right choice for every scenario, though. For example, you don't need to create custom resources for arbitrary config values used by your app. In this situation, a plain ConfigMap will be easier to work with. Custom resources should be reserved for unique functionality that's scoped to the namespace or cluster level. They're ideal for data that fits the Kubernetes **declarative operation model**, requires its own API, and will be managed with ecosystem tools such as kubectl and the Kubernetes dashboard.

## **[ConfigMaps](../config_map.md)**

A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.

A ConfigMap allows you to decouple environment-specific configuration from your container images, so that your applications are easily portable.

## CRDs, Controllers, and Operators

Custom resources are usually encountered alongside controllers and operators. A Kubernetes controller **monitors specific resource types and carries out actions that achieve desired state changes**. The pod controller ensures containers are started in response to new pod manifests being added to your cluster, while cert-manager's controller obtains an SSL certificate when you create a CertificateRequest object.

CRDs are rarely used without an accompanying controller. On their own, CRD instances are simple blobs of data in your cluster. The presence of custom objects used in this way is a good sign that a ConfigMap would be more appropriate for the situation.

## Processing CRDs with Controllers

Kubernetes controllers are loops that take actions in response to specific events occurring. The controller's cycle has three main phases:

- **Observe:** The controller determines the cluster's desired state by monitoring for Kubernetes events that describe changes.
- **Analyze:** The observed state is compared to the known existing state. This uncovers discrepancies such as new objects that aren't in the old state or fields that have had their values updated.
- **Act:** The controller performs all the actions necessary to transition the cluster into the desired state.

Creating controllers for your CRDs lets you process their data and carry out tasks inside your cluster. Take the BackgroundJob CRD mentioned in the introduction: you could write a controller that automatically runs a command in a container whenever a new BackgroundJob object is created.

## You'd write a simple YAML manifest similar to this

```yaml
apiVersion: crds.example.com/v1
kind: BackgroundJob
metadata:
  name: demo-job
spec:
  image: busybox:latest
  command: "echo hello-world"
```
