# **[Domain-based Message Authentication, Reporting & Conformance (DMARC)](https://www.nslookup.io/learning/dns-record-types/txt/)**

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

## Domain-based Message Authentication, Reporting & Conformance (DMARC)

DMARC is specified in **[RFC 7489](https://datatracker.ietf.org/doc/html/rfc7489)**. DMARC uses DNS TXT records to specify email policy for a domain. The policy specifies what action to take if SPF or DKIM checks fail on email received from the domain.

Like the DKIM record, the DMARC record is not created at root of the domain. An example is shown below. This example specifies that mail which does not pass DMARC checks should be placed in quarantine. Reports should be sent to <admin@example.org>.

```_dmarc.example.org. 3600 TXT "v=DMARC1; p=quarantine; rua=mailto:admin@example.org"```
