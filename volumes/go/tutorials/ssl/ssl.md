# **[How to Implement TLS ft. Golang](https://medium.com/@harsha.senarath/how-to-implement-tls-ft-golang-40b380aae288)**

## references

<https://stackoverflow.com/questions/46992030/how-to-set-up-https-on-golang-web-server>
<https://pkg.go.dev/net/http#ListenAndServeTLS>
<https://github.com/denji/golang-tls>
<https://medium.com/@peterstirrup/serving-multiple-ssl-certificates-in-your-go-tests-2d1046002a64>

## Creating the project

```bash
pushd .
mkdir -p ~/src/repsys/volumes/go/tutorials/ssl/ssl_server
cd ~/src/repsys/volumes/go/tutorials/ssl/ssl_server
go mod init ssl_server
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/ssl/ssl_server
dirs -v
pushd +X # where X is 0 based number from the bottom of dirs -v entries
go get github.com/redis/go-redis/v9
go: added github.com/cespare/xxhash/v2 v2.2.0
go: added github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f
go: added github.com/redis/go-redis/v9 v9.5.1

```

## **[Generate server certificate](../../../../../pki/gen-and-install-certs.md)**

- Generate frt-kors43.linamar.com

## Step 2: Create a configuration file for the server certificate

Before generating our server certificate, we will require a configuration file in order to specify the Common Name (CN) and Subject Alternative Name (SAN) for our server certificate as localhost. This is to ensure that the certificate will be accepted by our client when accessing our local development server running on <https://localhost>.

The CN field in an SSL certificate is used to specify the primary domain name associated with the certificate. However, this field is considered legacy and has been replaced by the SAN field, which allows for multiple domain names to be specified.

Therefore modern browsers and other clients now require the use of the SAN field to properly validate SSL certificates. If our server certificate uses the CN field instead of the SAN field, it can lead to errors in our go code since we are not setting InsecureSkipVerify to true.

In our case the configuration file will look something simple as shown below and we will be saving this into a file named server.cnf . The keyUsage and extendedKeyUsage settings under [v3_ext] section are not mandatory for this implementation.

```yaml
[req]
default_md = sha256
prompt = no
req_extensions = v3_ext
distinguished_name = req_distinguished_name

[req_distinguished_name]
CN = localhost

[v3_ext]
keyUsage = critical,digitalSignature,keyEncipherment
extendedKeyUsage = critical,serverAuth,clientAuth
subjectAltName = DNS:localhost
```

Ours looks like this

```yaml
basicConstraints = critical, CA:FALSE
# zlint ERROR basicConstraints MAY appear in the certificate, 
# and when it is included MUST be marked as critical
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
authorityInfoAccess = OCSP;URI:http://ocsp.busche-cnc.com/,caIssuers;URI:http://busche-cnc.com/ca.html
# https://security.stackexchange.com/questions/252622/what-is-the-purpose-of-certificatepolicies-in-a-csr-how-should-an-oid-be-used
# added because: ERROR No policy extension
# For general purpose CAs, you can use a universal Object Identifier with the value 2.5.29.32.0. This identifier means “All Issuance Policies” and is a sort of wildcard policy. Any policy will match this identifier during certificate chain validation.
# certificatePolicies = 2.5.29.32.0
# https://security.stackexchange.com/questions/264110/how-to-determine-validation-process-of-a-certificate-used-by-a-website-using-htt
certificatePolicies = 2.23.140.1.2.1, 2.5.29.32.0
# certificatePolicies = 1.2.3.4
[alt_names]
DNS.1 = frt-kors43.linamar.com
```

## Step 4: Implement the server using Golang

First of all we need to import the required packages.

- crypto/tls package provides support for secure communication over the network using TLS or SSL.
- log package provides a simple logging interface.
- net/http package provides HTTP client and server implementations.

```golang
import (
  "crypto/tls"
  "log"
  "net/http"
)
```

Next we are going to define some constants for the server. These constants define the server port number and the response message that the server sends to clients.

```golang
const (
  port         = ":8443"
  responseBody = "Hello, TLS!"
)
```

Next we will be loading our server certificate and server private key from the server.crt and server.key files. If there is an error while loading the X509 key pair, the program exits with a fatal log message.

```golang
cert, err := tls.LoadX509KeyPair("server.crt", "server.key")
if err != nil {
  log.Fatalf("Failed to load X509 key pair: %v", err)
}

```

It is important to note here that if your server private key is encrypted with a passphrase you will need to decrypt it first before trying to load it using this code or else you may run into some errors.

Next we create our TLS configuration by creating a new tls.Config struct and setting the Certificates field to the X509 key pair loaded previously.
