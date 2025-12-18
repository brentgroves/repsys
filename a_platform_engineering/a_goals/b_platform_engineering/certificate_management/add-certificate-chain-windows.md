# Instructions for adding our certificate chain to Windows computers

## Add our certificate chain to Windows computers

Our Mach2 servers use SSL certificates that we have generated from our PKI.  We must add the certificate chain to each computer that access the Mach2 servers so the user does not have to bypass a security warning screen.  There are several ways to do this.  

## add to local Windows trust store

```bash
certmgr
# add ca.cert.pem to trusted root certificate authorities
# add intermediate.cert.pem to intermediate certificate authorities
```

## add to Windows trust store using GPO

**[Not quite what we want but close](https://support.securly.com/hc/en-us/articles/206688537-How-to-push-the-Securly-SSL-certificate-with-Active-Directory-GPO
)**

In our PKI we have an intermediate as well as a root CA so we must add a second step to import our intermediate certificate into the trusted intermediate certificate store like we did using certmgr in the previous section.
