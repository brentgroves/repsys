# **[Security](https://istio.io/latest/docs/concepts/security/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

Breaking down a monolithic application into atomic services offers various benefits, including better agility, better scalability and better ability to reuse services. However, microservices also have particular security needs:

- To defend against man-in-the-middle attacks, they need traffic encryption.
- To provide flexible service access control, they need mutual TLS and fine-grained access policies.
- To determine who did what at what time, they need auditing tools.

Istio Security provides a comprehensive security solution to solve these issues. This page gives an overview on how you can use Istio security features to secure your services, wherever you run them. In particular, Istio security mitigates both insider and external threats against your data, endpoints, communication, and platform.

![is](https://istio.io/latest/docs/concepts/security/overview.svg)

The Istio security features provide strong identity, powerful policy, transparent TLS encryption, and authentication, authorization and audit (AAA) tools to protect your services and data. The goals of Istio security are:

- Security by default: no changes needed to application code and infrastructure
- Defense in depth: integrate with existing security systems to provide multiple layers of defense
- Zero-trust network: build security solutions on distrusted networks

Visit our **[mutual TLS Migration docs](https://istio.io/latest/docs/tasks/security/authentication/mtls-migration/)** to start using Istio security features with your deployed services. Visit our Security Tasks for detailed instructions to use the security features.

## High-level architecture

Security in Istio involves multiple components:

- A Certificate Authority (CA) for key and certificate management
- The configuration API server distributes to the proxies:
  - authentication policies
  - authorization policies
  - secure naming information
- Sidecar and perimeter proxies work as Policy Enforcement Points (PEPs) to secure communication between clients and servers.
- A set of Envoy proxy extensions to manage telemetry and auditing

The control plane handles configuration from the API server and configures the PEPs in the data plane. The PEPs are implemented using Envoy. The following diagram shows the architecture.

![pep](https://istio.io/latest/docs/concepts/security/arch-sec.svg)

In the following sections, we introduce the Istio security features in detail.

## Istio identity

Identity is a fundamental concept of any security infrastructure. At the beginning of a workload-to-workload communication, the two parties must exchange credentials with their identity information for mutual authentication purposes. On the client side, the server’s identity is checked against the secure naming information to see if it is an authorized runner of the workload. On the server side, the server can determine what information the client can access based on the authorization policies, audit who accessed what at what time, charge clients based on the workloads they used, and reject any clients who failed to pay their bill from accessing the workloads.

The Istio identity model uses the first-class service identity to determine the identity of a request’s origin. This model allows for great flexibility and granularity for service identities to represent a human user, an individual workload, or a group of workloads. On platforms without a service identity, Istio can use other identities that can group workload instances, such as service names.

The following list shows examples of service identities that you can use on different platforms:

- Kubernetes: Kubernetes service account
- GCE: GCP service account
- On-premises (non-Kubernetes): user account, custom service account, service name, Istio service account, or GCP service account. The custom service account refers to the existing service account just like the identities that the customer’s Identity Directory manages.

## Identity and certificate management

Istio securely provisions strong identities to every workload with X.509 certificates. Istio agents, running alongside each Envoy proxy, work together with istiod to automate key and certificate rotation at scale. The following diagram shows the identity provisioning flow.

![pki](https://istio.io/latest/docs/concepts/security/id-prov.svg)

Istio provisions keys and certificates through the following flow:

1. istiod offers a gRPC service to take certificate signing requests (CSRs).
2. When started, the Istio agent creates the private key and CSR, and then sends the CSR with its credentials to istiod for signing.
3. The CA in istiod validates the credentials carried in the CSR. Upon successful validation, it signs the CSR to generate the certificate.
4. When a workload is started, Envoy requests the certificate and key from the Istio agent in the same container via the Envoy secret discovery service (SDS) API.
5. The Istio agent sends the certificates received from istiod and the private key to Envoy via the Envoy SDS API.
6. Istio agent monitors the expiration of the workload certificate. The above process repeats periodically for certificate and key rotation.
