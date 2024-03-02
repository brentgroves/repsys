# **[Base64 URL encoded standard](https://base64.guru/standards/base64url)**

Base64URL is a modification of the main Base64 standard, the purpose of which is the ability to use the encoding result as filename or URL address.

## Base64URL

Base64URL is a modification of the main Base64 standard, the purpose of which is the ability to use the encoding result as filename or URL address. The Base64URL is described in RFC 4648 § 5, where it is mentioned that the standard Base64 alphabet contains invalid characters for URLs and filenames.

The first problem is that the main standard uses “+” as the 62rd character and “=” as padding character. Both characters have a special meaning in the URI address: “+” is interpreted as space, while “=” is used to send data via query string as “key=value” pair. As you understand, using these symbols may lead to various errors.

The second problem — the main standard uses “/” as the 63rd character, which both for URL addresses and for file system locations, represents the directory separator. Therefore in this case errors are guaranteed.

To avoid the errors above, it was proposed to use a “safe alphabet” for URL addresses and filenames. Thus, the Base64URL was born. It uses the same algorithm as the main standard, but differs in the following:

- Replaces “+” by “-” (minus)
- Replaces “/” by “_” (underline)
- Does not require a padding character
- Forbids line separators

For example, the main standard will encode <<???>> to PDw/Pz8+Pg== while Base64URL will convert it to PDw_Pz8-Pg. As you can see, only special characters have been changed, while the letters and digits have remained intact.

If you want to see it in action, check the following tools:

- **[Base64URL Encoder](https://base64.guru/standards/base64url/encode)**
- **[Base64URL Decoder](https://base64.guru/standards/base64url/decode)**
This page would be incomplete without Base64URL characters table. So, meet it:

| Value Encoding | Value Encoding | Value Encoding | Value Encoding |
|----------------|----------------|----------------|----------------|
| 0 A            | 17 R           | 34 i           | 51 z           |
| 1 B            | 18 S           | 35 j           | 52 0           |
| 2 C            | 19 T           | 36 k           | 53 1           |
| 3 D            | 20 U           | 37 l           | 54 2           |
| 4 E            | 21 V           | 38 m           | 55 3           |
| 5 F            | 22 W           | 39 n           | 56 4           |
| 6 G            | 23 X           | 40 o           | 57 5           |
| 7 H            | 24 Y           | 41 p           | 58 6           |
| 8 I            | 25 Z           | 42 q           | 59 7           |
| 9 J            | 26 a           | 43 r           | 60 8           |
| 10 K           | 27 b           | 44 s           | 61 9           |
| 11 L           | 28 c           | 45 t           | 62 - (minus)   |
| 12 M           | 29 d           | 46 u           | 63 _           |
| 13 N           | 30 e           | 47 v           | (underline)    |
| 14 O           | 31 f           | 48 w           |                |
| 15 P           | 32 g           | 49 x           |                |
| 16 Q           | 33 h           | 50 y           | (pad) =        |

**[base64_URL_encoder](https://base64.guru/standards/base64url/encode)**

## **[Base64 URL encoded](https://www.base64url.com/)**

Transform strings between plain text, base64 and base64 which is safe to use in URL's

## About Base64

Base64 is a group of similar binary-to-text encoding schemes that represent binary data in an ASCII string format by translating it into a radix-64 representation. The term Base64 originates from a specific MIME content transfer encoding. Each base64 digit represents exactly 6 bits of data.

## **[Radix 64 Encoding: Implementation in C](https://dev-notes.eu/2018/08/radix-64-encoding-with-example-implementation-in-c/)**

Radix 64 or base 64 is a binary-to-text encoding system that is designed to allow binary data to be represented in ASCII string format. This is an educational project accepts a string from a user and Radix 64 encodes it.
