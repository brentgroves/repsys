# **[What's the meaning of '@' in a DNS zone file?](https://betterstack.com/community/questions/what-is-the-meaning-of-at-sign-in-a-dns-zone-file/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

![ci](https://www.godaddy.com/resources/ae/wp-content/uploads/sites/11/how-to-connect-your-domain-name-hosting-account.jpg?size=1920x0)

In DNS (Domain Name System) zone files, the '@' symbol represents the origin or root of the domain itself. It is used as a placeholder to denote the domain name itself within the zone file.

The '@' symbol is commonly used to refer to the zone's domain name within the file. For example, in a typical zone file for a domain such as "example.com", the '@' symbol represents "example.com" itself. It is a shorthand way of referring to the domain name without explicitly typing it out.

For instance, in a DNS zone file, an 'A' record for the domain's root might look like this:

`@    IN    A    192.0.2.1`

Here, '@' refers to the domain name "example.com". It indicates that the IPv4 address 192.0.2.1 is associated with the root of the "example.com" domain.

Using '@' in the zone file makes it more concise and clear, especially when defining records for the domain itself, rather than repeatedly typing out the full domain name in each record within the zone file.
