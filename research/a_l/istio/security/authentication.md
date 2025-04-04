# **[Authentication](https://preliminary.istio.io/latest/docs/concepts/security/#authentication)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

## Authentication

Istio provides two types of authentication:

**Peer authentication:** used for service-to-service authentication to verify the client making the connection. Istio offers mutual TLS as a full stack solution for transport authentication, which can be enabled without requiring service code changes. This solution:

- Provides each service with a strong identity representing its role to enable interoperability across clusters and clouds.
- Secures service-to-service communication.
- Provides a key management system to automate key and certificate generation, distribution, and rotation.

**Request authentication:** Used for end-user authentication to verify the credential attached to the request. Istio enables request-level authentication with JSON Web Token (JWT) validation and a streamlined developer experience using a custom authentication provider or any OpenID Connect providers, for example:

- ORY Hydra
- Keycloak
- Auth0
- Firebase Auth
- Google Auth

In all cases, Istio stores the authentication policies in the Istio config store via a custom Kubernetes API. Istiod keeps them up-to-date for each proxy, along with the keys where appropriate. Additionally, Istio supports authentication in permissive mode to help you understand how a policy change can affect your security posture before it is enforced.

## Mutual TLS authentication

Istio tunnels service-to-service communication through the client- and server-side policy enforcement point,PEPs, which are implemented as Envoy proxies. When a workload sends a request to another workload using mutual TLS authentication, the request is handled as follows:

- Istio re-routes the outbound traffic from a client to the client’s local sidecar Envoy.
- The client side Envoy starts a mutual TLS handshake with the server side Envoy. During the handshake, the client side Envoy also does a secure naming check to verify that the service account presented in the server certificate is authorized to run the target service.
- The client side Envoy and the server side Envoy establish a mutual TLS connection, and Istio forwards the traffic from the client side Envoy to the server side Envoy.
- The server side Envoy authorizes the request. If authorized, it forwards the traffic to the backend service through local TCP connections.

Istio configures TLSv1_2 as the minimum TLS version for both client and server with the following cipher suites:

- ECDHE-ECDSA-AES256-GCM-SHA384
- ECDHE-RSA-AES256-GCM-SHA384
- ECDHE-ECDSA-AES128-GCM-SHA256
- ECDHE-RSA-AES128-GCM-SHA256
- AES256-GCM-SHA384
- AES128-GCM-SHA256

## Permissive mode

Istio mutual TLS has a permissive mode, which allows a service to accept both plaintext traffic and mutual TLS traffic at the same time. This feature greatly improves the mutual TLS onboarding experience.

Many non-Istio clients communicating with a non-Istio server presents a problem for an operator who wants to migrate that server to Istio with mutual TLS enabled. Commonly, the operator cannot install an Istio sidecar for all clients at the same time or does not even have the permissions to do so on some clients. Even after installing the Istio sidecar on the server, the operator cannot enable mutual TLS without breaking existing communications.

With the permissive mode enabled, the server accepts both plaintext and mutual TLS traffic. The mode provides greater flexibility for the on-boarding process. The server’s installed Istio sidecar takes mutual TLS traffic immediately without breaking existing plaintext traffic. As a result, the operator can gradually install and configure the client’s Istio sidecars to send mutual TLS traffic. Once the configuration of the clients is complete, the operator can configure the server to mutual TLS only mode. For more information, visit the Mutual TLS Migration tutorial.

## Secure naming

Server identities are encoded in certificates, but service names are retrieved through the discovery service or DNS. **The secure naming information maps the server identities to the service names.** A mapping of identity A to service name B means “A is authorized to run service B”. The control plane watches the apiserver, generates the secure naming mappings, and distributes them securely to the PEPs. The following example explains why secure naming is critical in authentication.

The Envoy data plane is a universal Policy Enforcement Point (PEP) that intercepts all traffic and can apply policies at the application layer.

Suppose the legitimate servers that run the service datastore only use the infra-team identity. A malicious user has the certificate and key for the test-team identity. The malicious user intends to impersonate the service to inspect the data sent from the clients. The malicious user deploys a forged server with the certificate and key for the test-team identity. Suppose the malicious user successfully hijacked (through DNS spoofing, BGP/route hijacking, ARP spoofing, etc.) the traffic sent to the datastore and redirected it to the forged server.

