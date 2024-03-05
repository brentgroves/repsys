# OAuth2

Github OAuth2 example

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
cd ~/src/repsys/volumes/go/tutorials/oauth2/go_oauth2_example
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

## Disect Azure Identity Management URL

<https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?response_type=code&client_id=b08211fd-0bcf-4700-a70a-e600bc0bcf77&scope=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read>

- **tenant:** 5269b021-533e-4702-b9d9-72acbc852c97
- **response_type:** code

## **[The Authorization Response](https://www.oauth.com/oauth2-servers/authorization/the-authorization-response/)**

Once the user has finished logging in and approving the request, the authorization server is ready to redirect the user back to the application.
Authorization Code Response

If the request is valid and the user grants the authorization request, the authorization server generates an authorization code and redirects the user back to the application, adding the authorization code and the application’s “state” value to the redirect URL.0

## Generating the Authorization Code

The authorization code must expire shortly after it is issued. The OAuth 2.0 spec recommends a maximum lifetime of 10 minutes, but in practice, most services set the expiration much shorter, around 30-60 seconds. The authorization code itself can be of any length, but the length of the codes should be documented.

The link URL has three key parts:

- https//github.com/login/oauth/authorize is the OAuth gateway for Github’s **OAuth flow**. All OAuth providers have a gateway URL that you have to send the user to in order to proceed.

- client_id=myclientid123 - this specifies the client ID of the application. This ID will tell Github about the identity of the consumer who is trying to use their OAuth service. Maybe the client_id is the id of the app registered with github.

  OAuth service providers normally have a portal in which you can register your consumer. On registration, you will receive a client ID (which we are using here as myclientid123), and a client secret (which we will use later on). For Github, the portal to register new applications can be found on <https://github.com/settings/applications/new>.

- redirect_uri=<http://localhost:8080/oauth/redirect> - specifies the URL to redirect to with the request token, once the user has been authenticated by the service provider. Normally, you will have to set this value on the registration portal as well, to prevent anyone from setting malicious callback URLs.

Azure example:

href="<https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?response_type=code&client_id=b08211fd-0bcf-4700-a70a-e600bc0bcf77&scope=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read">>

## register app with Github

- Register your new application on Github : <https://github.com/settings/applications/new>. In the "callback URL" field, enter "<http://localhost:8080/oauth/redirect>". Once you register, you will get a client ID and client secret.
- Replace the values of the clientID and clientSecret variables in the main.go file and also the index.html file
- Start the server by executing go run main.go
- Navigate to <http://localhost:8080> on your browser.

Register a new OAuth application
go_oauth2_example

Client ID
4e83a11fd0182d7cbb02
Client secrets
58870f5f28410c3fce3ea5c0bd5fe6e1cbb41cfc

## **[register app with Azure](./azure_oauth_registriation.md)**

## Setup go progam

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/oauth2/go_oauth2_example
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

## Adding a Redirect Route

Once the user authenticates with Github, they get redirected to the redirect URL that was specified earlier.

The service provider also adds a request token along with the url. In this case, Github adds this as the code parameter, so the redirect URL will actually be something like <http://localhost:8080/oauth/redirect?code=mycode123>, where mycode123 is the request token.

We need this request token and our client secret to get the access token, which is the token that is actually used to get information about the user. We get this access token by making a POST HTTP call to <https://github.com/login/oauth/access_token> along with the mentioned information.

