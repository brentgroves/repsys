# **[The NS record](https://www.nslookup.io/learning/dns-record-types/ns/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[nslookup](https://www.nslookup.io/)**
- **[dns record types](https://www.nslookup.io/learning/dns-record-types/)**

The NS or “name server” DNS record type is used to specify the **[authoritative name servers](https://www.nslookup.io/learning/recursive-vs-authoritative-dns/)** for a domain. It tells DNS resolvers which servers to contact when it's looking for DNS records for that domain name. This is what allows different organizations to own different domain names.

Like a number of other DNS record types, the original DNS specifications (**[RFC 1034](https://datatracker.ietf.org/doc/html/rfc1034)** and **[1035](https://datatracker.ietf.org/doc/html/rfc1035)**) introduced this record type in 1987. Along with the **[Start of Authority (SOA)](https://www.nslookup.io/learning/dns-record-types/soa/)** record type, NS records are integral to the proper functioning of the DNS.

A trail of NS records leads to your domain.

The NS record has only one data field besides the usual DNS TTL field: the fully qualified DNS name of a name server that is authoritative for the domain.

Each NS record specifies the name of one authoritative name server for a particular **[DNS zone](https://www.nslookup.io/learning/what-is-a-dns-zone/)**. To specify a list of name servers that are authoritative for a particular DNS zone, a set of NS records is published, where each NS record in the set specifies one authoritative name server.
