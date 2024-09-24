# **[Salt](https://www.crypto-it.net/eng/theory/pbe.html)**

**[Back to Research List](../../../research/research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Salt
The salt is a random number. It is supposed to prevent dictionary attacks. Without the salt, an intruder could use the same PBE algorithms and create a lot of keys for some popular phrases, often used as passwords. Adding a random value makes the combined input to the PBE algorithm completely random. It is no longer possible for the attacker to check all the likely PBE algorithm inputs.

Due to the fact that the salt is random, it is highly unlikely that the same salt would be reused twice, for multiple encryptions. The salt is not a secret value. It may be transmitted along with the ciphertext to the receiver.

Salt values are created by pseudorandom number generators. Ideally, the length of the salt should be the same as the output size of the hash function that was used to create it.

Iteration Count
The key derivation procedure may be made more complicated by running PBE algorithm many times. This would make the process of creating the secret key much more time consuming. Such a situation is certainly acceptable for the user, who has to perform the authentication procedure rarely and doesn't mind short delays. On the other hand, the attacker using brute force attacks and checking thousands of combinations would suffer significantly due to the increased time complexity.

Similarly to the salt, the iteration count may be transmitted to the receiver in the clear, along with the ciphertext.

It is recommended to use 1000 or more iterations to achieve a sufficiently good security level.

Date: 2020-03-09
