# **[What is a Domain Name System (DNS) zone?](https://www.nslookup.io/learning/what-is-a-dns-zone/)**

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

```bash
# Linamar has many subdomains. Creating a sub-domain for DKIM records make emailing more secure.
 
dig plexemail._domainkey.linamar.com txt
dig linamar.com txt

```

A Domain Name System (DNS) zone represents a portion of the DNS namespace owned and managed as a single unit by one organization. The global DNS is composed of many zones.
The most well-known zones are the DNS root zone, where the DNS begins, and the Top Level Domains (TLDs) such as .com, .net, .org, etc. Below the TLDs, virtually every recognizable brand with a presence on the Internet has its very own DNS zone. So, for example, individual DNS zones exist for google.com, wikipedia.org, bit.ly, and millions upon millions of other domains.

Zones in the DNS are organized in a tree.

## Where does a zone begin?

Every DNS zone begins at a specific name in the DNS. The DNS zone owns that name and all of the children of that name. For example, the .com TLD is a zone that begins at the name "com" and extends downwards to encompass all of the DNS names that end with ".com".

The DNS contains a special record at the start of each zone: the **[Start of Authority (SOA) record](https://www.nslookup.io/learning/dns-record-types/soa/)**. This record signifies the beginning of a zone and contains some important metadata about the zone. All zones start with an SOA record.

## And where does a zone end?

Each zone owns the name where the zone starts and of that name's children. But each zone's administrator can insert **delegations** to transfer, or "delegate", ownership to other zones.

A **[delegation](https://www.nslookup.io/learning/zone-delegation/)** serves two important purposes. First, a delegation marks the end of the zone's authority. The delegated name and all of its children are not part of the zone: they are instead part of the child zone. Second, the delegation publishes, to the entire Internet, the set of DNS servers that can resolve names in the child zone.

In this way, the global DNS begins at the **[root zone](https://www.nslookup.io/learning/what-is-the-dns-root-zone/)** and flows downwards to different zones through delegations.

## An example zone

Let's consider a simple example zone file. The zone starts with an **[SOA](https://www.nslookup.io/learning/dns-record-types/soa/)** record. There must also be two or more **[NS](https://www.nslookup.io/learning/dns-record-types/ns/)** records at the root of the zone. And often **[MX](https://www.nslookup.io/learning/dns-record-types/mx/)** records for mail delivery, and other records as well.

```csv
example.org. 3600 SOA ns1.example.org. admin.example.org. 100 7200 3600 86400 300
example.org. 3600 NS ns1.example.org.
example.org. 3600 NS ns2.example.org.

database.example.org. 3600 A 10.0.0.3
database.example.org. 3600 A 10.0.0.4

mail.example.org. 3600 A 10.0.0.1
mail.example.org. 3600 A 10.0.0.2

; The 'support' subdomain is delegated to DNS servers of a third party
support.example.org. 3600 NS ns1.support-software.org.
support.example.org. 3600 NS ns2.support-software.org.
```

The example.org zone owns, or is authoritative for, the DNS name example.org. It also owns all of the DNS names that are children of example.org, with the exception of support.example.org. The delegation at support.example.org means that authority at that point in the DNS tree is delegated to other DNS servers.

## What names in the DNS belong to the example.org zone?

It's helpful to consider the DNS as a tree of names starting with the DNS root at the top and flowing downward. Each node in this tree represents one label of a DNS name.

As we discussed, the example.org zone begins at example.org and flows downwards to all child names, stopping at delegations. So names shown as spheres on green in the diagram below are part of the example.org. Names shown as cubes on purple belong a different zone in the DNS.

![z](https://www.nslookup.io/img/example-zone.c76c32f0.jpg)

## How do DNS lookups use DNS zones?

A DNS lookup occurs when a piece of software, such as a web browser, needs to map a DNS name to an IP address or another piece of DNS data. The result of a DNS lookup is often an IP address, but it may be something else. For example, a DNS MX record lookup is used to retrieve the mail servers for a domain.

DNS lookups are performed by a software component called a DNS resolver. The DNS resolver begins each query at the DNS root domain by sending a DNS query to one of the DNS root servers. The root server will usually respond with a delegation. The resolver then sends the same query to one of the DNS servers listed in the delegation. These servers might respond with another delegation. This process continues until the DNS resolver gets an answer from one of the DNS servers authoritative for the zone.

A DNS resolver performing a DNS lookup for a typical name such as <www.example.org> will move through three DNS zones:

- The root: Authority begins with the DNS root zone. The root zone contains a delegation to the org zone.
- org: The org zone contains a delegation to the example.org zone.
- example.org: The example.org zone would typically contain A or AAAA records for <www.example.org>.
