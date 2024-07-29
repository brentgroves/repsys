# **[pyopenssl](https://pypi.org/project/pyOpenSSL/)**

## installation

```bash
pip install pyOpenSSL
```

Warning
As of 0.14, pyOpenSSL is a pure-Python project. That means that if you encounter any kind of compiler errors, pyOpenSSL’s bugtracker is the wrong place to report them because we cannot help you.

Please take the time to read the errors and report them/ask help from the appropriate project. The most likely culprit being cryptography that contains OpenSSL’s library bindings.

Supported OpenSSL Versions¶
pyOpenSSL supports the same platforms and releases as the upstream cryptography project does. Currently that means:

```bash
1.1.0
1.1.1
3.0
```

You can always find out the versions of pyOpenSSL, cryptography, and the linked OpenSSL by running python -m OpenSSL.debug.

Note: The Python Cryptographic Authority strongly suggests the use of pyca/cryptography where possible. If you are using pyOpenSSL for anything other than making a **TLS connection** you should move to cryptography and drop your pyOpenSSL dependency.

High-level wrapper around a subset of the OpenSSL library. Includes

- SSL.Connection objects, wrapping the methods of Python’s portable sockets
- Callbacks written in Python
- Extensive error-handling mechanism, mirroring OpenSSL’s error codes

 and much more.

You can find more information in the **[documentation](https://pyopenssl.org/)**. Development takes place on **[GitHub](https://github.com/pyca/pyopenssl)**.

## **[Welcome to pyOpenSSL’s documentation!](https://www.pyopenssl.org/en/latest/)**

pyOpenSSL is a rather thin wrapper around (a subset of) the OpenSSL library. With thin wrapper we mean that a lot of the object methods do nothing more than calling a corresponding function in the OpenSSL library.

## History

pyOpenSSL was originally created by Martin Sjögren because the SSL support in the standard library in Python 2.1 (the contemporary version of Python when the pyOpenSSL project was begun) was severely limited. Other OpenSSL wrappers for Python at the time were also limited, though in different ways.

Later it was maintained by Jean-Paul Calderone who among other things managed to make pyOpenSSL a pure Python project which the current maintainers are very grateful for.

Over the time the standard library’s ssl module improved, never reaching the completeness of pyOpenSSL’s API coverage. pyOpenSSL remains the only choice for full-featured TLS code in Python versions 3.7+ and PyPy.
