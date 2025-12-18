# **[Validate GoDaddy to AWS migration](https://www.virtuallyboring.com/migrate-godaddy-domain-and-dns-to-aws-route-53/)**

Now We Wait: Since this is DNS we are working with we have to wait for the TTL (Time To Live) to expire and global DNS servers start refreshing records. To check this externally you can use a third party website like <https://www.whatsmydns.net/>

Enter your domain name, change the drop down to NS (Nameserver) then click Search, this will show you what DNS servers around the globe are reporting back with as they sync:

![i](https://www.virtuallyboring.com/wp-content/uploads/2020/11/Whats-my-dns.png)

## Ping A records

```bash
ping example.com
```
