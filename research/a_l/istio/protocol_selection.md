# **[Protocol Selection](https://istio.io/latest/docs/ops/configuration/traffic-management/protocol-selection/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

Istio supports proxying any TCP traffic. This includes HTTP, HTTPS, gRPC, as well as raw TCP protocols. In order to provide additional capabilities, such as routing and rich metrics, the protocol must be determined. This can be done automatically or explicitly specified.

Non-TCP based protocols, such as UDP, are not proxied. These protocols will continue to function as normal, without any interception by the Istio proxy but cannot be used in proxy-only components such as ingress or egress gateways.

## Automatic protocol selection

Istio can automatically detect HTTP and HTTP/2 traffic. If the protocol cannot automatically be determined, traffic will be treated as plain TCP traffic.

Server First protocols, such as MySQL, are incompatible with automatic protocol selection. See **[Server first protocols](https://istio.io/latest/docs/ops/deployment/application-requirements/#server-first-protocols)** for more information.
