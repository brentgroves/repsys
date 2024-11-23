# **[Authorization](https://istio.io/latest/docs/concepts/security/#authorization)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[conditions page](https://istio.io/latest/docs/reference/config/security/conditions/)**

Istio’s authorization features provide mesh-, namespace-, and workload-wide access control for your workloads in the mesh. This level of control provides the following benefits:

- Workload-to-workload and end-user-to-workload authorization.
- A simple API: it includes a single AuthorizationPolicy CRD, which is easy to use and maintain.
- Flexible semantics: operators can define custom conditions on Istio attributes, and use CUSTOM, DENY and ALLOW actions.
- High performance: Istio authorization (ALLOW and DENY) is enforced natively on Envoy.
- High compatibility: supports gRPC, HTTP, HTTPS and HTTP/2 natively, as well as any plain TCP protocols.

## Authorization architecture

The authorization policy enforces access control to the inbound traffic in the server side Envoy proxy. Each Envoy proxy runs an authorization engine that authorizes requests at runtime. When a request comes to the proxy, the authorization engine evaluates the request context against the current authorization policies, and returns the authorization result, either ALLOW or DENY. Operators specify Istio authorization policies using .yaml files.

![aa](https://istio.io/latest/docs/concepts/security/authz.svg)

## Implicit enablement

You don’t need to explicitly enable Istio’s authorization features; they are available after installation. To enforce access control to your workloads, you apply an authorization policy.

For workloads without authorization policies applied, Istio allows all requests.

Authorization policies support ALLOW, DENY and CUSTOM actions. You can apply multiple policies, each with a different action, as needed to secure access to your workloads.

Istio checks for matching policies in layers, in this order: CUSTOM, DENY, and then ALLOW. For each type of action, Istio first checks if there is a policy with the action applied, and then checks if the request matches the policy’s specification. If a request doesn’t match a policy in one of the layers, the check continues to the next layer.

The following graph shows the policy precedence in detail:

![ap](https://istio.io/latest/docs/concepts/security/authz-eval.svg)

When you apply multiple authorization policies to the same workload, Istio applies them additively.

## Authorization policies

To configure an authorization policy, you create an AuthorizationPolicy custom resource. An authorization policy includes a selector, an action, and a list of rules:

- The selector field specifies the target of the policy
- The action field specifies whether to allow or deny the request
- The rules specify when to trigger the action
  - The `from` field in the rules specifies the sources of the request
  - The `to` field in the rules specifies the operations of the request
  - The `when` field specifies the conditions needed to apply the rule

The following example shows an authorization policy that allows two sources, the cluster.local/ns/default/sa/curl service account and the dev namespace, to access the workloads with the app: httpbin and version: v1 labels in the foo namespace when requests sent have a valid JWT token.

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
 name: httpbin
 namespace: foo
spec:
 selector:
   matchLabels:
     app: httpbin
     version: v1
 action: ALLOW
 rules:
 - from:
   - source:
       principals: ["cluster.local/ns/default/sa/curl"]
   - source:
       namespaces: ["dev"]
   to:
   - operation:
       methods: ["GET"]
   when:
   - key: request.auth.claims[iss]
     values: ["https://accounts.google.com"]
```

The following example shows an authorization policy that denies requests if the source is not the foo namespace:

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
 name: httpbin-deny
 namespace: foo
spec:
 selector:
   matchLabels:
     app: httpbin
     version: v1
 action: DENY
 rules:
 - from:
   - source:
       notNamespaces: ["foo"]
```

The deny policy takes precedence over the allow policy. Requests matching allow policies can be denied if they match a deny policy. Istio evaluates deny policies first to ensure that an allow policy can’t bypass a deny policy.

## Policy Target

You can specify a policy’s scope or target with the metadata/namespace field and an optional selector field. A policy applies to the namespace in the metadata/namespace field. If set its value to the root namespace, the policy applies to all namespaces in a mesh. The value of the root namespace is configurable, and the default is istio-system. If set to any other namespace, the policy only applies to the specified namespace.

You can use a selector field to further restrict policies to apply to specific workloads. The selector uses labels to select the target workload. The selector contains a list of {key: value} pairs, where the key is the name of the label. If not set, the authorization policy applies to all workloads in the same namespace as the authorization policy.

For example, the allow-read policy allows "GET" and "HEAD" access to the workload with the app: products label in the default namespace.

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: allow-read
  namespace: default
spec:
  selector:
    matchLabels:
      app: products
  action: ALLOW
  rules:
  - to:
    - operation:
         methods: ["GET", "HEAD"]
```

## Value matching

Most fields in authorization policies support all the following matching schemas:

- Exact match: exact string match.
- Prefix match: a string with an ending "*". For example, "test.abc.*" matches "test.abc.com", "test.abc.com.cn", "test.abc.org", etc.
- Suffix match: a string with a starting "*". For example, "*.abc.com" matches "eng.abc.com", "test.eng.abc.com", etc.
- Presence match: `*` is used to specify anything but not empty. To specify that a field must be present, use the fieldname: ["*"]format. This is different from leaving a field unspecified, which means match anything, including empty.

There are a few exceptions. For example, the following fields only support exact match:

- The key field under the when section
- The ipBlocks under the source section
- The ports field under the to section

The following example policy allows access at paths with the `/test/*` prefix or the `*/info` suffix.

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: tester
  namespace: default
spec:
  selector:
    matchLabels:
      app: products
  action: ALLOW
  rules:
  - to:
    - operation:
        paths: ["/test/*", "*/info"]
```

## Exclusion matching

To match negative conditions like notValues in the when field, notIpBlocks in the source field, notPorts in the to field, Istio supports exclusion matching. The following example requires a valid request principals, which is derived from JWT authentication, if the request path is not /healthz. Thus, the policy excludes requests to the /healthz path from the JWT authentication:

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: disable-jwt-for-healthz
  namespace: default
spec:
  selector:
    matchLabels:
      app: products
  action: ALLOW
  rules:
  - to:
    - operation:
        notPaths: ["/healthz"]
    from:
    - source:
        requestPrincipals: ["*"]
```

The following example denies the request to the /admin path for requests without request principals:

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: enable-jwt-for-admin
  namespace: default
spec:
  selector:
    matchLabels:
      app: products
  action: DENY
  rules:
  - to:
    - operation:
        paths: ["/admin"]
    from:
    - source:
        notRequestPrincipals: ["*"]
```

## allow-nothing, deny-all and allow-all policy

The following example shows an ALLOW policy that matches nothing. If there are no other ALLOW policies, requests will always be denied because of the “deny by default” behavior.

Note the “deny by default” behavior applies only if the workload has at least one authorization policy with the ALLOW action.

It is a good security practice to start with the allow-nothing policy and incrementally add more ALLOW policies to open more access to the workload.

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: allow-nothing
spec:
  action: ALLOW
  # the rules field is not specified, and the policy will never match.
```

The following example shows a DENY policy that explicitly denies all access. It will always deny the request even if there is another ALLOW policy allowing the request because the DENY policy takes precedence over the ALLOW policy. This is useful if you want to temporarily disable all access to the workload.

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: deny-all
spec:
  action: DENY
  # the rules field has an empty rule, and the policy will always match.
  rules:
  - {}
```

The following example shows an ALLOW policy that allows full access to the workload. It will make other ALLOW policies useless as it will always allow the request. It might be useful if you want to temporarily expose full access to the workload. Note the request could still be denied due to CUSTOM and DENY policies.

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: allow-all
spec:
  action: ALLOW
  # This matches everything.
  rules:
  - {}
```

## Custom conditions

You can also use the when section to specify additional conditions. For example, the following AuthorizationPolicy definition includes a condition that request.headers[version] is either "v1" or "v2". In this case, the key is request.headers[version], which is an entry in the Istio attribute request.headers, which is a map.

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
 name: httpbin
 namespace: foo
spec:
 selector:
   matchLabels:
     app: httpbin
     version: v1
 action: ALLOW
 rules:
 - from:
   - source:
       principals: ["cluster.local/ns/default/sa/curl"]
   to:
   - operation:
       methods: ["GET"]
   when:
   - key: request.headers[version]
     values: ["v1", "v2"]
```

The supported key values of a condition are listed on the **[conditions page](https://istio.io/latest/docs/reference/config/security/conditions/)**.

## Authenticated and unauthenticated identity

If you want to make a workload publicly accessible, you need to leave the source section empty. This allows sources from all (both authenticated and unauthenticated) users and workloads, for example:

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
 name: httpbin
 namespace: foo
spec:
 selector:
   matchLabels:
     app: httpbin
     version: v1
 action: ALLOW
 rules:
 - to:
   - operation:
       methods: ["GET", "POST"]
```

## To allow only authenticated users, set principals to "*" instead

for example:

```
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
 name: httpbin
 namespace: foo
spec:
 selector:
   matchLabels:
     app: httpbin
     version: v1
 action: ALLOW
 rules:
 - from:
   - source:
       principals: ["*"]
   to:
   - operation:
       methods: ["GET", "POST"]
```

## Using Istio authorization on plain TCP protocols

Istio authorization supports workloads using any plain TCP protocols, such as MongoDB. In this case, you configure the authorization policy in the same way you did for the HTTP workloads. The difference is that certain fields and conditions are only applicable to HTTP workloads. These fields include:

- The request_principals field in the source section of the authorization policy object
- The hosts, methods and paths fields in the operation section of the authorization policy object

The supported conditions are listed in the **[conditions page](https://istio.io/latest/docs/reference/config/security/conditions/)**. If you use any HTTP only fields for a TCP workload, Istio will ignore HTTP-only fields in the authorization policy.

Assuming you have a MongoDB service on port 27017, the following example configures an authorization policy to only allows the bookinfo-ratings-v2 service in the Istio mesh to access the MongoDB workload.

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: mongodb-policy
  namespace: default
spec:
 selector:
   matchLabels:
     app: mongodb
 action: ALLOW
 rules:
 - from:
   - source:
       principals: ["cluster.local/ns/default/sa/bookinfo-ratings-v2"]
   to:
   - operation:
       ports: ["27017"]
```

## Dependency on mutual TLS

Istio uses mutual TLS to securely pass some information from the client to the server. Mutual TLS must be enabled before using any of the following fields in the authorization policy:

- the principals and notPrincipals field under the source section
the namespaces and notNamespaces field under the source section
- the source.principal custom condition
- the source.namespace custom condition

Note it is strongly recommended to always use these fields with strict mutual TLS mode in the PeerAuthentication to avoid potential unexpected requests rejection or policy bypass when plain text traffic is used with the permissive mutual TLS mode.

Check the **[security advisory](https://istio.io/latest/news/security/istio-security-2021-004/)** for more details and alternatives if you cannot enable strict mutual TLS mode.

## Learn more

After learning the basic concepts, there are more resources to review:

- Try out the security policy by following the authentication and authorization tasks.
- Learn some security policy examples that could be used to improve security in your mesh.
- Read common problems to better troubleshoot security policy issues when something goes wrong.

## See also

Dry Run
Shows how to dry-run an authorization policy without enforcing it.

Explicit Deny
Shows how to set up access control to deny traffic explicitly.

External Authorization
Shows how to integrate and delegate access control to an external authorization system.

HTTP Traffic
Shows how to set up access control for HTTP traffic.

**[Ingress Access Control](https://istio.io/latest/docs/tasks/security/authorization/authz-ingress/)**
Shows how to set up access control on an ingress gateway.

TCP Traffic
Shows how to set up access control for TCP traffic.
