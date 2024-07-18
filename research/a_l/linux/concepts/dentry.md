# **[dentry](https://stackoverflow.com/questions/29870068/what-are-pagecache-dentries-inodes)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

With some oversimplification, let me try to explain in what appears to be the context of your question because there are multiple answers.

It appears you are working with memory caching of directory structures. An inode in your context is a data structure that represents a file. A dentries is a data structure that represents a directory. These structures could be used to build a memory cache that represents the file structure on a disk. To get a directly listing, the OS could go to the dentries--if the directory is there--list its contents (a series of inodes). If not there, go to the disk and read it into memory so that it can be used again.

The page cache could contain any memory mappings to blocks on disk. That could conceivably be buffered I/O, memory mapped files, paged areas of executables--anything that the OS could hold in memory from a file.
