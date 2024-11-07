# **[Use cURL's "--resolve" option to pin a request to an IP address](https://acquia.my.site.com/s/article/360005257154-Use-cURL-s-resolve-option-to-pin-a-request-to-an-IP-address)**

**[SNI Routing](https://istio.io/latest/docs/ops/common-problems/network-issues/#configuring-sni-routing-when-not-sending-sni)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

When preparing to launch a website, or debugging problems with a site that's already live, sometimes it can be helpful to bypass CDN and proxy layers when requesting content from the site by sending those web requests directly to a specific IP address without using the site's public DNS records. This practice of "pinning" a web request directly to a server can be accomplished by changing your /etc/hosts file , which will cause requests for a specified domain name (e.g: "www.example.com") to be routed from your local machine to a specified IP address (e.g: 127.0.0.1) until the changes you've made to /etc/hosts are reverted.

However, what if you want to pin a single request to an IP address, without modifying your system's configuration files? Happily, this sort of "ad-hoc" request-pinning is possible via command-line with cURL, which provides a special resolve option, formatted --resolve [DOMAIN]:[PORT]:[IP], that routes all web requests performed during the execution of a cURL command that match a given [DOMAIN] and [PORT] to a specified [IP] address. The values specified by this option (which can be invoked multiple times in a single command to route multiple domain/port combinations to various IP addresses) will apply to the initial request, and also to any redirects that cURL follows during the course of the command.

## Examples

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

**Server Name Indication (SNI)** is an extension to the Transport Layer Security (TLS) computer networking protocol by which a client indicates which hostname it is attempting to connect to at the start of the handshaking process.[1] The extension allows a server to present one of multiple possible certificates on the same IP address and TCP port number and hence allows multiple secure (HTTPS) websites (or any other service over TLS) to be served by the same IP address without requiring all those sites to use the same certificate. It is the conceptual equivalent to **HTTP/1.1 name-based virtual hosting**, but for HTTPS. This also allows a proxy to forward client traffic to the right server during TLS/SSL handshake. The desired hostname is not encrypted in the original SNI extension, so an eavesdropper can see which site is being requested. The SNI extension was specified in 2003 in RFC 3546

## **[Configuring SNI routing when not sending SNI](https://istio.io/latest/docs/ops/common-problems/network-issues/#configuring-sni-routing-when-not-sending-sni)**

If you do not have DNS set up and are instead directly setting the host header, such as curl 1.2.3.4 -H "Host: app.example.com", no SNI will be set, causing the request to fail. Instead, you can set up DNS or use the --resolve flag of curl.
