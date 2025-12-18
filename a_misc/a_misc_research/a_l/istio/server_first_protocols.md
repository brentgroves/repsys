# **[Server First Protocols](https://istio.io/latest/docs/ops/deployment/application-requirements/#server-first-protocols)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

Some protocols are “Server First” protocols, which means the server will send the first bytes. This may have an impact on PERMISSIVE mTLS and Automatic protocol selection.

Both of these features work by inspecting the initial bytes of a connection to determine the protocol, which is incompatible with server first protocols.

In order to support these cases, follow the Explicit protocol selection steps to declare the protocol of the application as TCP.

The following ports are known to commonly carry server first protocols, and are automatically assumed to be TCP:

| Protocol | Port  |
|----------|-------|
| SMTP     | 25    |
| DNS      | 53    |
| MySQL    | 3306  |
| MongoDB  | 27017 |

Because TLS communication is not server first, TLS encrypted server first traffic will work with automatic protocol detection as long as you make sure that all traffic subjected to TLS sniffing is encrypted:

- Configure mTLS mode STRICT for the server. This will enforce TLS encryption for all requests.
- Configure mTLS mode DISABLE for the server. This will disable the TLS sniffing, allowing server first protocols to be used.
- Configure all clients to send TLS traffic, generally through a DestinationRule or by relying on auto mTLS.
- Configure your application to send TLS traffic directly.

## Outbound traffic

In order to support Istio’s traffic routing capabilities, traffic leaving a pod may be routed differently than when a sidecar is not deployed.

For HTTP-based traffic, traffic is routed based on the Host header. This may lead to unexpected behavior if the destination IP and Host header are not aligned. For example, a request like curl 1.2.3.4 -H "Host: httpbin.default" will be routed to the httpbin service, rather than 1.2.3.4.

For Non HTTP-based traffic (including HTTPS), Istio does not have access to an Host header, so routing decisions are based on the Service IP address.

One implication of this is that direct calls to pods (for example, curl <POD_IP>), rather than Services, will not be matched. While the traffic may be passed through, it will not get the full Istio functionality including mTLS encryption, traffic routing, and telemetry.

See the **[Traffic Routing](https://istio.io/latest/docs/ops/configuration/traffic-management/traffic-routing/)** page for more information.

## See also

**[Installing the Sidecar](https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/)**

Install the Istio sidecar in application pods automatically using the sidecar injector webhook or manually using istioctl CLI.

**[Kubernetes Native Sidecars in Istio](https://istio.io/latest/blog/2023/native-sidecars/)**

Demoing the new SidecarContainers feature with Istio.

**[Demystifying Istio's Sidecar Injection Model](https://istio.io/latest/blog/2019/data-plane-setup/)**

De-mystify how Istio manages to plugin its data-plane components into an existing deployment.
