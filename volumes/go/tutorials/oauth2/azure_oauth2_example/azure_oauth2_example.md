# OAuth2

Azure OAuth2 example

## references

<https://pkg.go.dev/github.com/hashicorp/cap/jwt>
<https://learn.microsoft.com/en-us/entra/identity-platform/v2-oauth2-auth-code-flow>
<https://www.sohamkamani.com/golang/oauth/>
<https://github.com/twitchdev/authentication-go-sample/blob/main/oidc-authorization-code/main.go>

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
- The identity provider - The external application that authenticates the users identity. (which is Azure in this example)

n this post, we’ll create a Go HTTP server (consumer) that uses Microsoft’s OAuth2 API (service provider) to authenticate the user (client).

Let’s look at an overview of how this would work in practice.

![alt](https://www.sohamkamani.com/golang/oauth/golang-oauth.svg)

Let’s look at how to implement each part:

## Create the Go project

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/oauth2
mkdir azure_oauth2_example
cd azure_oauth2_example
go mod init azure_oath2_example
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/oauth2/azure_oauth2_example
dirs -v
pushd +x

```

## **[Register the web app](register_app.md)**

Dev Account Client Application
Client Id:e0e65e2b-9f59-495a-81fd-b6738ab023fc
value:nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss
Application:b08211fd-0bcf-4700-a70a-e600bc0bcf77
Application ID URI=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77
scope=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read
redirect uri:<http://localhost:8080/oauth/redirect>
Visible to users? Yes
directory name: MSFT
domain: 1hkt5t.onmicrosoft.com
directory id:5269b021-533e-4702-b9d9-72acbc852c97
tenant: 5269b021-533e-4702-b9d9-72acbc852c97

href="<https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?response_type=code&client_id=b08211fd-0bcf-4700-a70a-e600bc0bcf77&scope=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read">>

## Creating the Landing Page

Lets create the first part of the application, which is the landing page. This will be a basic HTML page, with a link that the user can click on to authenticate with Github.

We can create a new file, public/index.html:

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/oauth2/azure_oauth2_example
mkdir public
code public/index.html
```

Enter into index.html

// Line breaks for legibility only

<https://login.microsoftonline.com/{tenant}/oauth2/v2.0/authorize>?
client_id=535fb089-9ff3-47b6-9bfb-4f1264799865
&response_type=code
&redirect_uri=http%3A%2F%2Flocalhost%2Fmyapp%2F
&response_mode=query
&scope=https%3A%2F%2Fgraph.microsoft.com%2Fmail.read
&state=12345
&code_challenge=YTFjNjI1OWYzMzA3MTI4ZDY2Njg5M2RkNmVjNDE5YmEyZGRhOGYyM2IzNjdmZWFhMTQ1ODg3NDcxY2Nl
&code_challenge_method=S256

```html
<!DOCTYPE html>
<html>

<body>
    <a
        href=href="https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?response_type=code&client_id=b08211fd-0bcf-4700-a70a-e600bc0bcf77&scope=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read">
        Login Azure using OAuth2
    </a>
</body>

</html>
```

## Disect Azure Identity Management URL

<https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?response_type=code&client_id=b08211fd-0bcf-4700-a70a-e600bc0bcf77&scope=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read>

- **tenant:** 5269b021-533e-4702-b9d9-72acbc852c97
- **response_type:** code

## **[The Authorization Response](https://www.oauth.com/oauth2-servers/authorization/the-authorization-response/)**

Once the user has finished logging in and approving the request, the authorization server is ready to redirect the user back to the application.
Authorization Code Response

If the request is valid and the user grants the authorization request, the authorization server generates an authorization code and redirects the user back to the application, adding the authorization code and the application’s “state” value to the redirect URL.

## Generating the Authorization Code

The authorization code must expire shortly after it is issued. The OAuth 2.0 spec recommends a maximum lifetime of 10 minutes, but in practice, most services set the expiration much shorter, around 30-60 seconds. The authorization code itself can be of any length, but the length of the codes should be documented.

The link URL has three key parts:

- [https//github.com/login/oauth/authorize](https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize) is the OAuth gateway for Microsoft’s **OAuth flow** for my development account. All OAuth providers have a gateway URL that you have to send the user to in order to proceed.

- client_id=b08211fd-0bcf-4700-a70a-e600bc0bcf77 - this specifies the client ID of the application. This ID will tell Microsoft about the identity of the consumer who is trying to use their OAuth service.

OAuth service providers normally have a portal in which you can register your consumer. On registration, you will receive a client ID (which we are using here as b08211fd-0bcf-4700-a70a-e600bc0bcf77), and a client secret (which we will use later on). For Microsoft, the portal to register new applications can be found by referring to **[EntraID App Registration](register_app.md)**.

- redirect_uri=<http://localhost:8080/oauth/redirect> - specifies the URL to redirect to with the request token, once the user has been authenticated by the service provider. Normally, you will have to set this value on the registration portal as well, to prevent anyone from setting malicious callback URLs.

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
go run main.go
```

Once you click on the “Login to Microsoft EntraID using OAuth2 flow” link, you will be redirected to the familiar login page. However, once you authenticate, you will be redirected to <http://localhost:8080/oauth/redirect>, which will lead to a 404 page on the server.

## Adding a Redirect Route

Once the user authenticates with Microsoft, they get redirected to the redirect URL that was specified earlier.

The Microsoft Identity provider also adds a request token along with the url. In this case, Microsoft adds this as the code parameter, so the redirect URL will actually be something like <http://localhost:8080/oauth/redirect?code=mycode123>, where mycode123 is the request token.

We need this request token and our client secret to get the access token, which is the token that is actually used to get information about the user. We get this access token by making a POST HTTP call to <https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/token> along with the mentioned information.

## Request an access token with a client_secret

**[More Info about Microsoft OAuth2 flow](../../../../../research/microsoft_identity_platform/oauth2/oath2_flow.md)**

Now that you've acquired an authorization_code and have been granted permission by the user, you can redeem the code for an access_token to the resource. Redeem the code by sending a POST request to the /token endpoint:

```http
// Line breaks for legibility only

POST /{tenant}/oauth2/v2.0/token HTTP/1.1
Host: https://login.microsoftonline.com
Content-Type: application/x-www-form-urlencoded

client_id=204196ef-b7fd-461f-89b7-f778e1568c41
&scope=https%3A%2F%2Fgraph.microsoft.com%2Fmail.read
&code=OAAABAAAAiL9Kn2Z27UubvWFPbm0gLWQJVzCTE9UkP3pSx1aXxUjq3n8b2JRLk4OxVXr...
&redirect_uri=http%3A%2F%2Flocalhost%2Fmyapp%2F
&grant_type=authorization_code
&code_verifier=ThisIsntRandomButItNeedsToBe43CharactersLong 
&client_secret=sampleCredentia1s    // NOTE: Only required for web apps. This secret needs to be URL-Encoded.
```
