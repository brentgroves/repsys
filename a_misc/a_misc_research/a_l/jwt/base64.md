# **[Base64](https://knowledge.digicert.com/general-information/what-does-base-64-mean#:~:text=Base64%20is%20a%20method%20of,format%20for%20SSL%20certificate%20content.)**

Base64 is a method of encoding binary data as ASCII text. This is necessary for sending files via Internet email, which can only handle 7-bit ASCII text.

## references

<https://knowledge.digicert.com/general-information/what-does-base-64-mean#:~:text=Base64%20is%20a%20method%20of,format%20for%20SSL%20certificate%20content>.
<https://www.base64url.com/>

## Base64

Base64 is the industry standard format for SSL certificate content. The most common web servers will generate a certificate signing requests as well as accept SSL certificates in base-64 format.

The size of the certificate content will depend on the encryption strength of the certificate.

Here is an example of a base64-encoded certificate.

```base64
-----BEGIN CERTIFICATE-----
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
-----END CERTIFICATE-----
```

## The base64 alphabet

The base64 alphabet is shown in the below table.  Whenever the value of a six-bit group matches one of the values in the Value columns, that value is replaced by the seven-bit ASCII value of the corresponding character shown in the Char column to the right of the Value column.

| Value | Char | Value | Char | Value | Char | Value | Char |
|:-----:|:----:|:-----:|:----:|:-----:|:----:|:-----:|:----:|
|   0   |   A  |   17  |   R  |   34  |   i  |   51  |   z  |
|   1   |   B  |   18  |   S  |   35  |   j  |   52  |   0  |
|   2   |   C  |   19  |   T  |   36  |   k  |   53  |   1  |
|   3   |   D  |   20  |   U  |   37  |   l  |   54  |   2  |
|   4   |   E  |   21  |   V  |   38  |   m  |   55  |   3  |
|   5   |   F  |   22  |   W  |   39  |   n  |   56  |   4  |
|   6   |   G  |   23  |   X  |   40  |   o  |   57  |   5  |
|   7   |   H  |   24  |   Y  |   41  |   p  |   58  |   6  |
|   8   |   I  |   25  |   Z  |   42  |   q  |   59  |   7  |
|   9   |   J  |   26  |   a  |   43  |   r  |   60  |   8  |
|   10  |   K  |   27  |   b  |   44  |   s  |   61  |   9  |
|   11  |   L  |   28  |   c  |   45  |   t  |   62  |   +  |
|   12  |   M  |   29  |   d  |   46  |   u  |   63  |   /  |
|   13  |   N  |   30  |   e  |   47  |   v  |  pad  |   =  |
|   14  |   O  |   31  |   f  |   48  |   w  |       |      |
|   15  |   P  |   32  |   g  |   49  |   x  |       |      |
|   16  |   Q  |   33  |   h  |   50  |   y  |       |      |

## WHAT IS RADIX 64 ENCODING?

Radix 64 encoding allows binary data stored in octets (i.e. bytes) to be expressed as printable characters.

Radix-64 characters require the binary input to be split into blocks of 6. These numbers (which all range from 0 - 63) are then mapped onto a character set of printable characters.

The Radix 64 characterset includes:

- A-Z
- a-z
- 0-9
- The additional characters ‘+’ and ‘/’

This amounts to a total of 64 symbols. To encode binary data into Radix 64, data is parsed in 6-bit blocks (i.e. such that each block has a maximum value of 64), and the number represented by each 6-bit block is used to look up a Radix 64 character.

## NUMBER OF OUTPUT BYTES

Radix 64 encoding results in 33% more bytes - every 3 input bytes is converted to 4 output.

Given n input bytes, the output will be:

4⌈n/3⌉

The ceiling brackets ⌈x⌉ mean round the number to the upper integer. In words, this expression would be:

“The number of output characters is n divided by 3, rounded up to the next whole number and then multiplied by 4”.

## EXAMPLE: PGP MESSAGES

A good example is the ascii-armor output from PGP:

