# OAuth2

## references

<https://www.sohamkamani.com/golang/oauth/>

## Creating an OAuth2 Client in Golang (With Full Examples)

In this post we will see how we can implement OAuth2 authentication in a Go web application.

We will create a working website that can allow a user to sign in using Github authentication.

## How OAuth2 Works

Let’s take a brief look at the OAuth protocol before we jump into implementation.

If you’ve ever seen a dialog like this, then you’ve probably used OAuth before:

![alt](https://www.sohamkamani.com/golang/oauth/oauth-example-screenshot-small.png?ezimgfmt=rs:616x700/rscb1/ng:webp/ngcb1)

Here, we are trying to login to Gitlab using Github to authenticate.

There are three parties in any OAuth mechanism:

- The client - The person, or user who is trying to log in
- The consumer - The application that the client wants to log into (which is Gitlab in this example)
- The service provider - The external application that authenticates the users identity. (which is Github in this example)

n this post, we’ll create a Go HTTP server (consumer) that uses Github’s OAuth2 API (service provider) to authenticate the user (client).

Let’s look at an overview of how this would work in practice.

![alt](https://www.sohamkamani.com/golang/oauth/golang-oauth.svg)

Let’s look at how to implement each part:

## Creating the Landing Page

Lets create the first part of the application, which is the landing page. This will be a basic HTML page, with a link that the user can click on to authenticate with Github.

We can create a new file, public/index.html:

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/http/oauth2/go_oauth2_example
code public/index.html
```

Enter into index.html

```html
<!DOCTYPE html>
<html>
  <body>
    <a
      href="https://github.com/login/oauth/authorize?client_id=myclientid123&redirect_uri=http://localhost:8080/oauth/redirect"
    >
      Login with github
    </a>
  </body>
</html>
```

The link URL has three key parts:

- https//github.com/login/oauth/authorize is the OAuth gateway for Github’s OAuth flow. All OAuth providers have a gateway URL that you have to send the user to in order to proceed.

- client_id=myclientid123 - this specifies the client ID of the application. This ID will tell Github about the identity of the consumer who is trying to use their OAuth service.

OAuth service providers normally have a portal in which you can register your consumer. On registration, you will receive a client ID (which we are using here as myclientid123), and a client secret (which we will use later on). For Github, the portal to register new applications can be found on <https://github.com/settings/applications/new>.

- redirect_uri=<http://localhost:8080/oauth/redirect> - specifies the URL to redirect to with the request token, once the user has been authenticated by the service provider. Normally, you will have to set this value on the registration portal as well, to prevent anyone from setting malicious callback URLs.

## register app

- Register your new application on Github : <https://github.com/settings/applications/new>. In the "callback URL" field, enter "<http://localhost:8080/oauth/redirect>". Once you register, you will get a client ID and client secret.
- Replace the values of the clientID and clientSecret variables in the main.go file and also the index.html file
- Start the server by executing go run main.go
- Navigate to <http://localhost:8080> on your browser.

Client ID
d5e55eb0a1a9b98502f5
Client secrets
20c790ef413d5f5b276868709c615fecf4ba2973

## Setup go progam

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/http/oauth2/go_oauth2_example
go mod init go_oauth2_example
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/http/oauth2/go_oauth2_example

```

## Next, we need to create the HTTP server to serve the index.html file we just made

The following code would go into a new file main.go:

```go
func main() {
 fs := http.FileServer(http.Dir("public"))
 http.Handle("/", fs)

 http.ListenAndServe(":8080", nil)
}
```

You can start the server by executing go run main.go and visit <http://localhost:8080>: You will see the landing page we just made.

```bash
pushd +1
go run main.go
```

Once you click on the “Login with github” link, you will be redirected to the familiar OAuth page to register with Github. However, once you authenticate, you will be redirected to <http://localhost:8080/oauth/redirect>, which will lead to a 404 page on the server.
