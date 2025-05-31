# **[SSL/TLS Analysis & Attacks](https://hackmd.io/@secureitmania/HJQIwoA9n)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

- Vulnerabilities
- Weak Protocols Enabled (SSLv2, SSLv3, TLSv1.0, TLSv1.1)
- Heartbleed Attack
- Weak signature algorithm
- TLS 1.2 Vulnerabilities
- Secure Client-Initiated Renegotiation
- Expired SSL Certificate

To scan the website use the below sslscan command

```bash
sslscan --show-sigs target.com:port
```

## Weak Protocols Enabled

SSLv2, SSLv3, TLS 1.0 & TLS 1.1 protocols are considered as weak protocols.

The above protocols are vulnerable to several attacks such as DROWN Attack, POODLE Attack, BEAST Attack, Renegotiation Attack, Lucky Thirteen and SWEET32
