<https://github.com/microsoft/homebrew-mssql-release/issues/59>

pyodbc might use the python ssl module which is linked to openssl

<https://docs.python.org/3/library/ssl.html>

<https://docs.python.org/3/library/ssl.html>

<https://discuss.python.org/t/our-future-with-openssl/21486>

The Python ssl module is designed to work with newer versions of OpenSSL, specifically requiring OpenSSL 1.1.1 or newer. This requirement ensures access to modern security features and consistent behavior.
Here's a breakdown:
Minimum Version: Python's ssl module requires OpenSSL 1.1.1 or newer.
Recommended Version: OpenSSL 3.0.9 is the recommended minimum version for the ssl and hashlib extension modules.
Compatibility: Python versions 3.6 to 3.9 are compatible with OpenSSL 1.0.2, 1.1.0, and 1.1.1. However, newer Python versions are built against OpenSSL 1.1.1 or later.
TLS 1.3 Support: TLS 1.3 support is available when using OpenSSL 1.1.1 or newer.
Build Issues: If you encounter issues building the _ssl or_hashlib modules during Python installation, it's likely due to an older OpenSSL version.
Deprecation Warnings: Using deprecated constants or functions will result in deprecation warnings.
Updating OpenSSL: If your system's OpenSSL version is too old, you may need to manually install a newer version.
Python's Internal SSL: The ssl module is embedded within the Python interpreter, meaning updates to the module often come with Python updates.
In summary, the Python ssl module is compatible with newer OpenSSL versions, with 1.1.1 being the minimum requirement and 3.0.9 being the recommended minimum. Ensure your OpenSSL version meets these requirements to avoid compatibility issues and take advantage of the latest security features.
