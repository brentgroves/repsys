# **[Add an A record](https://www.godaddy.com/help/add-an-a-record-19238)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

![ci](https://www.godaddy.com/resources/ae/wp-content/uploads/sites/11/how-to-connect-your-domain-name-hosting-account.jpg?size=1920x0)

Connect your **[domain](https://www.godaddy.com/domains)** to your website by adding an A record to your **[DNS zone](https://www.godaddy.com/help/what-is-dns-665)** file when your domain is using **[GoDaddy nameservers](https://www.godaddy.com/help/edit-my-domain-nameservers-664)**. A records, or address records, are the most fundamental type of DNS record and are used to indicate the IP address of a domain. The most common A record is for the root domain, like mycoolnewbusiness.com, and typically connects the domain to a hosting account.

A records are also used to **[create subdomains](https://www.godaddy.com/help/add-a-subdomain-4080)** that connects to an IP address, such as blog.mycoolnewbusiness.com. If you need a subdomain that connects to another domain, you'll need to **[add a CNAME record](https://www.godaddy.com/help/add-a-cname-record-19236)** instead.

1. Sign in to your GoDaddy **[Domain Portfolio](https://dcc.godaddy.com/control/portfolio)**. (Need help logging in? Find your username or password.)
2. Select an individual domain to access the Domain Settings page.
    ![d](https://images.ctfassets.net/7y9uzj0z4srt/3fePtruKyjtnYV6gajJMNY/0756bc261c28fac462b4a28a068a9f59/image-domains-11-select-single-domain.png)

3. Select DNS to view your DNS records.

    ![dr](https://images.ctfassets.net/7y9uzj0z4srt/AzpZ76eX9ukVPPqwfNYcA/8d13d01b3f5175a51966ee6546ae45a8/image-domains-37-select-dns-tab.png)

4. Select Add New Record and then select A from the Type menu.
5. Enter the details for your new A record.

    - Name: The hostname or prefix of the A record, without the domain name. Enter @ to put the record on your root domain, or enter a prefix, such as blog or shop, to create a subdomain that points to an IP address. The Name must follow these guidelines:
        - Periods (.) are allowed but not as the first or last character
        - Consecutive periods (…) are not allowed
        - Cannot begin or end with a hyphen (-)
        - 63 characters in a row not separated by a period (.)
                Example: 63characters.63characters.coolexample.com
        - 255 characters maximum
    - Value: The IP address the record corresponds to. This is commonly the IP address for a hosting account.
        - Select Add another value to add more IP addresses to this record.
    - TTL (Time to Live): The amount of time the server should cache information before refreshing. The default setting is 1 hour.

6. (Optional) Select Add More Records to add multiple DNS records at the same time. If you change your mind, select screenshot of the icon for deleting a dns record Delete to remove any records that haven't been saved yet.

7. Select Save to add your new record. If you added multiple records at the same time, select Save All Records.

    - If your domain has **[Domain Protection](https://www.godaddy.com/help/what-is-domain-protection-32311)**, you'll need to verify your identity. If you've had 2-step verification (2SV) turned on for at least 24 hours, enter the code we sent via SMS, or enter the code from your authenticator app. Otherwise, enter the one-time password we sent to your registrant email address.

## A records

- httpbin.linamar.com
- repsys.linamar.com
- requester.linamar.com
- helloworld.linamar.com
- bookinfo.linamar.com
