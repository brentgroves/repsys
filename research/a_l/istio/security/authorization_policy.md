# **[Authorization Policy](https://istio.io/latest/docs/reference/config/security/authorization-policy/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[External Authorization via OIDC](https://www.digihunch.com/2022/02/istio-external-authorization/)**
- **[conditions page](https://istio.io/latest/docs/reference/config/security/conditions/)**

Istio Authorization Policy enables access control on workloads in the mesh.

Authorization policy supports CUSTOM, DENY and ALLOW actions for access control. When CUSTOM, DENY and ALLOW actions are used for a workload at the same time, the CUSTOM action is evaluated first, then the DENY action, and finally the ALLOW action. The evaluation is determined by the following rules:

- If there are any CUSTOM policies that match the request, evaluate and deny the request if the evaluation result is deny.
- If there are any DENY policies that match the request, deny the request.
- If there are no ALLOW policies for the workload, allow the request.
- If any of the ALLOW policies match the request, allow the request.
- Deny the request.

Istio Authorization Policy also supports the AUDIT action to decide whether to log requests. AUDIT policies do not affect whether requests are allowed or denied to the workload. Requests will be allowed or denied based solely on CUSTOM, DENY and ALLOW actions.

A request will be internally marked that it should be audited if there is an AUDIT policy on the workload that matches the request. A separate plugin must be configured and enabled to actually fulfill the audit decision and complete the audit behavior. The request will not be audited if there are no such supporting plugins enabled.

Here is an example of Istio Authorization Policy:

It sets the action to ALLOW to create an allow policy. The default action is ALLOW but it is useful to be explicit in the policy.

It allows requests from:

- service account cluster.local/ns/default/sa/sleep or
- namespace test

to access the workload with:

- GET method at paths of prefix /info or,
- POST method at path /data.

when the request has a valid JWT token issued by <https://accounts.google.com>.

Any other requests will be denied.

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: httpbin
  namespace: foo
spec:
  action: ALLOW
  rules:
  - from:
    - source:
        principals: ["cluster.local/ns/default/sa/sleep"]
    - source:
        namespaces: ["test"]
    to:
    - operation:
        methods: ["GET"]
        paths: ["/info*"]
    - operation:
        methods: ["POST"]
        paths: ["/data"]
    when:
    - key: request.auth.claims[iss]
      values: ["https://accounts.google.com"]
```
