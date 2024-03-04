# Go Oidc example

## references

<https://thedevelopercafe.com/articles/jwt-with-go-52d6bbcaa2bf>
<https://github.com/twitchdev/authentication-go-sample/blob/main/oidc-authorization-code/main.go>

## **[Important Claim note](https://stackoverflow.com/questions/48786606/oid-claim-is-missing-in-microsoft-id-token-claims)**

You must request the profile scope to see the oid claim

## **[OpenID Connect on the Microsoft identity platform](https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc)**

Do this when you have a web app that needs to identify a user. If you want a web api to have access to azure services such as sending email then go to **[expose web api](../../registration/expose_web_api.md)** or just and/or use a library such as masl.

OpenID Connect (OIDC) extends the OAuth 2.0 authorization protocol for use as an additional authentication protocol. You can use OIDC to enable single sign-on (SSO) between your OAuth-enabled applications by using a security token called an ID token.

The full specification for OIDC is available on the OpenID Foundation's website at **[OpenID Connect Core 1.0 specification](https://openid.net/specs/openid-connect-core-1_0.html)**.

## **[more info](../../../../../research/microsoft_identity_platform/oidc/openid_connect.md)

## **[register app with Azure](../../../../../research/microsoft_identity_platform/oidc/openid_connect.md)**

## Creating the project

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/oidc
mkdir go_oidc_example
cd go_oidc_example
go mod init go_oidc_example
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/oidc/go_oidc_example
pushd +X # where X is 0 based number from the bottom of dirs -v entries
mkdir public 
touch public/index.html
```

## Creating the Landing Page

Lets create the first part of the application, which is the landing page. This will be a basic HTML page, with a link that the user can click on to authenticate with Github.

We can create a new file, public/index.html:
Enter into index.html

```html
<!DOCTYPE html>
<html>
  <body>
    <a href="https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?
    client_id=d6b668c7-e181-4415-b6fe-fb7a76d48d4a
    &response_type=id_token
    &redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Foauth%2Fredirect
    &response_mode=form_post
    &scope=openid profile
    &state=12345
    &nonce=678910">
        Login Azure OpenID Connect
    </a>
  </body>
</html>
```

## **[Disect Azure OIDC URL](../../../../../research/microsoft_identity_platform/oidc/openid_connect.md)**

## Next, we need to create the HTTP server to serve the index.html file we just made

The following code would go into a new file main.go:

```go
func main() {
 fs := http.FileServer(http.Dir("public"))
 http.Handle("/", fs)

 http.ListenAndServe(":8080", nil)
}
```

## **[Parsing JWT Token](https://thedevelopercafe.com/articles/jwt-with-go-52d6bbcaa2bf)**

Parsing JWT tokens and extracing data from it can be done using the jwt.ParseWithClaims function (there is another function jwt.Parse which will allow you to just parse and check if token is valid).

## Dev Account

openid config document: <https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/v2.0/.well-known/openid-configuration>

repsys requestor
Application (client) Id: d6b668c7-e181-4415-b6fe-fb7a76d48d4a
Object Id: a9251d7f-ad2a-4d38-8540-1999682ff935
Directory (tenant) Id: 5269b021-533e-4702-b9d9-72acbc852c97
Supported account types:My organization only
platform: web
OpenID Connect metadata document
Had to create a scope but did not assign an Authorized client applications.
Did not use the scope like in the OAuth2 example instead just set scope=openid
api://d6b668c7-e181-4415-b6fe-fb7a76d48d4a

```html
<a href="https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?
client_id=d6b668c7-e181-4415-b6fe-fb7a76d48d4a
&response_type=id_token
&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Foauth%2Fredirect
&response_mode=form_post
&scope=openid profile
&state=12345
&nonce=678910">
    Login Azure OpenID Connect
</a>
```

You can start the server by executing go run main.go and visit <http://localhost:8080>: You will see the landing page we just made.

```bash
pushd +1
go run main.go
```

Once you click on the “Login with Azure OIDC” link, you will be redirected to the familiar OAuth page to register with Github. However, once you authenticate, you will be redirected to <http://localhost:8080/oauth/redirect>, which will lead to a 404 page on the server.

## **[Parsing JWT Token](https://thedevelopercafe.com/articles/jwt-with-go-52d6bbcaa2bf)**

Parsing JWT tokens and extracing data from it can be done using the jwt.ParseWithClaims function (there is another function jwt.Parse which will allow you to just parse and check if token is valid).

<https://pkg.go.dev/github.com/golang-jwt/jwt/v5@v5.2.0#readme-installation-guidelines>

<https://pkg.go.dev/github.com/golang-jwt/jwt/v5#example-Parse-Hmac>

// Parse takes the token string and a function for looking up the key. The latter is especially
// useful if you use multiple keys for your application.  The standard is to use 'kid' in the
// head of the token to identify which key to use, but the parsed token (head and claims) is provided
// to the callback, providing flexibility.

```go
var jwtToken string // a token generated from previous code
var userClaim UserClaim

token, err := jwt.ParseWithClaims(jwtToken, &userClaim, func(token *jwt.Token) (interface{}, error) {
 return []byte(key), nil
})
```

```bash
go get -u github.com/MicahParks/keyfunc/v3
```

## Personal Account

openid config document: <https://login.microsoftonline.com/07476fd3-6a57-4e3f-80ab-a1be2af5d10a/v2.0/.well-known/openid-configuration>

repsys requestor
Application (client) Id: 3d156079-1781-42d2-9ba1-ee541109edca
Object Id: 26d30dca-23e8-471c-b4f0-5377cf2844be
Directory (tenant) Id: 07476fd3-6a57-4e3f-80ab-a1be2af5d10a
Supported account types:My organization only
platform: web

Dev Account Client Application
secret/client id:e0e65e2b-9f59-495a-81fd-b6738ab023fc
value:nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss
expires: 8/21/2024
Application:b08211fd-0bcf-4700-a70a-e600bc0bcf77
Application ID URI=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77
scope=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read
redirect uri:<http://localhost:8080/oauth/redirect>
Visible to users? Yes
directory name: MSFT
domain: 1hkt5t.onmicrosoft.com
directory id:5269b021-533e-4702-b9d9-72acbc852c97
tenant: 5269b021-533e-4702-b9d9-72acbc852c97

Outlook Client Application
secret/client id:2e2f796f-09ce-4800-8267-3c5a2d85ec78
value:t4U8Q~Pvrih6CSyS_CX1ztrVzdeuWevudbvycdk7
expires: 8/21/2024
Application ID:4c914e6c-f56e-4a77-a59f-733d6d37942e
Application ID URI=api://4c914e6c-f56e-4a77-a59f-733d6d37942e
redirect uri:<http://localhost:8080/oauth/redirect>
Visible to users? Yes
directory name: default directory
domain: brentgrovesoutlook.onmicrosoft.com
directory id: 07476fd3-6a57-4e3f-80ab-a1be2af5d10a
tenant: 07476fd3-6a57-4e3f-80ab-a1be2af5d10a
