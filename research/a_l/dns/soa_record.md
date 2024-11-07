# **[Start of Authority (SOA) record](https://www.nslookup.io/learning/dns-record-types/soa/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[dns record types](https://www.nslookup.io/learning/dns-record-types/)**

All **[DNS zones](https://www.nslookup.io/learning/what-is-a-dns-zone/)** begin with a Start Of Authority (SOA) record. The SOA record states that authority for a zone is starting at a particular point in the global tree of DNS names.
For example, when creating a new DNS zone for ohmcar.org (a fictitious electric car company) then the process of zone creation would include the creation of a SOA record at ohmcar.org.

We discuss **[domain registration](https://www.nslookup.io/learning/how-does-domain-name-registration-work/)** in another article, but for now it is important to understand that zone creation is done before domain registration, and that the SOA record is part of the new zone being created.

Maintenance and creation of the SOA record is a task for the DNS server administrator of the zone. The webmaster for a domain would not generally need to add or change the SOA record.

The SOA record at ohmcar.org indicates that a DNS zone begins at ohmcar.org and extends downwards in the DNS tree to encompass all the DNS names that are children of ohmcar.org. The names <www.ohmcar.org> and apps.backend.ohmcar.org would be part of this zone, as would the name ohmcar.org itself.

The SOA record does more than just indicate that a zone exists. It also gives some important information about the zone and controls negative caching for non-existent names within the zone. More on that later.

DNS records replicated (cloned) across DNS servers using the configuration of the SOA record.

## NS records and end of authority

The SOA record starts authority for a zone. Alongside the SOA record, the existence of a zone is also defined by a set of **[Name Server (NS)](https://www.nslookup.io/learning/dns-record-types/ns/)** records at the zone root. The combination of exactly one SOA record and one more NS records (usually around 4) defines the apex or root of the zone, where the zone’s authority starts.

Authority can also end at particular points in the DNS tree below the root of the zone in a process called delegation. We discuss this in depth in our **[zone delegation](https://www.nslookup.io/learning/zone-delegation/)** article, but in summary, a delegation is a set of Name Server (NS) records at a name below the zone root.

It is confusing that NS records are used both at the zone root to identify the Name Servers for the zone and also at points below the zone root as part of delegation. For now, it is important only to remember that the NS records at the root of each zone list the Name Servers that are authoritative for the zone and together with the SOA record form the basic identity of the zone.

## Zones versus domains

You may have noticed that this article discusses DNS zones rather than DNS domains. These words are often used interchangeably.

Generally, the word domain is used to mean a single zone or to cover multiple related zones. In the latter definition, domain sometimes describes a collection of zones owned by a single entity. This is more of a business definition than a technical DNS definition.

The DNS only deals with zones. When multiple zones are delegated by a single controlling entity, the DNS still considers each zone separately. The DNS does not care who controls each individual zone in the tree of DNS names.

## Which SOA data fields are important?

The SOA record contains several data fields. Some of these fields are only relevant for zone transfer. Zone transfer is a DNS protocol for copying a DNS zone from one DNS server to another, and is not related to the ownership of the zone.

Zone transfer is sometimes used when DNS servers of multiple hosting providers are authoritative for the DNS zone, but DNS zone transfer is less relevant today than in the past.

Many popular cloud DNS providers such as Google, AWS, NS1, and Azure do not really use zone transfer at all. Instead, they use proprietary database replication mechanisms, which are generally superior to zone transfer. If zone transfer is not being performed for a particular zone, then Refresh Time, Retry Time, Expire Time, and Serial Number will be ignored.

Generally speaking, for a zone that will not use zone transfer, the important fields are:

- Primary Name Server
- Responsible Person
- Minimum TTL (for negative caching)
- The TTL of the SOA record itself

## SOA record format and fields

SOA records follow this format:

```text
[Owner name] [SOA record TTL] SOA [MNAME] [RNAME] (
  [Serial number]
  [Refresh time in seconds]
  [Retry time in seconds]
  [Expire time in seconds]
  [Minimum TTL (negative response cache TTL)]
)
```

An example of a DNS SOA record looks something like this:

```text
ohmcar.org 900 SOA ns1.ohmcar.org. admin.ohmcar.org. (
  17
  7200
  3600
  86400
  300
)
```

The owner name of this SOA record is the name of the zone and therefore is also the point at which the zone authority starts in the DNS tree. In the example above, the TTL of the SOA record for ohmcar.org is 15 minutes (900 seconds). The data fields of the SOA record are explained below:

- The Primary Name Server (MNAME) for the zone, in this example ns1.ohmcar.org. Most zones have multiple Name Servers. This field must specify one of them. It does not matter which Name Server is used in this field: any of the Name Servers authoritative for this DNS zone can be used, including secondary Name Servers if they exist.

Often the host names of the Name Servers would be ns1.ohmcar.org, ns2.ohmcar.org, etc. but they can be any valid DNS host name. Their host names can be inside or outside the zone.

- The Responsible Person (RNAME) for the zone. This is an email address where potential problems with the zone can be reported.

For example, if spam or a DDoS attack were originating from ohmcar.org then engineers at other organizations investigating those incidents would probably send email to the RNAME address.

This field never contains the @ character. Instead, the first period is interpreted as the @. In this example, the responsible person value of admin.ohmcar.org would indicate the email address <admin@ohmcar.org>. This format is tricky for email addresses that include a period before the @ character but DNS permits this with backslash escaping, for example john\.smith.ohmcar.org would be interpreted as <john.smith@ohmcar.org>.

- The current Serial Number of the zone. This field is used during zone transfer to identify and differentiate different versions of the zone. When zone transfer is not used, this field is largely ignored and is often not maintained by the zone administrator.

- When serial numbers are maintained they are usually of the form YYYYMMDDNN where NN is a sequence number starting at zero and incremented with each change on the day. Alternatively, the serial number can simply be an integer value starting at one that is incremented each time the zone is updated. Maintaining the zone serial number is optional when zone transfer is not being used.
- The Refresh Time in seconds. This is used for zone transfer and specifies how often secondary servers are expected to attempt to refresh their copy of the zone. This field is not used outside of zone transfer.
- The Retry Time in seconds. This is also used for zone transfer. It specifies how often secondary servers should retry zone transfer after a failure. This field is not used outside of zone transfer.
- The Expire Time in seconds. Another field for zone transfer. If the zone cannot be transferred within this many seconds, secondary servers should discard their last copy of the zone and assume that the zone is offline. This field is not used outside of zone transfer.
- The Minimum TTL for the zone. This field has an interesting history. Today it is used for negative caching. We’ll discuss this in more detail below.

## History

The SOA record was introduced in **[RFC 1034](https://www.rfc-editor.org/rfc/rfc1034)** and **[RFC 1035](https://www.rfc-editor.org/rfc/rfc1034)** back in 1987 as part of the first generation of the distributed DNS. Some important clarifications were added in **[RFC 2181](https://www.rfc-editor.org/rfc/rfc2181)**. Negative caching behavior was added in **[RFC 2308](https://www.rfc-editor.org/rfc/rfc2308)**. **[RFC 8499](https://www.rfc-editor.org/rfc/rfc8499)** contains more detailed and precise SOA definitions. Many other RFCs also mention the SOA record. It is one of the most fundamental record types in the DNS.

## Negative caching

The DNS uses an NXDOMAIN response to indicate that the DNS name in the query does not exist. This would be used if a user makes a typo in their web browser, for example, or any time a DNS name is queried for that does not exist in the DNS zone. DNS resolvers cache NXDOMAIN responses to minimize the number of queries they have to send. This is called “negative caching”.

The Minimum TTL field was defined in RFC 1035 as the minimum TTL value for all records in the zone, but this meaning was never really implemented in practice. RFC 2308 officially deprecated this use of the field and repurposed it for negative caching.

RFC 2308 “Negative Caching of DNS Queries (DNS NCACHE)” defines how negative caching is to be performed by DNS resolvers. This standard allows the administrator of each DNS zone to specify how long NXDOMAIN responses for the zone are to be cached.

It is worth mentioning that DNS caching resolvers may not follow this exactly. They may modify their behavior based on policy or implementation to minimize their cache size or attempt to reduce problems caused by transient NXDOMAIN responses.

DNS resolvers that follow RFC 2308 section 5 are expected to cache negative answers, or NXDOMAINs, for this many seconds:

That is to say, the NXDOMAIN caching time is the smallest of the SOA record’s own TTL and the Minimum TTL value inside the SOA record. For example, if the TTL of the SOA for ohmcar.org is 15 minutes (900 seconds) and the Minimum TTL value inside the SOA is 5 minutes (300 seconds) then DNS resolvers should cache all ohmcar.org negative responses for 300 seconds.

## Choosing negative cache TTL

As the owner of a DNS zone, it is important to set the negative cache TTL value appropriately. If NXDOMAIN responses are cached for too short a time, then the number of queries to the Name Servers for the zone may be higher than desired. On the other hand, if NXDOMAIN responses are cached for too long, they may cause problems.

As an example, suppose a workflow for ohmcar.org includes creating a new DNS record in the zone and then immediately querying for it. If the query were to arrive before the record is fully replicated, then the resolvers might mistakenly cache NXDOMAIN for the new name. This might cause clients to be unable to access the new resource for as long as the negative caching interval.

This type of issue can result in sporadic, unpredictable failures that can be frustrating and difficult to track down. To minimize this, select a moderately short negative caching TTL, such as 60 seconds, and be careful not to design workflows where clients might query for a new DNS record before it is fully provisioned and replicated.

Remember that the negative caching TTL is the minimum of the SOA record TTL and the Minimum TTL within the SOA. If you select a short SOA record TTL, you may accidentally be specifying a shorter negative caching TTL than you intend!

For example, if a zone has a Minimum TTL of 60 seconds but the TTL on the SOA record itself is only 5 seconds, then DNS resolvers will use 5 seconds as the negative cache TTL for all negative responses within that zone.

## Other DNS records at the root of the zone

The SOA record is never the only record at the root of the zone. In addition to exactly one SOA record at the zone root, there must be a set of Name Server records. Most zones have around 4 Name Server records. The SOA and NS records together form the basic identity and definition of the DNS zone.

It is also common to have other DNS records at the root of the zone. MX records to enable mail delivery, TXT records to secure mail delivery, CAA records to specify certificates, DNSKEY and other records if the zone is securely signed, and potentially many others. We will examine these record types in future articles.

There is one type of record that can never exist at the root of the zone: CNAME. CNAME records are forbidden to co-exist with any other record type at any name in the global DNS tree. Some implementations have bent this rule in the past, but most DNS implementations today correctly forbid this. It can be tempting to try to inject a CNAME at the zone root so that ohmcar.org and <www.ohmcar.org> resolve identically, but this is expressly forbidden in the DNS. There are other solutions to that problem that should be employed instead.

## Finding the SOA record for a zone

The SOA record of a zone can be queried with the dig or nslookup command line tools. To find the SOA record for wikipedia.org, use this command:

```dig SOA wikipedia.org```
On operating systems that support nslookup, you can use the following:

```nslookup -type=soa wikipedia.org```
You can also check the SOA record of any domain name in our **[SOA lookup tool](https://www.nslookup.io/soa-lookup/)**, or by entering it here:
