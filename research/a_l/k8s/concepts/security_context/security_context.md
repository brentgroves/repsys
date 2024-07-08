# **[security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[k8s security context](https://www.aquasec.com/cloud-native-academy/kubernetes-in-production/kubernetes-security-context/)**

## Configure a Security Context for a Pod or Container

A security context defines privilege and access control settings for a Pod or Container. Security context settings include, but are not limited to:

- Discretionary Access Control: Permission to access an object, like a file, is based on **[user ID (UID) and group ID (GID)](https://wiki.archlinux.org/index.php/users_and_groups)**.

- **[Security Enhanced Linux (SELinux)](https://en.wikipedia.org/wiki/Security-Enhanced_Linux)**: Objects are assigned security labels. This MAC is active in debian and k8s but not in ubuntu in which apparmor seems more used.
- Running as privileged or unprivileged.
- **[Linux Capabilities:](https://linux-audit.com/linux-capabilities-hardening-linux-binaries-by-removing-setuid/)** Give a process some privileges, but not all the privileges of the root user.

## **[What Is Kubernetes Security Context?](https://www.aquasec.com/cloud-native-academy/kubernetes-in-production/kubernetes-security-context/)**

Kubernetes is an open-source platform that automates the deployment, scaling, and management of containerized applications. A Kubernetes security context is a set of security settings that are applied at the pod or container level. It provides you with the ability to define privilege and access controls for pods or containers.

You can set a security context as part of a pod’s deployment manifest, typically defined as a YAML file. It looks like this:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
```

from **[sql server stateful](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-kubernetes-best-practices-statefulsets?view=sql-server-ver16)** set yaml

```yaml
   securityContext:
     fsGroup: 10001
```

There are two types of security contexts in Kubernetes:

- Internal security context: Defined and enforced internally by Kubernetes.
- External security context: Defined and enforced by software deployed on the Kubernetes node—typically SELinux or AppArmor.

## Kubernetes Security Context vs. RBAC vs. Pod Security Policies: What Is the Difference?

Kubernetes Security Context, Role Based Access Control (RBAC), and Pod Security Policies (PSP) are three different security mechanisms provided by Kubernetes. Let’s understand the differences between them:

- **Security Context** governs the security parameters that a specific pod or container should adhere to. It defines privilege and access control settings, letting you specify what capabilities the pod or container should have within your Kubernetes environment.
- **Role-Based Access Control** lets you regulate access to resources in your cluster based on the roles of individual users within your Kubernetes environment. With RBAC, you can define what endpoints an entity (user, group, or service account) can and cannot access. This is accomplished by associating roles (which are collections of permissions) with the entities that need them. RBAC is commonly used together with the Kubernetes Security Context.
- **Pod Security Policies (PSP)** are cluster-level resources that control security-sensitive aspects of the pod specification. Unlike security context, PSP affects all pods in a cluster, so it is less granular than the security context. The Kubernetes project has deprecated the PSP feature, and while you can still use it, the Kubernetes documentation recommends migrating from PSP to the Kubernetes security context.  

## Kubernetes Security Context Syntax and Options

Here is an example of a security context, adapted from the **[Kubernetes documentation:](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
  volumes:
  - name: sec-ctx-vol
    emptyDir: {}
  containers:
  - name: sec-ctx-demo
    image: busybox:1.28
    command: [ "sh", "-c", "sleep 1h" ]
    volumeMounts:
    - name: sec-ctx-vol
      mountPath: /data/demo
    securityContext:
      capabilities:
        add: ["NET_ADMIN", "SYS_TIME"]
      readOnlyRootFilesystem: true
```

Let’s review the main options you can specify in this configuration.

## User and Group Settings

By default, containers will run with the root user on the host operating system. However, you can specify a different user or group by using the runAsUser and runAsGroup fields in your security context. This ensures that if someone were to compromise your container, they would not have the full privileges of the root user on the host system. This also allows you to segregate duties and restrict access to certain resources within your system.

## Capabilities Settings

**Linux capabilities** are a type of kernel security feature that allows you to grant certain privileges to processes without giving them full root access. This is particularly useful when running containers, as it allows you to restrict the actions that a container can perform on the host system.

In the security context configuration, you can add or drop specific capabilities using the capabilities field. For instance, you can drop the NET_RAW capability to prevent your container from sending or receiving raw packets, enhancing the network security of your system.

## FSGroup Settings

The fsGroup setting in a Kubernetes security context is used to define the filesystem group ID that owns the volume’s files and directories. When used, all processes of the container are also part of this supplementary group. The volumes that support ownership management are modified to be owned and writable by the GID specified in fsGroup.

This setting is crucial in managing file permissions and maintaining secure access to your Kubernetes volumes. It allows you to ensure that only the intended users and groups have the right permissions to access your data.

## readOnlyRootFilesystem Flag

The readOnlyRootFileSystem flag is another important component of the Kubernetes security context. When this flag is set to true, it indicates that the container has a read-only root filesystem.

A read-only filesystem can significantly increase the security of your containers. It prevents any writes to the filesystem, thus blocking any attempts by an attacker to install malicious software or modify system files.

## AllowPrivilegeEscalation Flag

The AllowPrivilegeEscalation flag controls whether a process can gain more privileges than its parent process. When set to false, it ensures that the process and its child processes do not gain additional privileges. This can be critical in preventing privilege escalation attacks, where an attacker gains elevated access to resources that are normally protected from an application or user.

## Defining an External Security Context

To define an external security context, the first step involves ensuring the relevant security module is installed and loaded on every potential host node in the Kubernetes cluster. We’ll focus our discussion on SELinux, but you can follow a similar process with AppArmor.

After activating the SELinux module, load the appropriate SELinux profile to define the desired permissions. It is crucial to store this profile in each node’s filesystem at a location accessible by Kubernetes.

Finally, you integrate the external security context into your Kubernetes deployment by adding a dedicated block in your deployment file. This block should reference the SELinux profile, as shown in the example below:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: apparmor-demo
  annotations:
    container.apparmor.security.beta.kubernetes.io/hello: /path/to/policy-file
```

To apply this configuration, run the command kubectl create -f ./<your-deployment>.yml. Kubernetes will then enforce the SELinux security policy for all nodes created by the deployment.

## Common Use Cases for Security Contexts

### Running Containers as a Non-root User

One of the most common use cases for Kubernetes security contexts is running containers as a non-root user. This is a best practice in container security as it limits the potential damage if a container is compromised. By specifying a non-root user in the runAsUser field, you can ensure that your containers are running with the least amount of privilege necessary.

### Granting Limited Access to Host Resources

Another use case for security contexts is to grant limited access to host resources. This can be done using Linux capabilities settings. For instance, you might want to allow a container to bind to privileged ports (those numbered less than 1024), but not provide it with any other root-level privileges. In this case, you can add the NET_BIND_SERVICE capability to your security context.

### Managing File Permissions and Ownership

Lastly, Security Contexts can be used to manage file permissions and ownership in your Kubernetes volumes. By using the fsGroup and runAsUser settings, you can control who has access to your files and directories, and what they can do with them. This can be important in maintaining the confidentiality, integrity, and availability of your data.

## Limitations of Kubernetes Security Context

Here are a few key limitations to be aware of when using the Kubernetes security context:

### Lack of Compatibility with Windows

At present, the security context only affects permissions and privileges relevant for a Linux-based server. If your Kubernetes environment has Windows containers, you can’t use security contexts for those containers and the pods running them.

## Restricted to Pod/Container-Level Security

Security contexts don’t regulate privileges across all layers of your stack. It’s true that the majority of context rules are most effective when enforced on containers or pods (for example, specifying that a container should run without root privileges).

However, in some cases security concerns go beyond the scope of a container or pod. To protect nodes, users, service accounts, and other types of resources, you should combine security contexts with cluster-level RBAC.

## Feature Under Development

The Kubernetes security context is a relatively new addition to Kubernetes, and is still evolving. Some features are still at beta stage, and new capabilities are being introduced over time. When using security contexts in live clusters, you must be aware of the ongoing evolution of this feature, because certain definitions or configurations might not be supported or might work differently in the future.

## Complex Setup

As mentioned, you must set up SELinux or AppArmor profiles on every node on which you want to apply a security context. While there are methods to streamline this setup, setting up these tools on every node can be laborious. If different nodes use different Linux distributions, deployment could become quite complex, with different SELinux or AppArmor configurations for each distribution.

## Combine with Other Kubernetes Security Mechanisms

Kubernetes security context is a powerful feature, but it’s not the only security tool at your disposal. For best results, integrate it with other security mechanisms in the Kubernetes ecosystem. These include Role-Based Access Control (RBAC), network policies, and Kubernetes Secrets.
