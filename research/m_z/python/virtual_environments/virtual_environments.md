# **[Python Virtual Environments](https://docs.python.org/3/library/venv.html)**

Changed in version 3.5: The use of venv is now recommended for creating virtual environments.

Deprecated since version 3.6: pyvenv was the recommended tool for creating virtual environments for Python 3.3 and 3.4, and is deprecated in Python 3.6.

## venv — Creation of virtual environments

The venv module supports creating lightweight “virtual environments”, each with their own independent set of Python packages installed in their site directories. A virtual environment is created on top of an existing Python installation, known as the virtual environment’s “base” Python, and may optionally be isolated from the packages in the base environment, so only those explicitly installed in the virtual environment are available.

When used from within a virtual environment, common installation tools such as pip will install Python packages into a virtual environment without needing to be told to do so explicitly.

A virtual environment is (amongst other things):

- Used to contain a specific Python interpreter and software libraries and binaries which are needed to support a project (library or application). These are by default isolated from software in other virtual environments and Python interpreters and libraries installed in the operating system.
- Contained in a directory, conventionally either named venv or .venv in the project directory, or under a container directory for lots of virtual environments, such as ~/.virtualenvs.
- Not checked into source control systems such as Git.
- Considered as disposable – it should be simple to delete and recreate it from scratch. You don’t place any project code in the environment
- Not considered as movable or copyable – you just recreate the same environment in the target location.

See **[PEP 405](https://peps.python.org/pep-0405/)** for more background on Python virtual environments.

See also **[Python Packaging User Guide](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#create-and-use-virtual-environments)**: Creating and using virtual environments
**[Availability](https://docs.python.org/3/library/intro.html#availability)**: not Emscripten, not WASI.

This module does not work or is not available on **[WebAssembly](https://webassembly.org/)** platforms wasm32-emscripten and wasm32-wasi. See WebAssembly platforms for more information.

## Notes on availability

An “Availability: Unix” note means that this function is commonly found on Unix systems. It does not make any claims about its existence on a specific operating system.

If not separately noted, all functions that claim “Availability: Unix” are supported on macOS, which builds on a Unix core.

If an availability note contains both a minimum Kernel version and a minimum libc version, then both conditions must hold. For example a feature with note Availability: Linux >= 3.17 with glibc >= 2.27 requires both Linux 3.17 or newer and glibc 2.27 or newer.

## WebAssembly platforms

The WebAssembly platforms wasm32-emscripten (Emscripten) and wasm32-wasi (WASI) provide a subset of POSIX APIs. WebAssembly runtimes and browsers are sandboxed and have limited access to the host and external resources. Any Python standard library module that uses processes, threading, networking, signals, or other forms of inter-process communication (IPC), is either not available or may not work as on other Unix-like systems. File I/O, file system, and Unix permission-related functions are restricted, too. Emscripten does not permit blocking I/O. Other blocking operations like sleep() block the browser event loop.

The properties and behavior of Python on WebAssembly platforms depend on the Emscripten-SDK or WASI-SDK version, WASM runtimes (browser, NodeJS, wasmtime), and Python build time flags. WebAssembly, Emscripten, and WASI are evolving standards; some features like networking may be supported in the future.

For Python in the browser, users should consider Pyodide or PyScript. PyScript is built on top of Pyodide, which itself is built on top of CPython and Emscripten. Pyodide provides access to browsers’ JavaScript and DOM APIs as well as limited networking capabilities with JavaScript’s XMLHttpRequest and Fetch APIs.

Process-related APIs are not available or always fail with an error. That includes APIs that spawn new processes (fork(), execve()), wait for processes (waitpid()), send signals (kill()), or otherwise interact with processes. The subprocess is importable but does not work.

The socket module is available, but is limited and behaves differently from other platforms. On Emscripten, sockets are always non-blocking and require additional JavaScript code and helpers on the server to proxy TCP through WebSockets; see Emscripten Networking for more information. WASI snapshot preview 1 only permits sockets from an existing file descriptor.

Some functions are stubs that either don’t do anything and always return hardcoded values.

Functions related to file descriptors, file permissions, file ownership, and links are limited and don’t support some operations. For example, WASI does not permit symlinks with absolute file names.
