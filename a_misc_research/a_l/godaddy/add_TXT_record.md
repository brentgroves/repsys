# **[Add a TXT record](https://www.godaddy.com/help/add-a-txt-record-19232)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

![ci](https://www.godaddy.com/resources/ae/wp-content/uploads/sites/11/how-to-connect-your-domain-name-hosting-account.jpg?size=1920x0)

A TXT record (short for text record) is an informational DNS record used to associate a string of text to a host or other name. They're commonly added to a domain's zone file to verify domain ownership, complete SSL verification, and create email sender policies, such as **[SPF records](https://www.godaddy.com/help/add-an-spf-record-19218)** and DMARC policies.

1. Sign in to your GoDaddy **[Domain Portfolio](https://dcc.godaddy.com/control/portfolio)**. (Need help logging in? **[Find your username or password](https://www.godaddy.com/help/i-cant-sign-in-to-my-godaddy-account-19319)**.)
2. Select an individual domain to access the Domain Settings page.
    ![s2](https://images.ctfassets.net/7y9uzj0z4srt/3fePtruKyjtnYV6gajJMNY/0756bc261c28fac462b4a28a068a9f59/image-domains-11-select-single-domain.png)
3. Select DNS to view your DNS records.
    ![s3](https://images.ctfassets.net/7y9uzj0z4srt/AzpZ76eX9ukVPPqwfNYcA/8d13d01b3f5175a51966ee6546ae45a8/image-domains-37-select-dns-tab.png)
4. Select Add New Record and then select TXT from the Type menu.
5. Enter the details for your new TXT record.
    - Name: The hostname or prefix of the record, without the domain name. Enter @ to put the record on your root domain, or enter a prefix, such as mail. The Name must follow these guidelines:
        - Periods (.) are allowed but not as the first or last character
        - Consecutive periods (…) are not allowed
        - Cannot begin or end with a hyphen (-)
        - 63 characters in a row not separated by a period (.)
            - Example: 63characters.63characters.coolexample.com
        - 255 characters maximum
    - Value: The text string for the record. This is usually provided by your SSL, hosting, or email provider. The Value must follow these guidelines:
        - Maximum 1024 characters are allowed
        - Only ASCII characters are allowed
    - TTL (Time to Live): The amount of time the server should cache information before refreshing. The default setting is 1 hour.
6. (Optional) Select Add More Records to add multiple DNS records at the same time. If you change your mind, select screenshot of the icon for deleting a dns record Delete to remove any records that haven't been saved yet.
7. Select Save to add your new record. If you added multiple records at the same time, select Save All Records.
    - If your domain has **[Domain Protection](https://www.godaddy.com/help/what-is-domain-protection-32311)**, you'll need to verify your identity. If you've had 2-step verification (2SV) turned on for at least 24 hours, enter the code we sent via SMS, or enter the code from your authenticator app. Otherwise, enter the one-time password we sent to your registrant email address.

Most DNS updates take effect within an hour but could take up to 48 hours to update globally.
