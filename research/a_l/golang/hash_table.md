# **[What are hash tables?](https://domino.ai/data-science-dictionary/hash-table)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

Hash tables are a type of data structure in which the address/index value of the data element is generated from a hash function. This enables very fast data access as the index value behaves as a key for the data value.

In other words, **hash tables store key-value pairs but the key is generated through a hashing function**. So the search and insertion function of a data element becomes much faster as the key values themselves become the index of the array which stores the data. During lookup, the key is hashed and the resulting hash indicates where the corresponding value is stored.

## Hash table architectural overview
