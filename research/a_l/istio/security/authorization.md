# **[Authorization](https://istio.io/latest/docs/concepts/security/#authorization)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

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
  - The from field in the rules specifies the sources of the request
  - The to field in the rules specifies the operations of the request
  - The when field specifies the conditions needed to apply the rule

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
