# **[Sender Policy Framework (SPF)](https://www.nslookup.io/learning/dns-record-types/txt/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

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

## Sender Policy Framework (SPF)

**[SPF](https://www.nslookup.io/learning/spf-a-practical-guide/)** is specified in **[RFC 7208](https://datatracker.ietf.org/doc/html/rfc7208)**. SPF uses DNS TXT records to list the mail servers permitted to send email for a domain. The creators of SPF used TXT records out of convenience. There was an attempt to create a dedicated DNS record type for SPF but this was officially deprecated in **[RFC 7208 section 3.1](https://datatracker.ietf.org/doc/html/rfc7208#section-3.1)**.

Below is a very simple SPF record example. This record states that the mail servers at the IP addresses 10.0.0.1 and 10.0.0.2 are permitted to send mail for the example.org domain:

```example.org. 3600 TXT "v=spf1 ip4:10.0.0.1 ip4:10.0.0.2 -all"```
