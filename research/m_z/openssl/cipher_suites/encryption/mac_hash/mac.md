# **[An Overview of What a MAC Does (And Why You Should Care))](https://www.thesslstore.com/blog/what-is-a-message-authentication-code-mac/#:~:text=An%20Overview%20of%20What%20a,hashing%20to%20validate%20data%20integrity)**

**[Back to Research List](../../../../research_list.md)**\
**[Back to Current Tasks](../../../../../`a_status/current_tasks.md)**\
**[Back to Main](../../../../../`README.md)**

## What Is a Message Authentication Code?

A message authentication code (MAC) is a string of code that tells you who created or sent a message you received and whether that data has been altered. It does this in a way that validates the sender’s identity is legitimate (i.e., a MAC authenticates the sender) over the internet using a shared secret (i.e., a private) key known only by the sender and recipient.

A MAC is sometimes called a tag because it’s a shorter piece of authenticating data that gets attached to the message. It’s also sometimes referred to as a keyed hash function because it uses a symmetric key that’s shared between the message sender and recipient. (More on that in a little bit.)

Message authentication codes provide offer two critical properties:

Completeness. A sender can attach this secret string of code to any message and have the intended recipient verify it.
Unforgeability (Security). They also offer security by preventing bad guys who intercept those messages from trying to fake that tag in the future when sending fraudulent messages. How? By preventing them from forging tags for new messages they haven’t seen tagged previously.

A MAC algorithm authenticates the legitimate sender’s identity so you know the data truly came from them. What it doesn’t do is protect the confidentiality of your data.

To put it another way, basically, a MAC helps a recipient check whether:

- A message came from a legitimate sender (because they have the shared secret key), and
- The message has been altered somehow (either accidentally or intentionally) since it was sent (because the MAC uses hashing to validate data integrity).
