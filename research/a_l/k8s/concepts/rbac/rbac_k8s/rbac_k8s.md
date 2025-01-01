# **[Limiting access to Kubernetes resources with RBAC](https://learnk8s.io/rbac-kubernetes)**

**[Current Status](../../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../../research_list.md)**\
**[Back Main](../../../../../../README.md)**

TL;DR In this article, you will learn how to recreate the Kubernetes RBAC authorization model from scratch and practice the relationships between Roles, ClusterRoles, ServiceAccounts, RoleBindings and ClusterRoleBindings.

As the number of applications and actors increases in your cluster, you might want to review and restrict the actions they can take.

For example, you might want to restrict access to production systems to a handful of individuals.

Or you might want to grant a narrow set of permissions to an operator deployed in the cluster.

The Role-Based Access Control (RBAC) framework in Kubernetes allows you to do just that.

## The Kubernetes API

Before discussing RBAC, let's see where the authorization model fits into the picture.

Let's imagine you wish to submit the following Pod to a Kubernetes cluster:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: sise
    image: ghcr.io/learnk8s/app:1.0.0
    ports:
    - containerPort: 8080
```

You could deploy the Pod to the cluster with:

```bash
kubectl apply -f pod.yaml
```

When you type kubectl apply, a few things happen.

The kubectl binary:

- Reads the configs from your KUBECONFIG.
- Discovers APIs and objects from the API.
- Validates the resource client-side (is there any obvious error?).
- Sends a request with the payload to the kube-apiserver.

When the kube-apiserver receives the request, it doesn't store it in etcd immediately.

First, it has to verify that the requester is legitimate.

In other words, it has to **[authenticate the request](https://kubernetes.io/docs/reference/access-authn-authz/authentication/)**.

Once authenticated, does the requester have permission to create the resource?

## Identity and permission are not the same things

Just because you have access to the cluster doesn't mean you can create or read all the resources.

The authorization is commonly done with **[Role-Based Access Control (RBAC)](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)**.

With Role-Based Access Control (RBAC), you can assign granular permissions and restrict what a user or app can do.

In more practical terms, the API server executes the following operations sequentially:

1. On receiving the request, authenticate the user.
    1. When the validation fails, reject the request by returning 401 Unauthorized.
    2. Otherwise, move on to the next stage.
2. The user is authenticated, but do they have access to the resource?
    1. If they don't, reject the request by returning 403 Forbidden.
    2. Otherwise, continue.

## Decoupling users and permission with RBAC roles

RBAC is a model designed to grant access to resources based on the roles of individual users within an organization.

To understand how that works, let's take a step back and imagine you had to design an authorization system from scratch.

How could you ensure that a user has write access to a particular resource?

A simple implementation could involve writing a list with three columns like this:

| User  | Permission | Resource |
| ----- | ---------- | -------- |
| Bob   | read+write |   app1   |
| Alice |    read    |   app2   |
| Mo    |    read    |   app2   |

In this example:

- Bob has read & write access to app1 but has no access to app2.
- Mo & Alice have only read access to app2 and have no access to app1.

The table works well with a few users and resources but shows some limitations as soon as you start to scale it.

Let's imagine that Mo & Alice are in the same team, and they are granted read access to app1.

You will have to add the following entries to your table:

| User      | Permission | Resource |
| --------- | ---------- | -------- |
| Bob       | read+write |   app1   |
| Alice     |    read    |   app2   |
| Mo        |    read    |   app2   |
| Alice     |    read    |   app1   |
| Mo        |    read    |   app1   |

That's great, but it is not evident that Alice and Mo have the same access because they are part of the same team.

You could solve this by adding a "Team" column to your table, but a better alternative is to break down the relationships:

- You could define a generic container for permissions: a role.
- Instead of assigning permissions to users, you could include them in the roles that reflect their role in the organisation.
- And finally, you could link roles to users.

Let's see how this is different.

Instead of having a single table, now you have two:

- In the first table, permissions are mapped to roles.
- In the second table, roles are linked to identities.

| Role     | Permission | Resource |
| -------- | ---------- | -------- |
| admin1   | read+write |   app1   |
| reviewer |    read    |   app2   |

| User  |   Roles  |
| ----- | -------- |
| Bob   |  admin1  |
| Alice | reviewer |
| Mo    | reviewer |

You can already imagine how decoupling users from permissions with Roles can facilitate security administration in large organizations with many users and permissions.

RBAC in Kubernetes
Kubernetes implements an RBAC model (as well as several other models) for protecting resources in the cluster.

So Kubernetes uses the same three concepts explained earlier: identities, roles and bindings.

It just calls them with slightly different names.

As an example, let's inspect the following YAML definition needed to grant access to Pods, Services, etc.:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: serviceaccount:app1
  namespace: demo-namespace
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: role:viewer
  namespace: demo-namespace
rules:          # Authorization rules for this role
  - apiGroups:  # 1st API group
      - ''      # An empty string designates the core API group.
    resources:
      - services
      - pods
    verbs:
      - get
      - list
  - apiGroups: # 2nd API group
      - apiextensions.k8s.io
    resources:
      - customresourcedefinitions
    verbs:
      - list
  - apiGroups: # 3rd API group
      - cilium.io
    resources:
      - ciliumnetworkpolicies
      - ciliumnetworkpolicies/status
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: rolebinding:app1-viewer
  namespace: demo-namespace
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: role:viewer
subjects:
  - kind: ServiceAccount
    name: serviceaccount:app1
    namespace: demo-namespace
```

