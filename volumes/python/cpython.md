# **[cpython]()**

CPython is the reference implementation of the Python programming language. Written in C and Python, CPython is the default and most widely used implementation of the Python language.

CPython can be defined as both an interpreter and a compiler as it compiles Python code into bytecode before interpreting it. It has a foreign function interface with several languages, including C, in which one must explicitly write bindings in a language other than Python.

## Design

A particular feature of CPython is that it makes use of a global interpreter lock (GIL) on each CPython interpreter process, which means that within a single process, only one thread may be processing Python bytecode at any one time.[2] This does not mean that there is no point in multithreading; the most common multithreading scenario is where threads are mostly waiting on external processes to complete.

This can happen when multiple threads are servicing separate clients. One thread may be waiting for a client to reply, and another may be waiting for a database query to execute, while the third thread is actually processing Python code.

However, the GIL does mean that CPython is not suitable for processes that implement CPU-intensive algorithms in Python code that could potentially be distributed across multiple cores.

In real-world applications, situations where the GIL is a significant bottleneck are quite rare. This is because Python is an inherently slow language and is generally not used for CPU-intensive or time-sensitive operations. Python is typically used at the top level and calls functions in libraries to perform specialized tasks. These libraries are generally not written in Python, and Python code in another thread can be executed while a call to one of these underlying processes takes place. The non-Python library being called to perform the CPU-intensive task is not subject to the GIL and may concurrently execute many threads on multiple processors without restriction.

Concurrency of Python code can only be achieved with separate CPython interpreter processes managed by a multitasking operating system. This complicates communication between concurrent Python processes, though the multiprocessing module mitigates this somewhat; it means that applications that really can benefit from concurrent Python-code execution can be implemented with limited overhead.

The presence of the GIL simplifies the implementation of CPython, and makes it easier to implement multi-threaded applications that do not benefit from concurrent Python code execution. However, without a GIL, multiprocessing apps must make sure all common code is thread safe.

Although many proposals have been made to eliminate the GIL, the general consensus has been that in most cases, the advantages of the GIL outweigh the disadvantages; in the few cases where the GIL is a bottleneck, the application should be built around the multiprocessing structure. To help allow more parallelism, an improvement was released in October 2023 to allow a separate GIL per subinterpreter in a single Python process and have been described as "threads with opt-in sharing".[3][4]

After several debates, a project was launched in 2023 to propose making the GIL optional from version 3.13 of Python,[5] which is scheduled for release in October 2024.[6]
