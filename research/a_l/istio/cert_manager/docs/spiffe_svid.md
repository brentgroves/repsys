# **[SPIFFE Verifiable Identity Document (SVID)](https://spiffe.io/docs/latest/spiffe-about/spiffe-concepts/#spiffe-verifiable-identity-document-svid)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

An SVID is the document with which a workload proves its identity to a resource or caller. An SVID is considered valid if it has been signed by an authority within the SPIFFE ID’s trust domain.

An SVID contains a single SPIFFE ID, which represents the identity of the service presenting it. It encodes the SPIFFE ID in a cryptographically-verifiable document, in one of two currently supported formats: an X.509 certificate or a JWT token.

As tokens are susceptible to replay attacks, in which an attacker that obtains the token in transit can use it to impersonate a workload, it is advised to use X.509-SVIDs whenever possible. However, there may be some situations in which the only option is the JWT token format, for example, when your architecture has an L7 proxy or load balancer between two workloads.

For detailed information on the SVID, see the **[SVID specification](https://github.com/spiffe/spiffe/blob/main/standards/X509-SVID.md)**.

## SPIFFE Workload API

The workload API provides the following:

For identity documents in X.509 format (an X.509-SVID):

- Its identity, described as a SPIFFE ID.
- A private key tied to that ID that can be used to sign data on behalf of the workload. A corresponding short-lived X.509 certificate is also created, the X509-SVID. This can be used to establish TLS or otherwise authenticate to other workloads.
- A set of certificates – known as a trust bundle – that a workload can use to verify an X.509-SVID presented by another workload

For identity documents in JWT format (a JWT-SVID):

- Its identity, described as a SPIFFE ID
- The JWT token
- A set of certificates – known as a trust bundle – that a workload can use to verify the identity of other workloads.

In similar fashion to the AWS EC2 Instance Metadata API, and the Google GCE Instance Metadata API, the Workload API does not require that a calling workload have any knowledge of its own identity, or possess any authentication token when calling the API. This means your application need not co-deploy any authentication secrets with the workload.

Unlike these other APIs however, the Workload API is platform agnostic, and can identify running services at a process level as well as a kernel level – which makes it suitable for use with container schedulers such as Kubernetes.

In order to minimize exposure from a key being leaked or compromised, all private keys (and corresponding certificates) are short lived, rotated frequently and automatically. Workloads can request new keys and trust bundles from the Workload API before the corresponding key(s) expire.
