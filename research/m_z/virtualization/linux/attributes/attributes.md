# **[](https://www.baeldung.com/linux/lsattr-chattr-attributes)**

4.1. Deletion and Modification
These categories of attributes control how the files and directories can be deleted, modified, or renamed:

Letter Attribute Description
a append-only The file can only be opened in append mode for writing.
i immutable The file can’t be modified, deleted, or renamed.
s secure deletion The kernel securely erases the file when we delete it by overwriting its data blocks with zero.
u undeletable The file can’t be deleted even by the superuser.
