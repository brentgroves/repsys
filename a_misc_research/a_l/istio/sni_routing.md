# **[SNI Routing](https://istio.io/latest/docs/ops/common-problems/network-issues/#configuring-sni-routing-when-not-sending-sni)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[Secure Ingress](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/)**

**Server Name Indication (SNI)** is an extension to the Transport Layer Security (TLS) computer networking protocol by which a client indicates which hostname it is attempting to connect to at the start of the handshaking process.[1] The extension allows a server to present one of multiple possible certificates on the same IP address and TCP port number and hence allows multiple secure (HTTPS) websites (or any other service over TLS) to be served by the same IP address without requiring all those sites to use the same certificate. It is the conceptual equivalent to **HTTP/1.1 name-based virtual hosting**, but for HTTPS. This also allows a proxy to forward client traffic to the right server during TLS/SSL handshake. The desired hostname is not encrypted in the original SNI extension, so an eavesdropper can see which site is being requested. The SNI extension was specified in 2003 in RFC 3546

An HTTPS Gateway will perform **[SNI](https://en.wikipedia.org/wiki/Server_Name_Indication)** matching against its configured host(s) before forwarding a request, which may cause some requests to fail. See **[configuring SNI routing](https://istio.io/latest/docs/ops/common-problems/network-issues/#configuring-sni-routing-when-not-sending-sni)** for details.

## **[Configuring SNI routing when not sending SNI](https://istio.io/latest/docs/ops/common-problems/network-issues/#configuring-sni-routing-when-not-sending-sni)**

An HTTPS Gateway that specifies the hosts field will perform an SNI match on incoming requests. For example, the following configuration would only allow requests that match *.example.com in the SNI:

```yaml
servers:
- port:
    number: 443
    name: https
    protocol: HTTPS
  hosts:
  - "*.example.com"
```

This may cause certain requests to fail.

For example, if you do not have DNS set up and are instead directly setting the host header, such as curl 1.2.3.4 -H "Host: app.example.com", no SNI will be set, causing the request to fail. Instead, you can set up DNS or use the --resolve flag of curl. See the **[Secure Gateways](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/)** task for more information.

## Curl --resolve examples

The following curl command:

```bash
curl http://www.example.com --resolve www.example.com:80:127.0.0.1
```

...will force cURL to use "127.0.0.1" as the IP address when requesting "www.example.com" over port 80 (HTTP).

The command above can be augmented to look like this:

```bash
curl http://www.example.com --resolve www.example.com:80:127.0.0.1 --resolve www.example.com:443:127.0.0.1
```

...which will force cURL to use  "127.0.0.1" as the IP address for requests to "www.example.com" over ports 80 (HTTP and 443 (HTTPS). This can be useful for sites that automatically redirect HTTP requests to HTTPS requests as a security measure.

Remember, --resolve can be specified multiple times (and for multiple domain/port combinations) for a single cURL command, allowing you to establish complex routing rules for requests that you know will be redirected multiple times across various domains and ports.
