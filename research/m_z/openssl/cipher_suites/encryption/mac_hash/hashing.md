# **[A Definitive Guide to Learn The SHA-256 (Secure Hash Algorithms)](https://www.simplilearn.com/tutorials/cyber-security-tutorial/sha-256-algorithm)**

**[Back to Research List](../../../../research_list.md)**\
**[Back to Current Tasks](../../../../../`a_status/current_tasks.md)**\
**[Back to Main](../../../../../`README.md)**

Among the many advancements seen in network security, encryption and hashing have been the core principles of additional security modules. The secure hash algorithm with a digest size of 256 bits, or the SHA 256 algorithm, is one of the most widely used hash algorithms. While there are other variants, SHA 256 has been at the forefront of real-world applications.

To understand the working of the SHA 256 algorithm and delve deeper into the realm of cybersecurity you need first to understand hashing and its functional characteristics.

## What is Hashing?

Hashing is the process of scrambling raw information to the extent that it cannot reproduce it back to its original form. It takes a piece of information and passes it through a function that performs mathematical operations on the plaintext. This function is called the hash function, and the output is called the hash value/digest.

![i1](https://www.simplilearn.com/ice9/free_resources_article_thumb/hashing1.PNG)

As seen from the above image, the hash function is responsible for converting the plaintext to its respective hash digest. They are designed to be irreversible, which means your digest should not provide you with the original plaintext by any means necessary. Hash functions also provide the same output value if the input remains unchanged, irrespective of the number of iterations.

There are two primary applications of hashing:

Password Hashes: In most website servers, it converts user passwords into a hash value before being stored on the server. It compares the hash value re-calculated during login to the one stored in the database for validation.

![i2](https://www.simplilearn.com/ice9/free_resources_article_thumb/passwords.PNG)

Integrity Verification: When it uploads a file to a website, it also shared its hash as a bundle. When a user downloads it, it can recalculate the hash and compare it to establish data integrity.

![i3](https://www.simplilearn.com/ice9/free_resources_article_thumb/integrity1.PNG)

Now that you understand the working of hash functions, look at the key topic in hand - SHA 256 algorithm.
