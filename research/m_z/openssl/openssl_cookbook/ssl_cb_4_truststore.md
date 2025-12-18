# **[1.1.4 Building a Trust Store](https://www.feistyduck.com/library/openssl-cookbook/online/openssl-command-line/building-a-trust-store.html)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

OpenSSL does not come with a collection of trusted root certificates (also known as a root store or a trust store), so if you’re installing from scratch you’ll have to find them somewhere else. One possibility is to use the trust store built into your operating system, as I’ve shown earlier. This choice is usually fine, but the built-in trust stores may not always be up to date. Also, in a mixed environment there could be meaningful differences between the default stores in a variety of systems. A consistent and possibly better choice—but one that involves more work—is to reuse Mozilla’s work. Mozilla put a lot of effort into maintaining a transparent and up-to-date root store for use in Firefox.1

Because it’s open source, Mozilla keeps the trust store in the source code repository:

<https://hg.mozilla.org/releases/mozilla-beta/file/tip/security/nss/lib/ckfw/builtins/certdata.txt>

Unfortunately, its certificate collection is in a proprietary format, which is not of much use to others as is. If you don’t mind getting the collection via a third party, the Curl project provides a regularly updated conversion in Privacy-Enhanced Mail (PEM) format, which you can use directly:

<http://curl.haxx.se/docs/caextract.html>

If you’d rather work directly with Mozilla, you can convert its data using the same tool that the Curl project is using. You’ll find more information about it in the following section.

Note
If you have an itch to write your own conversion script, note that Mozilla’s root certificate file is not a simple list of certificates. Although most of the certificates are those that are considered trusted, there are also some that are explicitly disallowed. Additionally, some certificates may only be considered trusted for certain types of usage. The Perl script I describe here is smart enough to know the difference.

At this point, what you have is a root store with all trusted certificates in the same file. This will work fine if you’re only going to be using it with, say, the s_client tool. In that case, all you need to do is point the -CAfile switch to your root store. Replacing the root store on a server will require more work, depending on what operating system is used.

On Ubuntu, for example, you’ll need to replace the contents of the /etc/ssl/certs folder. Ubuntu ships with a tool called update-ca-certificates that might work. Alternatively, you could make the changes manually by replicating the structure of the existing data. From the looks of it, that folder contains the trusted certificates as individual files, as well as all of them in a single file called ca-certificates.crt. You will also observe some symbolic links; they are created by the OpenSSL’s rehash or c_rehash tools. The drawback of any manual changes is that they may be overwritten when the system is updated.

1.1.4.1 Manual Conversion
To convert Mozilla’s root store, the Curl project uses a Perl script originally written by Guenter Knauf. This script is part of the Curl project, but you can download it directly by following this link:

<https://raw.githubusercontent.com/curl/curl/master/scripts/mk-ca-bundle.pl>

After you download and run the script, it will fetch the certificate data from Mozilla and convert it to the PEM format:

```bash
$ ./mk-ca-bundle.pl 
SHA256 of old file: 0
Downloading certdata.txt ...
Get certdata with curl!
[...]
Downloaded certdata.txt
SHA256 of new file: cc6408bd4be7fbfb8699bdb40ccb7f6de5780d681d87785ea362646e4dad5e8e
Processing  'certdata.txt' ...
Done (138 CA certs processed, 30 skipped).
```

If you keep previously downloaded certificate data around, the script will use it to determine what changed and process only the updates.
