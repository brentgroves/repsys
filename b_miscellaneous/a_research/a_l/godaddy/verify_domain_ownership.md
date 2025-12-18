# **[Verify domain ownership (DNS or HTML) for my SSL certificate](https://www.godaddy.com/help/verify-domain-ownership-dns-or-html-for-my-ssl-certificate-7452)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

![ci](https://www.godaddy.com/resources/ae/wp-content/uploads/sites/11/how-to-connect-your-domain-name-hosting-account.jpg?size=1920x0)

Note: We do not follow redirects when we validate your domain ownership.

When requesting an SSL certificate, we might require you verify that you control the domain you're requesting the certificate for. To show you control the domain, there are two options:

| Method                   | How it works                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|--------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| DNS record (Recommended) | Create a TXT record we specify in your domain name's zone (DNS) file                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| HTML page                | Upload an HTML page with content we specify to a distinct directory of the website for the common name you're using You cannot use the HTML method with Wildcard certificates. With the HTML method, the certificate will only be validated for the root domain like coolexample.com. If you need the certificate to cover additional CNAMES like <www.coolexample.com> and blog.coolexample.com, use the DNS record method.  Note: If your enviroment requires that no 'www' value be issued on your certificate, then use HTML validation. |

## DNS record (Recommended)

You will receive an email from us with a TXT value you need to create in your domain name's DNS zone file. Adding this TXT record won't impact your website at all; it's something you can only view through a special tool which performs DNS lookups.

You can only create the TXT record through the company whose nameservers your domain name uses. If your domain name uses our nameservers, see **[Manage DNS records](https://www.godaddy.com/help/manage-dns-records-680)**.

TXT records need to be added to the root level of the domain.

Use the following information to create your TXT record:

| Field       | What to enter                                                                       |
|-------------|-------------------------------------------------------------------------------------|
| Name (Host) | Type @ (If your DNS is hosted outside of GoDaddy, you may need to leave this blank) |
| Value       | Type the entire TXT value we sent you                                               |

Once you've created the DNS record, use the instructions in the **[To verify your domain name ownership section](https://www.godaddy.com/help/verify-domain-ownership-dns-or-html-for-my-ssl-certificate-7452#verify)** of this article to let us know you are ready for us to verify you control the domain.

## To Verify Your Domain Name Ownership

After you add a DNS record or HTML page, you need to let us know that you are ready for us to verify you control the domain.

1. Go to your GoDaddy **[product page](https://account.godaddy.com/products/)**.
2. Select SSL Certificates and select Manage for the certificate you want to verify.
3. Select Check my update.
It can take 5-10 minutes for your verification to complete.
