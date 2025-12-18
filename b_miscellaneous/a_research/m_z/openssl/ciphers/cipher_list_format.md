# # **[CIPHER LIST FORMAT](https://docs.openssl.org/3.3/man1/openssl-ciphers/#cipher-list-format)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

The cipher list consists of one or more cipher strings separated by colons. Commas or spaces are also acceptable separators but colons are normally used.

The cipher string may reference a cipher using its standard name from the IANA TLS Cipher Suites Registry (<https://www.iana.org/assignments/tls-parameters/tls-parameters.xhtml#tls-parameters-4>).

The actual cipher string can take several different forms.

It can consist of a single cipher suite such as RC4-SHA.

It can represent a list of cipher suites containing a certain algorithm, or cipher suites of a certain type. For example SHA1 represents all ciphers suites using the digest algorithm SHA1 and SSLv3 represents all SSL v3 algorithms.

Lists of cipher suites can be combined in a single cipher string using the + character. This is used as a logical and operation. For example SHA1+DES represents all cipher suites containing the SHA1 and the DES algorithms.

Each cipher string can be optionally preceded by the characters !, - or +.

If ! is used then the ciphers are permanently deleted from the list. The ciphers deleted can never reappear in the list even if they are explicitly stated.

If - is used then the ciphers are deleted from the list, but some or all of the ciphers can be added again by later options.

If + is used then the ciphers are moved to the end of the list. This option doesn't add any new ciphers it just moves matching existing ones.

If none of these characters is present then the string is just interpreted as a list of ciphers to be appended to the current preference list. If the list includes any ciphers already present they will be ignored: that is they will not moved to the end of the list.

The cipher string @STRENGTH can be used at any point to sort the current cipher list in order of encryption algorithm key length.

The cipher string @SECLEVEL=n can be used at any point to set the security level to n, which should be a number between zero and five, inclusive. See SSL_CTX_set_security_level(3) for a description of what each level means.

The cipher list can be prefixed with the DEFAULT keyword, which enables the default cipher list as defined below. Unlike cipher strings, this prefix may not be combined with other strings using + character. For example, DEFAULT+DES is not valid.

The content of the default list is determined at compile time and normally corresponds to ALL:!COMPLEMENTOFDEFAULT:!eNULL.
