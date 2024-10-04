# **[Gateway TLS](https://gateway-api.sigs.k8s.io/guides/tls/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Experimental Channel

The TLSRoute and BackendTLSPolicy resources described below are currently only included in the "Experimental" channel of Gateway API. For more information on release channels, refer to our versioning guide.

## TLS Configuration

Gateway API allows for a variety of ways to configure TLS. This document lays out various TLS settings and gives general guidelines on how to use them effectively.

Although this doc covers the most common forms of TLS configuration with Gateway API, some implementations may also offer implementation-specific extensions that allow for different or more advanced forms of TLS configuration. In addition to this documentation, it's worth reading the TLS documentation for whichever implementation(s) you're using with Gateway API.