You can view the **[documentation page](https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps#2-users-are-redirected-back-to-your-site-by-github)** for the details of the information Github provides to the redirect URL, and the information we need for provide with the POST /login/oauth/access_token HTTP call.

Let’s add the /oauth/redirect route to the main.go file:

```go
const clientID = "<your client id>"
const clientSecret = "<your client secret>"

func main() {
 fs := httNow the redirect URL is functional, and will redirect the user to the welcome page, along with the access token.

## Redirecting to the Welcome Page
The welcome page is the page we show the user after they have logged in. Now that we have the users access token, we can obtain their account information on their behalf as authorized Github users.
ll be using `httpClient` to make external HTTP requests later in our code
 httpClient := http.Client{}

 // Create a new redirect route route
 http.HandleFunc("/oauth/redirect", func(w http.ResponseWriter, r *http.Request) {
  // First, we need to get the value of the `code` query param
  err := r.ParseForm()
  if err != nil {
   fmt.Fprintf(os.Stdout, "could not parse query: %v", err)
   w.WriteHeader(http.StatusBadRequest)
   return
  }
  code := r.FormValue("code")

  // Next, lets for the HTTP request to call the github oauth endpoint
  // to get our access token
  reqURL := fmt.Sprintf("https://github.com/login/oauth/access_token?client_id=%s&client_secret=%s&code=%s", clientID, clientSecret, code)
  req, err := http.NewRequest(http.MethodPost, reqURL, nil)
  if err != nil {
   fmt.Fprintf(os.Stdout, "could not create HTTP request: %v", err)
   w.WriteHeader(http.StatusBadRequest)
   return
  }
  // We set this header since we want the response
  // as JSON
  req.Header.Set("accept", "application/json")

  // Send out the HTTP request
  res, err := httpClient.Do(req)
  if err != nil {
   fmt.Fprintf(os.Stdout, "could not send HTTP request: %v", err)
   w.WriteHeader(http.StatusInternalServerError)
   return
  }
  defer res.Body.Close()
Now the redirect URL is functional, and will redirect the user to the welcome page, along with the access token.

## Redirecting to the Welcome Page
The welcome page is the page we show the user after they have logged in. Now that we have the users access token, we can obtain their account information on their behalf as authorized Github users.
eHeader(http.StatusBadRequest)
   return
  }

  // Finally, send a response to redirect the user to the "welcome" page
  // with the access token
  w.Header().Set("Location", "/welcome.html?access_token="+t.AccessToken)
  w.WriteHeader(http.StatusFound)
 })

 http.ListenAndServe(":8080", nil)
}

type OAuthAccessResponse struct {
 AccessToken string `json:"access_token"`
}

```

Now the redirect URL is functional, and will redirect the user to the welcome page, along with the access token.

## Redirecting to the Welcome Page

The welcome page is the page we show the user after they have logged in. Now that we have the users access token, we can obtain their account information on their behalf as authorized Github users.

For a list of all APIs available, you can see the **[Github API Documentation](https://docs.github.com/en/rest/reference/users)**

We will be using the /user API to get basic info about the user and say hi to them on our welcome page. Create a new file public/welcome.html:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Hello</title>
  </head>

  <body></body>
  <script>
    // We can get the token from the "access_token" query
    // param, available in the browsers "location" global
    const query = window.location.search.substring(1);
    const token = query.split("access_token=")[1];

    // Call the user info API using the fetch browser library
    fetch("https://api.github.com/user", {
      headers: {
        // This header informs the Github API about the API version
        Accept: "application/vnd.github.v3+json",
        // Include the token in the Authorization header
        Authorization: "token " + token,
      },
    })
      // Parse the response as JSON
      .then((res) => res.json())
      .then((res) => {
        // Once we get the response (which has many fields)
        // Documented here: https://developer.github.com/v3/users/#get-the-authenticated-user
        // Write "Welcome <user name>" to the documents body
        const nameNode = document.createTextNode(`Welcome, ${res.name}`);
        document.body.appendChild(nameNode);
      });
  </script>
</html>

```

With the addition of the welcome page, our OAuth implementation is now complete!

Once the app starts, we can visit <http://localhost:8080/> , authorize with Github, and end up on the welcome page, which displays the greeting. My name on my github profile is “Soham Kamani”, so the welcome page will display Welcome, Soham Kamani once I login.

## Next

Attempt to get this to work for Azure
<https://github.com/coreos/go-oidc>
<https://pkg.go.dev/golang.org/x/oauth2>
<https://github.com/twitchdev/authentication-go-sample/blob/main/oidc-authorization-code/main.go>
<https://github.com/twitchdev/authentication-go-sample/blob/main/oauth-authorization-code/main.go>

<https://stackoverflow.com/questions/63852734/azure-oauth-getting-html-body-instead-of-code-from-angular-get-request>

<https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize>
AADSTS900144: The request body must contain the following parameter: 'client_id'.

There are usually two causes for this error.
The parameter: ‘client_id’ is missing from the request, therefore ensure the authentication request includes the required parameter.

If you are hitting the token endpoint (i.e. <https://login.microsoftonline.com/common/oauth2/token> ), the Content Type is not set correctly. Ensure the content type is 'application/x-www-form-urlencoded' as a header in the request body.

<https://github.com/login/oauth/authorize?client_id=myclientid123&redirect_uri=http://localhost:8080/oauth/redirect>

![alt](https://www.sohamkamani.com/golang/oauth/oauth-flow.drawio.svg)

<https://github.com/login/oauth/authorize?client_id=myclientid123&redirect_uri=http://localhost:8080/oauth/redirect>

<https://github.com/login/oauth/authorize?client_id=myclientid123&redirect_uri=http://localhost:8080/oauth/redirect>
