# **[Heap Memory](https://opendsa-server.cs.vt.edu/ODSA/Books/CS2/html/HeapMem.html#:~:text=%E2%80%9CHeap%E2%80%9D%20memory%2C%20also%20known,is%20different%20in%20every%20way.)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Heap Memory

“Heap” memory, also known as “dynamic” memory, is an alternative to local stack memory. Local memory is quite automatic. Local variables are allocated automatically when a function is called, and they are deallocated automatically when the function exits. Heap memory is different in every way. The programmer explicitly requests that space be allocated, using the new operator in Java or C++. This memory “block” will be of a particular size, ususally determined automatically from the size of the object being created. That memory block (your object) continues to be allocated until something happens that makes it go away. In some languages (noteably, C and C++), an object in heap memory only goes away when the programmer explicitly requests that it be deallocated. So the programmer has much greater control of memory, but with greater responsibility since the memory must now be actively managed. Dropping all references to a memory location without deallocating it is a signficant source of errors in C/C++, and this is so common that it has a name: memory leak. (In fact, many commercial programs implemented in C++ have memory leaks, that will eventually make them crash after being used for a long time.) Java removes this source of errors by handling memory deallocation automatically, using garbage collection. The downside is that garbage collection is a slow process that happens at unpredictable times.
