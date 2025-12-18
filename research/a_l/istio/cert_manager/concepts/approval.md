# **[Approval](https://cert-manager.io/docs/usage/certificaterequest/#approval)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Secure your Microservices Ingress in Istio with Let’s Encrypt](https://invisibl.io/blog/secure-your-microservices-ingress-in-istio-with-lets-encrypt/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

CertificateRequests can be Approved or Denied. These mutually exclusive conditions gate a CertificateRequest from being signed by its managed signer.

- A signer should not sign a managed CertificateRequest without an Approved condition
- A signer will sign a managed CertificateRequest with an Approved condition
- A signer will never sign a managed CertificateRequest with a Denied condition

These conditions are permanent, and cannot be modified or changed once set.

```bash
NAMESPACE      NAME                    APPROVED   DENIED   READY   ISSUER       REQUESTOR                                         AGE
istio-system   service-mesh-ca-whh5b   True                True    mesh-ca      system:serviceaccount:istio-system:istiod         16s
istio-system   my-app-fj9sa                       True             mesh-ca      system:serviceaccount:my-app:my-app               4s
```

## Behavior

The Approved and Denied conditions are two distinct condition types on the CertificateRequest. These conditions must only have the status of True, and are mutually exclusive (i.e. a CertificateRequest cannot have an Approved and Denied condition simultaneously). This behavior is enforced in the cert-manager validating admission webhook.

An "approver" is an entity that is responsible for setting the Approved/Denied conditions. It is up to the approver's implementation as to what CertificateRequests are managed by that approver.

The Reason field of the Approved/Denied condition should be set to who set the condition. Who can be interpreted however makes sense to the approver implementation. For example, it may include the API group of an approving policy controller, or the client agent of a manual request.

The Message field of the Approved/Denied condition should be set to why the condition is set. Again, why can be interpreted however makes sense to the implementation of the approver. For example, the name of the resource that approves this request, the violations which caused the request to be denied, or the team to who manually approved the request.

## Approver Controller

By default, cert-manager will run an internal approval controller which will automatically approve all CertificateRequests that reference any internal issuer type in any namespace: cert-manager.io/Issuer, cert-manager.io/ClusterIssuer.

Disabling the internal auto approver:

To disable this controller, in the Helm chart set the disableAutoApproval value to true:

```bash
# ⚠️ This Helm option is only available in cert-manager v1.15.0 and later.
--set disableAutoApproval=true
```

## **Approving additional issuers using the internal auto approver:**

Alternatively, in order for the internal approver controller to approve CertificateRequests that reference an external issuer, in the Helm chart add the issuers to the approveSignerNames list, or set the approveSignerNames value to an empty list to approve all issuers (internal and external).

```bash
# ⚠️ This Helm option is only available in cert-manager v1.15.0 and later.
--set approveSignerNames[0]="issuers.cert-manager.io/*" \
--set approveSignerNames[1]="clusterissuers.cert-manager.io/*" \
\
--set approveSignerNames[2]="issuers.my-issuer.example.com/*" \
--set approveSignerNames[3]="clusterissuers.my-issuer.example.com/*"
```

## RBAC Syntax

When a user or controller attempts to approve or deny a CertificateRequest, the cert-manager webhook will evaluate whether it has sufficient permissions to do so. These permissions are based upon the request itself- specifically the request's IssuerRef:

```yaml
apiGroups: ["cert-manager.io"]
resources: ["signers"]
verbs: ["approve"]
resourceNames:
 # namesapced signers
 - "<signer-resource-name>.<signer-group>/<signer-namespace>.<signer-name>"
 # cluster scoped signers
 - "<signer-resource-name>.<signer-group>/<signer-name>"
 # all signers of this resource name
 - "<signer-resource-name>.<signer-group>/*"
```

An example ClusterRole that would grant the permissions to set the Approve and Denied conditions of CertificateRequests that reference the cluster scoped myissuers external issuer, in the group my-example.io, with the name myapp:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: my-example-io-my-issuer-myapp-approver
rules:
  - apiGroups: ["cert-manager.io"]
    resources: ["signers"]
    verbs: ["approve"]
    resourceNames: ["myissuers.my-example.io/myapp"]
```

If the approver does not have sufficient permissions defined above to set the Approved or Denied conditions, the request will be rejected by the cert-manager validating admission webhook.

## The RBAC permissions must be granted at the cluster scope

- Namespaced signers are represented by a namespaced resource using the syntax of `<signer-resource-name>.<signer-group>/<signer-namespace>.<signer-name>`
- Cluster scoped signers are represented using the syntax of `<signer-resource-name>.<signer-group>/<signer-name>`
- An approver can be granted approval for all namespaces via `<signer-resource-name>.<signer-group>/`
- The apiGroup must always be cert-manager.io
- The resource must always be signers
- The verb must always be approve, which grants the approver the permissions to set both Approved and Denied conditions

An example of signing all myissuer signers in all namespaces, and clustermyissuers with the name myapp, in the my-example.io group:

```yaml
resourceNames: ["myissuers.my-example.io/*", "clustermyissuers.my-example.io/myapp"]
```

An example of signing myissuer with the name myapp in the namespaces foo and bar:

```yaml
resourceNames: ["myissuers.my-example.io/foo.myapp", "myissuers.my-example.io/bar.myapp"]
```

Inner workings diagram for developers

![cmf](https://cert-manager.io/images/request-certificate-debug/certificate-request-flow.svg)
