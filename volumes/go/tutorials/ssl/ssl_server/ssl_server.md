# **[How to set up HTTPS on golang web server?](https://stackoverflow.com/questions/46992030/how-to-set-up-https-on-golang-web-serve)**

## references

<https://pkg.go.dev/net/http#ListenAndServeTLS>
~/src/pki/intermediateCA/certs/frt-kors43.linamar.com.san.cert.pem
~/src/pki/intermediateCA/certs/server-chain/frt-kors43.linamar.com-ca-chain-bundle.cert.pem
~/src/pki/intermediateCA/private/frt-kors43.linamar.com.san.key.pem

ListenAndServeTLS acts identically to ListenAndServe, except that it expects HTTPS connections. Additionally, files containing a certificate and matching private key for the server must be provided. If the certificate is signed by a certificate authority, the certFile should be the concatenation of the server's certificate, any intermediates, and the CA's certificate.

```golang
// Use https://golang.org/pkg/net/http/#ListenAndServeTLS

http.HandleFunc("/", handler)
log.Printf("About to listen on 10443. Go to https://127.0.0.1:10443/")
err := http.ListenAndServeTLS(":10443", "full-cert.crt", "private-key.key", nil)
log.Fatal(err)
```

For Go you need one certificate file (containing one or more certs, starting with yours) and one private key file (containing one private key).

This isn't really a go question, but the intermediate certs are required because computers only store root certs. By concatenating them you put them all in one file so the browser gets all certs - this is a required step otherwise your server will fail on certain devices. Your cert provider will provide instructions for doing this.

<https://kb.wisc.edu/page.php?id=18923>

To combine the certs you can just use cat (making sure they have a line feed at the end of the file first), something like:

cat example.com.ca-crt example.com.ca-bundle > example.com.crt

I'm not sure why that cat cmd doesn't work on me, but I merged them manually with text editor it works well now. Thank you! –
DTechnlogy
 CommentedFeb 8, 2021 at 17:11

The most common reason for cat not working would be the lack of a new line at the end of the first file). –
Kenny Grant
 CommentedMay 7, 2021 at 10:02
