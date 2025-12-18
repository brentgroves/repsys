# **[The MX record](https://www.nslookup.io/learning/dns-record-types/mx/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[DNS Checker](https://dnschecker.org/)**
- **[DNS Provider Lookup](https://mxtoolbox.com/DnsLookup.aspx)**
- **[nslookup](https://www.nslookup.io/)**
- **[dns record types](https://www.nslookup.io/learning/dns-record-types/)**
- **[DNS Lookup](https://www.whoisfreaks.com/)**
- **[TXT lookup tool](https://www.nslookup.io/txt-lookup/)**
- **[MX lookup tool](https://www.nslookup.io/mx-lookup/)**
- **[NS lookup tool](https://www.nslookup.io/ns-lookup/)**
- **[SOA lookup tool](https://www.nslookup.io/soa-lookup/)**

The MX or “mail exchange” DNS record type is critical to the delivery of email via the Simple Mail Transfer Protocol (SMTP). MX records are used to specify a list of mail servers for a domain. If MX records are not created and maintained correctly, email for the domain will not be delivered reliably or perhaps at all.
The MX record type was introduced in the original DNS specifications (**[RFC 1034](https://datatracker.ietf.org/doc/html/rfc1034)** and **[1035](https://datatracker.ietf.org/doc/html/rfc1034)**) in 1987.

The MX record has two data fields besides the usual DNS TTL field: a preference value and the host name of a mail server. Each MX record specifies a single mail exchanger that provides mail delivery services for the domain.

- **Preference:** A 16-bit unsigned integer value. Lower values indicate higher preference. It is legal to have a preference value zero. This indicates the highest possible preference.
- **Mail exchange:** The fully qualified DNS name of a mail exchange for the domain.

We will discuss both fields in more detail later.

The MX record type is an example of a record type that exists in the DNS to support another protocol. Some record types such as SOA and NS are fundamental to the operation of the DNS itself. These record types are primarily used by DNS resolvers. Other record types such as MX and SRV are stored in the DNS, but are primarily used by applications to service other protocols.
