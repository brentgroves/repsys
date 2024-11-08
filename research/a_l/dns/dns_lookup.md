# **[Domain Name System (DNS) Records Explained](https://gcore.com/learning/what-is-dns-how-does-it-work/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[nslookup](https://www.nslookup.io/)**
- **[dns record types](https://www.nslookup.io/learning/dns-record-types/)**
- **[DNS Lookup](https://www.whoisfreaks.com/)**

## How do DNS lookups use DNS zones?

A DNS lookup occurs when a piece of software, such as a web browser, needs to map a DNS name to an IP address or another piece of DNS data. The result of a DNS lookup is often an IP address, but it may be something else. For example, a DNS MX record lookup is used to retrieve the mail servers for a domain.

DNS lookups are performed by a software component called a DNS resolver. The DNS resolver begins each query at the DNS root domain by sending a DNS query to one of the DNS root servers. The root server will usually respond with a delegation. The resolver then sends the same query to one of the DNS servers listed in the delegation. These servers might respond with another delegation. This process continues until the DNS resolver gets an answer from one of the DNS servers authoritative for the zone.

A DNS resolver performing a DNS lookup for a typical name such as <www.example.org> will move through three DNS zones:

- The root: Authority begins with the DNS root zone. The root zone contains a delegation to the org zone.
- org: The org zone contains a delegation to the example.org zone.
- example.org: The example.org zone would typically contain A or AAAA records for <www.example.org>.
