# **[DNS Records Explained](https://gcore.com/learning/dns-records-explained/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[DNS Provider Lookup](https://mxtoolbox.com/DnsLookup.aspx)**
- **[nslookup](https://www.nslookup.io/)**
- **[dns record types](https://www.nslookup.io/learning/dns-record-types/)**
- **[DNS Lookup](https://www.whoisfreaks.com/)**
- **[TXT lookup tool](https://www.nslookup.io/txt-lookup/)**
- **[MX lookup tool](https://www.nslookup.io/mx-lookup/)**
- **[NS lookup tool](https://www.nslookup.io/ns-lookup/)**
- **[SOA lookup tool](https://www.nslookup.io/soa-lookup/)**

The Domain Name System (DNS) gives resources stable human-readable names to solve various potential internet problems; for example, it translates domain names to IP addresses so users don’t have to remember long numbers to access websites. Administrators can create records of several standardized types, and each type solves a specific problem. If you ever wondered how DNS records work, what each record type does, and how to manage DNS records, this article is the right place to start.

## What Is a DNS Record?

Every interaction on the internet involves a translation process, where a human-readable domain name becomes a machine-understandable IP address. DNS records are the essential building blocks of this process. They come in several types to handle different aspects of internet operations, such as routing emails (MX records) and aliasing one domain name to another (CNAME records.)

DNS records are aliases for short pieces of text stored in a DNS database, and each one maps a specific domain to an IP address or another piece of data. For example, if you have the alias example.com, you can send it to a DNS server to connect to the aliased value 2606:2800:220:1:248:1893:25c8:1946.

![nip](https://assets.gcore.pro/blog_containerizing_prod/uploads/2023/09/dns-records-explained-1.png)

Alt:

Each DNS record contains various pieces of information like the name of the host, the type of DNS record, the data associated with it, and the TTL (time to live) value. We’ll explain all the information inside a record later in this article. Understanding DNS records is fundamental to maintaining a reliable and efficient online presence.

## What Problems Do DNS Records Solve?

The primary problems DNS records solve are giving IP addresses human-readable names (i.e., domain names) and decoupling services from one another. You achieve the latter by adding a DNS record as an indirection between services, so if one service’s IP or domain name changes, you only need to change the related DNS record, and the consuming service can remain unchanged. Let’s look at some examples:

- The A record maps a domain name like example.com to an IPv4 address like 192.168.0.1.
- The CNAME record maps a domain name like mail.example.com to another domain name like customer123.mailprovider.net.
- The TXT name maps a domain name like hello.example.com to arbitrary text like “Hello, world!”.

Don’t fret if these examples don’t yet make sense to you, as we will look into the details in the following sections of this article. By the end of the article, you’ll know what they mean!

## How Do DNS Records Work?

Every time you type a URL into your browser, click on a link, or send an email (among other things) a DNS query is initiated in a process called DNS lookup. This query works its way through the hierarchical structure of the DNS until it reaches the DNS server responsible for the specific domain. This server contains the DNS records for that domain. You can learn about this process in our **[dedicated article](https://gcore.com/learning/what-is-dns-how-does-it-work/)** under “How Does DNS Lookup Work?”

Each domain has several DNS records associated with it, like an address book, that help to direct traffic to the right location. For instance, an A record translates a domain name into an IP address that computers can understand. Here’s a table showing the range of DNS records:

| DNS Record Type | Purpose                                                                                                   | Example                                                                                     |
|-----------------|-----------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| A               | Translates a domain name into an IPv4 address                                                             | A record for “example.com” pointing to “192.168.1.1”                                        |
| AAAA            | Translates a domain name to an IPv6 address                                                               | AAAA record for “example.com” pointing to “2001:0db8:85a3::8a2e:0370:7334”                  |
| CNAME           | Creates an alias for a domain name                                                                        | CNAME record for “shop” to example.com domain name pointing to “website-builder.ursite.com” |
| MX              | Shows which mail servers are in charge of receiving emails                                                | MX record for “example.com” pointing to “mail.example.com”                                  |
| TXT             | Store text information for various purposes such as SPF configuration or domain name verification         | TXT record for “example.com” with an email SPF configuration                                |
| NS              | Stands for “name servers;” specifies authoritative name servers for the domain name                       | NS record for “example.com” pointing to “ns1.example.com” and “ns2.example.com”             |
| SOA             | Provides essential parameters for the zone, including primary name server and administrator email address | Provides essential parameters for the zone (e.g., ns1.example.com, admin.example.com)       |

When a DNS server receives a query, it checks the DNS records of the relevant domain in its zone file. The server then responds with the corresponding record’s data, effectively directing the user’s device to the correct IP address.

A DNS record is an entry in a zone used by a DNS server. The DNS system is split into zones, each managed by a DNS server that keeps zone-related records in a zone. The entries in this file have the following structure:

- The name field contains a fully qualified domain name, the alias discussed earlier.
- The type field contains the record type; it describes how to interpret the data field.
- The data field contains the aliased text, for example, an IP address or another domain.
- The time to live (TTL) contains the time (in seconds) a client can cache the resolved data locally.
- The class field contains a protocol class. On the internet, its value is always IN.

## **[What does the ampersand mean](https://betterstack.com/community/questions/what-is-the-meaning-of-at-sign-in-a-dns-zone-file/)**

In DNS (Domain Name System) zone files, the '@' symbol represents the origin or root of the domain itself. It is used as a placeholder to denote the domain name itself within the zone file.

The '@' symbol is commonly used to refer to the zone's domain name within the file. For example, in a typical zone file for a domain such as "example.com ", the '@' symbol represents "example.com " itself. It is a shorthand way of referring to the domain name without explicitly typing it out.
