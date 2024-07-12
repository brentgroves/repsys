# **[ssh fingerprints](https://docs.ssh-mitm.at/user_guide/fingerprint.html)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## SSH Fingerprints

With SSH, unlike HTTPS secured websites, there are no central certificate providers to ensure that you are connecting to the correct server.

In most cases, a new key is automatically generated during installation. When a client connects to this server for the first time, the offered key is still unknown and you are asked if you want to connect to the server.

## Warning

The fingerprint ensures that you do not connect to a wrong server. One of the most common reasons for unknown fingerprints is the reinstallation of a system where new keys are generated.

However, it can also be a Man in the Middle attack, where the connection was redirected to another server.

For this reason, the fingerprint must always be compared against a trusted source.

## Checking the fingerprint

The first time you connect to a server, you will be asked if you want to connect to the server.

```bash
$ ssh github.com
The authenticity of host 'github.com (140.82.121.3)' can't be established.
RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

In this case, the SSH client wants to connect to Github.com and you are asked if you want to continue with the connection.

You should not simply confirm this query, but compare the fingerprint with a trusted source. Github has published the fingerprints at the following address: <https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints>

If the SSH client offers the possibility to enter a fingerprint, this method is always preferable. You just have to copy the fingerprint from the website and paste it into the terminal.

The reason is that if you compare fingerprints manually, errors can occur and you confirm a similar fingerprint and connect to the wrong server.