The file is divided into three blocks:

- A Service Account — this is the identity of who is accessing the resources.
- A Role which includes the permission to access the resources.
- A RoleBinding that links the identity (Service Account) to the permissions (Role).

After submitting the definition to the cluster, the application that uses the Service Account is allowed to issue requests to the following endpoints:

```yaml
# 1. Kubernetes builtin resources
/api/v1/namespaces/{namespace}/services
/api/v1/namespaces/{namespace}/pods

# 2. A specific API extention provided by cilium.io
/apis/cilium.io/v2/namespaces/{namespace}/ciliumnetworkpolicies
/apis/cilium.io/v2/namespaces/{namespace}/ciliumnetworkpolicies/status
```

This is great, but there are a lot of details that we've glossed over.

What resources are you granting access to, exactly?

What is a Service Account? Aren't the identities just "Users" in the cluster?

Why does the Role contain a list of Kubernetes objects?

To understand how those work, let's set aside the Kubernetes RBAC model and try to rebuild it from scratch.

We will focus on three elements:

- Identifying and assigning identities.
- Granting permissions.
- Linking identities to permissions.

Let's start.

## Assigning identities: humans, bots and groups

Suppose your new colleague wishes to log in to the Kubernetes dashboard.

In this case, you should have an entity for an "account" or a "user", with each of them having a unique name or ID (such as the email address).