```base64
jA0ECgMCl9ViayBOZkZg0kkBDqU+4ofR+bJDXd+cpfAQCk30pFcK4QmtFXYivhqy
N8WrBUN8ala9bJ8ON2+COaB1ls+Pr9ohpiWSQLlC6t6/fQLSsHFLCJq5
=GH0r
```

The above example is the ciphertext (excluding cleartext message headers) that results from ASCII armored symmetric encryption of the string “Hello World!” (additional metadata is added by PGP - including a salt and the cipher algorithm designator).

Note that the encrypted message consists of Radix 64 characters exclusively, with the ‘=’ sign used as padding - so in the message above, data after the ‘=’ is not part of the message. You wouldn’t see this padding if the number of the plaintext bytes was an exact multiple of three (and therefore did not require padding).

By definition, each byte of the original ciphertext was a number from 0-255. Some of these numbers do not map to printable ASCII characters. Encoding the message as Radix 64 allows the message to be printed and/or sent as an email or text message - modes of communication which do not allow the transfer of binary data.

## THE RADIX 64 ALPHABET

| Index R64 value | Index R64 value | Index R64 value | Index R64 value |    |   |         |   |
|-----------------|-----------------|-----------------|-----------------|----|---|---------|---|
| 0               | A               | 17              | R               | 34 | i | 51      | z |
| 1               | B               | 18              | S               | 35 | j | 52      | 0 |
| 2               | C               | 19              | T               | 36 | k | 53      | 1 |
| 3               | D               | 20              | U               | 37 | l | 54      | 2 |
| 4               | E               | 21              | V               | 38 | m | 55      | 3 |
| 5               | F               | 22              | W               | 39 | n | 56      | 4 |
| 6               | G               | 23              | X               | 40 | o | 57      | 5 |
| 7               | H               | 24              | Y               | 41 | p | 58      | 6 |
| 8               | I               | 25              | Z               | 42 | q | 59      | 7 |
| 9               | J               | 26              | a               | 43 | r | 60      | 8 |
| 10              | K               | 27              | b               | 44 | s | 61      | 9 |
| 11              | L               | 28              | c               | 45 | t | 62      | + |
| 12              | M               | 29              | d               | 46 | u | 63      | / |
| 13              | N               | 30              | e               | 47 | v |         |   |
| 14              | O               | 31              | f               | 48 | w | (pad) = |   |
| 15              | P               | 32              | g               | 49 | x |         |   |
| 16              | Q               | 33              | h               | 50 | y |         |   |

## EXAMPLE RADIX 64 ENCODING

Radix 64 encoding can be difficult to get your head around. Before building a programme to do the encoding, it can help to step through the process manually.

This example will encode the string ‘david’ into Radix 64.

- The string is represented by 5 chars.
- The total size in bits (assuming that one char == 1 byte) is given by 8 x 5 = 40 bits.
- Dividing the total number of bits by 6 leaves remainder 4 - therefore 7 sextuplets will be needed to represent the string in Radix 64
- The last sextuplet will have 2 bits of padding. When this is the case, ‘=’ padding character is added.

```table
                +-----------+-----------+-----------+-----------+-----------+
char:           | 'd'       | 'a'       | 'v'       | 'i'       | 'd'       |
                +-----------+-----------+-----------+-----------+-----------+
binary:         | 011001 00 | 0110 0001 | 01 110110 | 011010 01 | 0110 0100 |
                |                                                           |
6 bit groups:   | 011001 | 000110 | 000101 | 110110 | 011010 | 010110 | 0100  | 00  |
Decimal output: | 25     | 6      | 5      | 54     | 26     | 22     | 16    |     |
                +--------+--------+--------+--------+--------+--------+-------+-----+
Radix-64 chars  | Z      | G      | F      | 2      | a      | W      | Q     | =   |
                +--------+--------+--------+--------+--------+--------+-------+-----+
```

## **[Base64 URL encoded standard](https://base64.guru/standards/base64url)**

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
