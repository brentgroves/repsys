# **[pypy](https://pypy.org/features.html)**

PyPy is a replacement for CPython. It is built using the RPython language that was co-developed with it. The main reason to use it instead of CPython is speed: it runs generally faster (see next section).

PyPy implements Python 2.7.18, 3.10.14, and 3.9.19. It supports all of the core language. It supports most of the commonly used Python standard library modules. For known differences with CPython, see our compatibility page.

The main features of PyPy:
Speed
Our main executable comes with a Just-in-Time compiler. It is really fast in running most benchmarks—including very large and complicated Python applications, not just 10-liners.

There are two cases that you should be aware where PyPy will not be able to speed up your code:

Short-running processes: if it doesn't run for at least a few seconds, then the JIT compiler won't have enough time to warm up.

If all the time is spent in run-time libraries (i.e. in C functions), and not actually running Python code, the JIT compiler will not help.

So the case where PyPy works best is when executing long-running programs where a significant fraction of the time is spent executing Python code. This is the case covered by the majority of our benchmarks, but not all of them --- the goal of PyPy is to get speed but still support (ideally) any Python program.

Memory usage
Memory-hungry Python programs (several hundreds of MBs or more) might end up taking less space than they do in CPython. It is not always the case, though, as it depends on a lot of details. Also note that the baseline is higher than CPython's.

Stackless
Support for Stackless and greenlets are now integrated in the normal PyPy. More detailed information is available here.

Other features
PyPy has many secondary features and semi-independent projects. We will mention here:

Other languages: we also implemented other languages that makes use of our RPython toolchain: Prolog (almost complete), as well as Smalltalk, JavaScript, Io, Scheme and Gameboy.

There is also a Ruby implementation called Topaz and a PHP implementation called HippyVM.

Sandboxing
PyPy's sandboxing is a working prototype for the idea of running untrusted user programs. Unlike other sandboxing approaches for Python, PyPy's does not try to limit language features considered "unsafe". Instead we replace all calls to external libraries (C or platform
