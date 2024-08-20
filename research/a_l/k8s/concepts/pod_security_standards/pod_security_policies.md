
# **[Pod Security Policies](https://overcast.blog/mastering-kubernetes-pod-security-policies-psp-d28c0ce0634d)**

**[Report System Install](../../../../research_list.md)**\
**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../../README.md)**

## references

- **[Pod Security Policies](https://overcast.blog/mastering-kubernetes-pod-security-policies-psp-d28c0ce0634d)**

## NOTE

**Removed feature**\
PodSecurityPolicy was deprecated in Kubernetes v1.21, and removed from Kubernetes in v1.25.

Instead of using PodSecurityPolicy, you can enforce similar restrictions on Pods using either or both:

**[Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/)**
a 3rd party admission plugin, that you deploy and configure yourself
For a migration guide, see Migrate from PodSecurityPolicy to the Built-In PodSecurity Admission Controller. For more information on the removal of this API, see PodSecurityPolicy Deprecation: Past, Present, and Future.

If you are not running Kubernetes v1.31, check the documentation for your version of Kubernetes.

## Mastering Kubernetes Pod Security Policies (PSP)

Kubernetes Pod Security Policies (PSP) are a vital part of securing Kubernetes environments, providing granular security controls over the pod creation and operation within a Kubernetes cluster. This guide delves into the core concepts of PSPs, how they function, and best practices for their implementation and management. Understanding and effectively managing PSPs can help prevent unauthorized code execution and access within a Kubernetes cluster, enhancing the overall security posture of your applications.

## Understanding Pod Security Policies

Pod Security Policies are cluster-level resources that control security-sensitive aspects of the pod specification. The primary function of PSPs is to limit the capabilities of pods to minimize the potential impact of security vulnerabilities. PSPs enforce security settings by denying pod creation that does not comply with the policy rules.

## Key Features of PSPs

- **RunAsUser:** Controls the privileges of pods by defining the user ID that a pod can specify in its configuration.
- **Privileged:** Determines if a pod can run in a privileged mode, giving it access to host resources.
- **Volumes:** Defines the types of volumes that are permitted.
- **Host Network:** Controls whether a pod may configure its networking to access the host network.

## When to Use Pod Security Policies (PSP)

Pod Security Policies (PSP) are particularly useful in environments where security is a priority, and there is a need to enforce strict controls over how pods operate within a Kubernetes cluster. Understanding when to implement PSPs can help organizations better secure their applications and comply with security best practices.

## Multi-Tenant Clusters

In multi-tenant Kubernetes clusters, where multiple users or teams deploy their applications independently, PSPs are crucial. They prevent tenants from accessing cluster-wide resources and functionalities that could impact the stability and security of the cluster.

## Compliance and Regulatory Requirements

Organizations subject to regulatory compliance requirements such as PCI-DSS, HIPAA, or GDPR may use PSPs to enforce security configurations that comply with legal standards. PSPs ensure that containers do not run with elevated privileges unless absolutely necessary, and control access to host filesystems, networks, and other sensitive resources.

## Environments with Elevated Security Risks

In high-security environments, such as financial services or personal data processing applications, PSPs provide a layer of security that helps mitigate risks associated with running containerized applications. By restricting container capabilities, filesystem access, and network settings, PSPs reduce the potential attack surface of your cluster.

## Development and Production Parity

To maintain consistency between development and production environments, PSPs can be used to ensure that security settings are uniformly enforced across all stages of the application lifecycle. This prevents security oversights that might occur if developers run containers with more permissive settings than those allowed in production.

## Enhancing Cluster Security Posture

Even in less sensitive environments, PSPs improve the overall security posture of a Kubernetes cluster by enforcing best practices like running containers as non-root users and disabling unnecessary network traffic between pods. This proactive security measure helps prevent exploits and vulnerabilities from impacting the cluster.

## Example Scenario Use-Case: Implementing PSP in a Financial Services Company

**Scenario Description**\
Consider a financial services company that handles sensitive client data and is subject to stringent regulatory requirements. The company operates a Kubernetes cluster to manage a variety of applications, including online transaction processing and customer data management.

**Challenge**\
The company needs to ensure that its Kubernetes environment is secure from both internal and external threats, preventing any unauthorized access or escalation of privileges that could lead to data breaches or compliance violations. Additionally, the environment must adhere to regulations such as PCI-DSS, which require specific security measures for protecting payment information.

## Tutorial: Implementing Kubernetes Pod Security Policies (PSP) in a Financial Services Company

In this tutorial, we’ll explore how a financial services company can enhance the security of its Kubernetes clusters by implementing Pod Security Policies (PSP). These policies are essential for enforcing security settings that protect sensitive operations and comply with regulatory standards.

## Setting Up the Pod Security Policy

The first step in securing Kubernetes pods involves creating and applying a Pod Security Policy that dictates the security measures for pod operations.

1. Creating the Pod Security Policy\
We start by defining a PSP that disallows privileged containers, enforces non-root user operation, restricts host network access, and limits the types of volumes that can be mounted.

Create a file named psp.yaml with the following configuration:

```yaml
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: restricted-psp
spec:
  privileged: false  # Disallow privileged containers
  allowPrivilegeEscalation: false
  requiredDropCapabilities:
    - ALL  # Drop all capabilities
  volumes:
    - configMap
    - emptyDir
  hostNetwork: false  # Disallow host network access
  runAsUser:
    rule: 'MustRunAsNonRoot'  # Enforce running as non-root user
```