When a client calls the datastore service, it extracts the test-team identity from the server’s certificate, and checks whether test-team is allowed to run datastore with the secure naming information. The client detects that test-team is not allowed to run the datastore service and the authentication fails.

Note that, for non HTTP/HTTPS traffic, secure naming doesn’t protect from DNS spoofing, in which case the attacker modifies the destination IPs for the service. Since TCP traffic does not contain Host information and Envoy can only rely on the destination IP for routing, Envoy may route traffic to services on the hijacked IPs. This DNS spoofing can happen even before the client-side Envoy receives the traffic.

## Authentication architecture

You can specify authentication requirements for workloads receiving requests in an Istio mesh using peer and request authentication policies. The mesh operator uses .yaml files to specify the policies. The policies are saved in the Istio configuration storage once deployed. The Istio controller watches the configuration storage.

Upon any policy changes, the new policy is translated to the appropriate configuration telling the PEP how to perform the required authentication mechanisms. The control plane may fetch the public key and attach it to the configuration for JWT validation. Alternatively, Istiod provides the path to the keys and certificates the Istio system manages and installs them to the application pod for mutual TLS. You can find more info in the **[Identity and certificate management section](https://istio.io/latest/docs/concepts/security/#pki)**.

Istio sends configurations to the targeted endpoints asynchronously. Once the proxy receives the configuration, the new authentication requirement takes effect immediately on that pod.

Client services, those that send requests, are responsible for following the necessary authentication mechanism. For request authentication, the application is responsible for acquiring and attaching the JWT credential to the request. For peer authentication, Istio automatically upgrades all traffic between two PEPs to mutual TLS. If authentication policies disable mutual TLS mode, Istio continues to use plain text between PEPs. To override this behavior explicitly disable mutual TLS mode with **[destination rules](https://istio.io/latest/docs/concepts/traffic-management/#destination-rules)**. You can find out more about how mutual TLS works in the **[Mutual TLS authentication section](https://istio.io/latest/docs/concepts/security/#mutual-tls-authentication)**.

![mtls](https://istio.io/latest/docs/concepts/security/authn.svg)

Istio outputs identities with both types of authentication, as well as other claims in the credential if applicable, to the next layer: **[authorization](https://istio.io/latest/docs/concepts/security/#authorization)**.

## Authentication policies

This section provides more details about how Istio authentication policies work. As you’ll remember from the Architecture section, authentication policies apply to requests that a service receives. To specify client-side authentication rules in mutual TLS, you need to specify the TLSSettings in the DestinationRule. You can find more information in our **[TLS settings reference docs](https://istio.io/latest/docs/reference/config/networking/destination-rule/#ClientTLSSettings)**.

Like other Istio configurations, you can specify authentication policies in .yaml files. You deploy policies using kubectl. The following example authentication policy specifies that transport authentication for the workloads with the app:reviews label must use mutual TLS:

```yaml
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: "example-peer-policy"
  namespace: "foo"
spec:
  selector:
    matchLabels:
      app: reviews
  mtls:
    mode: STRICT
```

## Policy storage

Istio stores mesh-scope policies in the root namespace. These policies have an empty selector apply to all workloads in the mesh. Policies that have a namespace scope are stored in the corresponding namespace. They only apply to workloads within their namespace. If you configure a selector field, the authentication policy only applies to workloads matching the conditions you configured.

Peer and request authentication policies are stored separately by kind, PeerAuthentication and RequestAuthentication respectively.

## Selector field

Peer and request authentication policies use selector fields to specify the label of the workloads to which the policy applies. The following example shows the selector field of a policy that applies to workloads with the app:product-page label:

```yaml
selector:
  matchLabels:
    app: product-page
```

If you don’t provide a value for the selector field, Istio matches the policy to all workloads in the storage scope of the policy. Thus, the selector fields help you specify the scope of the policies:

- **Mesh-wide policy:** A policy specified for the root namespace without or with an empty selector field.
- **Namespace-wide policy:** A policy specified for a non-root namespace without or with an empty selector field.
- **Workload-specific policy:** a policy defined in the regular namespace, with non-empty selector field.

Peer and request authentication policies follow the same hierarchy principles for the selector fields, but Istio combines and applies them in slightly different ways.

There can be only one mesh-wide peer authentication policy, and only one namespace-wide peer authentication policy per namespace. When you configure multiple mesh- or namespace-wide peer authentication policies for the same mesh or namespace, Istio ignores the newer policies. When more than one workload-specific peer authentication policy matches, Istio picks the oldest one.

Istio applies the narrowest matching policy for each workload using the following order:

- workload-specific
- namespace-wide
- mesh-wide

Istio can combine all matching request authentication policies to work as if they come from a single request authentication policy. Thus, you can have multiple mesh-wide or namespace-wide policies in a mesh or namespace. However, it is still a good practice to avoid having multiple mesh-wide or namespace-wide request authentication policies.

## Peer authentication

Peer authentication policies specify the mutual TLS mode Istio enforces on target workloads. The following modes are supported:

- **PERMISSIVE:** Workloads accept both mutual TLS and plain text traffic. This mode is most useful during migrations when workloads without sidecar cannot use mutual TLS. Once workloads are migrated with sidecar injection, you should switch the mode to STRICT.
- **STRICT:** Workloads only accept mutual TLS traffic.
- **DISABLE:** Mutual TLS is disabled. From a security perspective, you shouldn’t use this mode unless you provide your own security solution.

When the mode is unset, the mode of the parent scope is inherited. Mesh-wide peer authentication policies with an unset mode use the PERMISSIVE mode by default.

The following peer authentication policy requires all workloads in namespace foo to use mutual TLS:

```yaml
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: "example-policy"
  namespace: "foo"
spec:
  mtls:
    mode: STRICT

```

With workload-specific peer authentication policies, you can specify different mutual TLS modes for different ports. You can only use ports that workloads have claimed for port-wide mutual TLS configuration. The following example disables mutual TLS on port 80 for the app:example-app workload, and uses the mutual TLS settings of the namespace-wide peer authentication policy for all other ports:

```
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: "example-workload-policy"
  namespace: "foo"
spec:
  selector:
     matchLabels:
       app: example-app
  portLevelMtls:
    80:
      mode: DISABLE
```

The peer authentication policy above works only because the service configuration below bound the requests from the example-app workload to port 80 of the example-service:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: example-service
  namespace: foo
spec:
  ports:
  - name: http
    port: 8000
    protocol: TCP
    targetPort: 80
  selector:
    app: example-app
```

## Request authentication

Request authentication policies specify the values needed to validate a JSON Web Token (JWT). These values include, among others, the following:

- The location of the token in the request
- The issuer or the request
- The public JSON Web Key Set (JWKS)

Istio checks the presented token, if presented against the rules in the request authentication policy, and rejects requests with invalid tokens. When requests carry no token, they are accepted by default. To reject requests without tokens, provide authorization rules that specify the restrictions for specific operations, for example paths or actions.

Request authentication policies can specify more than one JWT if each uses a unique location. When more than one policy matches a workload, Istio combines all rules as if they were specified as a single policy. This behavior is useful to program workloads to accept JWT from different providers. However, requests with more than one valid JWT are not supported because the output principal of such requests is undefined.

## Principals

When you use peer authentication policies and mutual TLS, Istio extracts the identity from the peer authentication into the source.principal. Similarly, when you use request authentication policies, Istio assigns the identity from the JWT to the request.auth.principal. Use these principals to set authorization policies and as telemetry output.

## Updating authentication policies

You can change an authentication policy at any time and Istio pushes the new policies to the workloads almost in real time. However, Istio can’t guarantee that all workloads receive the new policy at the same time. The following recommendations help avoid disruption when updating your authentication policies:

Use intermediate peer authentication policies using the PERMISSIVE mode when changing the mode from DISABLE to STRICT and vice-versa. When all workloads switch successfully to the desired mode, you can apply the policy with the final mode. You can use Istio telemetry to verify that workloads have switched successfully.

When migrating request authentication policies from one JWT to another, add the rule for the new JWT to the policy without removing the old rule. Workloads then accept both types of JWT, and you can remove the old rule when all traffic switches to the new JWT. However, each JWT has to use a different location.