![ku](https://learnk8s.io/a/8f8ee1914c7f9741dd98393d2b2f3961.svg)

How should you store the User in the cluster?

Kubernetes does not have objects which represent regular user accounts.

Users cannot be added to a cluster through an API call.

**[Instead, any actor that presents a valid certificate signed by the cluster's certificate authority (CA) is considered authenticated.](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/#normal-user)**

In this scenario, Kubernetes assigns the username from the common name field in the 'subject' of the certificate (e.g., "/CN=bob").

A temporary User info object is created and passed to the authorization (RBAC) module.

Digging into the code reveals that a struct maps all of the details collected from the Authentication module.

```golang
type User struct {
    name string   // unique for each user
    ...           // other fields
}
```

Note that the User is used for human or processes outside the cluster.

If you want to identify a process in the cluster, you should use a Service Account instead.

The account is very similar to a regular user, but it's different because Kubernetes manages it.

A Service Account is usually assigned to pods to grant permissions.

For example, you could have the following applications accessing resources from inside the cluster:

- The cilium-agent has to list all pod resources on a specific node.
- The ingress-nginx-controller has to list all the backend endpoints for a service.

For those apps, you can define a ServiceAccount (SA).

![sa](https://learnk8s.io/a/fef79d23923d730817eb144a9114c06e.svg)

Since Service Accounts are managed in the cluster, you can create them with YAML:

service-account.yaml

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: sa:app1             # arbitrary but unique string
  namespace: demo-namespace
```

To facilitate Kubernetes administration, you could also define a group of Users or ServiceAccounts.

![ag](https://learnk8s.io/a/1eb4a62f694ee4280f973938597398ed.svg)

This is convenient if you wish to reference all ServiceAccounts in a specific namespace.

Now that you have defined how to access the resources, it's time to discuss the permissions.

Excellent!

At this point, you have a mechanism to identify who has access to resources.

It could be a human, a bot or a group of them.

But what resources are they accessing in the cluster?

## Modelling access to resources

In Kubernetes, we are interested in controlling access to resources such as Pods, Services, Endpoints, etc.

Those resources are usually stored in the database (etcd) and accessed via built-in APIs such as:

```bash
/api/v1/namespaces/{namespace}/pods/{name}
/api/v1/namespaces/{namespace}/pods/{name}/log
/api/v1/namespaces/{namespace}/serviceaccounts/{name}
```

The best way to limit access to those resources is to control how those API endpoints are requested.

You will need two things for that:

- The API endpoint of the resource.
- The type of permission granted to access the resource (e.g. read-only, read-write, etc.).

For the permissions, you will use a verb such as get, list, create, patch, delete, etc.

Imagine that you want to get, list and watch Pods, logs and Services.

You could combine those resources and permission in a list like this:

```yaml
resources:
  - /api/v1/namespaces/{namespace}/pods/{name}
  - /api/v1/namespaces/{namespace}/pods/{name}/log
  - /api/v1/namespaces/{namespace}/serviceaccounts/{name}
verbs:
  - get
  - list
  - watch
```

You could simplify the definition and make it more concise if you notice that:

- The base URL /api/v1/namespaces/ is common for all. Perhaps we could omit it.
- You could assume that all resources are in the current namespace and drop the {namespace} path.

That leads to:

```yaml
resources:
  - pods
  - pods/logs
  - serviceaccounts
verbs:
  - get
  - list
  - watch
```

The list is more human-friendly, and you can immediately identify what's going on.

There's more, though.

Besides APIs for built-in objects such as pods, endpoints, services, etc., Kubernetes also supports API extensions.

For example, when using install the Cilium CNI, the script creates a CiliumEndpoint custom resource (CR):

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: ciliumendpoints.cilium.io
spec:
  group: cilium.io
  names:
    kind: CiliumEndpoint
  scope: Namespaced
  # truncated...
```

Those objects are stored in the cluster and are available through kubectl:

```bash
kubectl get ciliumendpoints.cilium.io -n demo-namespace
NAME   ENDPOINT ID   IDENTITY ENDPOINT STATE   IPV4
IPV6
app1   2773          1628124  ready            10.6.7.54
app2   3568          1624494  ready            10.6.7.94
app3   3934          1575701  ready            10.6.4.24

```

The custom resources can be similarly accessed via the Kubernetes API:

```bash
/apis/cilium.io/v2/namespaces/{namespace}/ciliumendpoints
/apis/cilium.io/v2/namespaces/{namespace}/ciliumendpoints/{name}
```

If you want to map those into a YAML file, you could write the following:

```yaml
resources:
  - ciliumnetworkpolicies
  - ciliumnetworkpolicies/status
verbs:
  - get
```

However, how does Kubernetes know that the resources are custom?

How can it differentiate between APIs that use custom resources and built-in?

Unfortunately, dropping the base URL from the API endpoint wasn't such a good idea.

You could restore it with a slight change.

You could define it at the top and use it later to expand the URL for the resources.

```yaml
apiGroups:
  - cilium.io     # APIGroup name
resources:
  - ciliumnetworkpolicies
  - ciliumnetworkpolicies/status
verbs:
  - get
```

What about resources such as Pods that don't have a namespaced API?

The Kubernetes "" empty API group is a special group that refers to the built-in objects.

So the previous definition should be expanded to:

```yaml
apiGroups:
  - '' # Built-in objects
resources:
  - pods
  - pods/logs
  - serviceaccounts
verbs:
  - get
  - list
  - watch
```

Kubernetes reads the API group and automatically expands them to:

- If it is empty "" to /api/v1/xxx.
- Otherwise /apis/{apigroup_name}/{apigroup_version}/xxx.

![ag](https://learnk8s.io/a/79a9f5ff5bda527e673095cb3074b58a.svg)

Now that you know how to map resources and permissions, it's finally time to glue access to multiple resources together.

In Kubernetes, a collection of resources and verbs is called a Rule, and you can group rules into a list:

```yaml
rules:
  - rule 1
  - rule 2
```

Each rule contains the apiGroups, resources and verbs that you just learned:

```yaml
rules: # Authorization rules
  - apiGroups: # 1st API group
      - '' # An empty string designates the core API group.
    resources:
      - pods
      - pods/logs
      - serviceaccounts
    verbs:
      - get
      - list
      - watch
  - apiGroups: # another API group
      - cilium.io # Custom APIGroup
    resources:
      - ciliumnetworkpolicies
      - ciliumnetworkpolicies/status
    verbs:
      - get
```

![r](https://learnk8s.io/a/775b3716d7dc59b4fea0d4990aa23350.svg)

A collection of rules has a specific name in Kubernetes, and it is called a Role.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: viewer
rules: # Authorization rules
  - apiGroups: # 1st API group
      - '' # An empty string designates the core API group.
    resources:
      - pods
      - pods/logs
      - serviceaccounts
    verbs:
      - get
      - list
      - watch
  - apiGroups: # another API group
      - cilium.io # Custom APIGroup
    resources:
      - ciliumnetworkpolicies
      - ciliumnetworkpolicies/status
    verbs:
      - get
```

![rr](https://learnk8s.io/a/9c3b733934dc66764a96f9938e581edd.svg)

Excellent!

So far, you modelled:

- Identities with Users, Service Accounts and Groups.
- Permissions to resources with Roles.
- The missing part is linking the two.

## Granting permissions to users

A RoleBinding grants the permissions defined in a Role to a User, Service Account or Group.

Let's have a look at an example:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: role-binding-for-app1
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: viewer
subjects:
  - kind: ServiceAccount
    name: sa-for-app1
    namespace: kube-system
```

The definition has two important fields:

- the roleRef that references the viewer Role.
- the subjects links to the sa-for-app1 Service Account.

As soon as you submit the resource to the cluster, the application or user using the Service Account will have access to the resources listed in the Role.

If you remove the binding, the app or user will lose access to those resources (but the Role will stay ready to be used by other bindings).

Note how the subjects field is a list that contains kind, name and namespace.

The kind property is necessary to identify Users from Service Accounts and Groups.

But what about namespace?

It's often helpful to break the cluster up into namespaces and limit access to namespaced resources to specific accounts.

In most cases, Roles and RoleBindings are placed inside and grant access to a specific namespace.

However, it is possible to mix these two types of resources — you will see how later.

Before we wrap up the theory and start with the practice, let's have a look at a few examples for the subjects field:

```yaml
subjects:
  - kind: Group
    name: system:serviceaccounts
    apiGroup: rbac.authorization.k8s.io
    # when the namespace field is not specified, this targets all service accounts in all namespace
```

You can also have multiple Groups, Users or Service Accounts as subjects:

```yaml
subjects:
  - kind: Group
    name: system:authenticated # for all authenticated users
    apiGroup: rbac.authorization.k8s.io
  - kind: Group
    name: system:unauthenticated # for all unauthenticated users
    apiGroup: rbac.authorization.k8s.io
```

To recap what you've learned so far, let's look at how to grant permissions for an app to access some custom resources.

First, let's present the challenge: you have an app that needs access to the resources exposed by Cilium.

![p1](https://learnk8s.io/a/fa7feb629303d64d367b5057d93dd081.svg)

Imagine having an app deployed in the cluster that needs to access a Custom Resource through the API.

Next
How can you grant permissions to access those resources?

With a Service Account, Role and RoleBinding.

![ap](https://learnk8s.io/a/8841224b1d01d882f875cb4ab48aa446.svg)

1. create a Service Account or group.
2. Create a Rule with resource and verb
3. Create a role containing all the rules needed for an entity
4. Bind the role to entity with a role binding.

![ad](https://learnk8s.io/a/5aea06c5814c224cd2b8dddaf1b42ac3.svg)

First, you should create an identity for your workload. In Kubernetes, that means creating a Service Account.

## Namespaces and cluster-wide resources

When we discussed the resources, you learned that the structure of the endpoints is similar to this:

```bash
/api/v1/namespaces/{namespace}/pods/{name}
/api/v1/namespaces/{namespace}/pods/{name}/log
/api/v1/namespaces/{namespace}/serviceaccounts/{name}
```

But what about resources that don't have a namespace, such as Persistent Volumes and Nodes?

Namespaced resources can only be created within a namespace, and the name of that namespace is included in the HTTP path.

If the resource is global, like in the case of a Node, the namespaces name is not present in the HTTP path.

```bash
/api/v1/nodes/{name}
/api/v1/persistentvolume/{name}
```

Can you add those to a Role?

You can.

After all, we did not discuss any namespace limitation when Roles and RoleBindings were introduced.

Here's an example:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: viewer
rules: # Authorization rules
  - apiGroups: # 1st API group
      - '' # An empty string designates the core API group.
    resources:
      - persistentvolumes
      - nodes
    verbs:
      - get
      - list
      - watch
```

If you try to submit that definition and link it to a Service Account, you might realize it doesn't work, though.

Persistent Volumes and Nodes are cluster-scoped resources.

However, Roles can grant access to scoped resources to a namespace.

If you'd like to use a Role that applies to the entire cluster, you can use a ClusterRole (and the corresponding ClusterRoleBinding to assign it a subject).

The previous definition should be changed to:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: viewer
rules:          # Authorization rules
  - apiGroups:  # 1st API group
      - ''      # An empty string designates the core API group.
    resources:
      - persistentvolumes
      - nodes
    verbs:
      - get
      - list
      - watch
```

Notice how the only change is the kind property, and everything else stays the same.

You can use ClusterRoles to grant permissions to all resources — for example, all Pods in the cluster.

This functionality isn't restricted to cluster-scoped resources.

Kubernetes ships with a few Roles and ClusterRoles already.

Let's explore them.

```bash
kubectl get roles -n kube-system | grep "^system:"
NAME
system::leader-locking-kube-controller-manager
system::leader-locking-kube-scheduler
system:controller:bootstrap-signer
system:controller:cloud-provider
system:controller:token-cleaner
# truncated output...
```

Many are system: prefixed to denote that the resource is directly managed by the cluster control plane.

Besides, all of the default ClusterRoles and ClusterRoleBindings are labelled with kubernetes.io/bootstrapping=rbac-defaults.

Let's also list the ClusterRoles with:

```bash
kubectl get clusterroles -n kube-system | grep "^system:"
NAME
system:aggregate-to-admin
system:aggregate-to-edit
system:aggregate-to-view
system:discovery
system:kube-apiserver
system:kube-controller-manager
system:kube-dns
system:kube-scheduler
# truncated output...
```

You can inspect the details for each Role and ClusterRole with:

bash
kubectl get role <role> -n kube-system -o yaml

# or

kubectl get clusterrole <clusterrole> -n kube-system -o yaml
Excellent!

At this point, you know the basic building blocks of Kubernetes RBAC.

You learned:

- How to create identities with Users, Service Accounts and groups.
- How to assign permissions to resources in a namespace with a Role.
- How to assign permissions to cluster resources with a ClusterRole.
- How to link Roles and ClusterRoles to subjects.

There's only one missing topic left to explore: a few unusual edge cases of RBAC.
