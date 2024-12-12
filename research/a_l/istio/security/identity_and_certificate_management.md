# **[Identity and certificate management](https://istio.io/latest/docs/concepts/security/#pki)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

Istio securely provisions strong identities to every workload with X.509 certificates. Istio agents, running alongside each Envoy proxy, work together with istiod to automate key and certificate rotation at scale. The following diagram shows the identity provisioning flow.

![ipf](https://istio.io/latest/docs/concepts/security/id-prov.svg)

Istio provisions keys and certificates through the following flow:

- istiod offers a gRPC service to take certificate signing requests (CSRs).
- When started, the Istio agent creates the private key and CSR, and then sends the CSR with its credentials to istiod for signing.
- The CA in istiod validates the credentials carried in the CSR. Upon successful validation, it signs the CSR to generate the certificate.
- When a workload is started, Envoy requests the certificate and key from the Istio agent in the same container via the Envoy secret discovery service (SDS) API.
- The Istio agent sends the certificates received from istiod and the private key to Envoy via the Envoy SDS API.
- Istio agent monitors the expiration of the workload certificate. The above process repeats periodically for certificate and key rotation.
