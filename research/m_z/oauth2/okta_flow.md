# **[Example Flow](https://www.oauth.com/oauth2-servers/server-side-apps/example-flow/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

The following step-by-step example illustrates using the authorization code flow with PKCE.

## Step-by-step

The high level overview is this:

- Create a log-in link with the app’s client ID, redirect URL, state, and PKCE code challenge parameters
- The user sees the authorization prompt and approves the request
- The user is redirected back to the app’s server with an auth code
- The app exchanges the auth code for an access token

## The app initiates the authorization request

The app initiates the flow by crafting a URL containing client ID, scope, state and PKCE code verifier. The app can put this into an '<a href="">' tag.

```html
<a href="https://authorization-server.com/oauth/authorize
?response_type=code&client_id=mRkZGFjM&state=5ca75bd30
&scope=photos
&code_challenge_method=S256
&code_challenge=hKpKupTM391pE10xfQiorMxXarRKAHRhTfH_xkGf7U4">
Connect Your Account</a>
```

Note that this is not an HTTP call your application is making, instead this is a URL that the user will click on to redirect their browser to the OAuth server.

## The user approves the request

Upon being directed to the authorization server, the user sees the authorization request shown in the illustration below. If the user approves the request, they will be redirected back to the app along with the auth code and state parameters.

![okta](https://www.oauth.com/wp-content/uploads/2016/08/okta_oauth-diagrams_20170622-01-1.png)

## The service redirects the user back to the app

The service sends a redirect header redirecting the user’s browser back to the app that made the request. The redirect will include a “code” in the URL and the original “state”.

<https://example-app.com/cb?code=Yzk5ZDczMzRlNDEwY&state=5ca75bd30>

(This will actually be sent back as an HTTP response from the authorization server to the user’s browser, not to your application. The actual HTTP response isn’t shown here because it is not significant to the code you write in your application.)

## The app exchanges the auth code for an access token

Finally the application uses the authorization code to get an access token by making an HTTPS POST request to the authorization server’s token endpoint.

```http
POST /oauth/token HTTP/1.1
Host: authorization-server.com
 
code=Yzk5ZDczMzRlNDEwY
&grant_type=code
&redirect_uri=https://example-app.com/cb
&client_id=mRkZGFjM
&client_secret=ZGVmMjMz
&code_verifier=Th7UHJdLswIYQxwSg29DbK1a_d9o41uNMTRmuH0PM8zyoMAQ
```

The authorization server validates the request and responds with an access token and optional refresh token if the access token will expire.

## response

```json
{
  "access_token": "AYjcyMzY3ZDhiNmJkNTY",
  "refresh_token": "RjY2NjM5NzA2OWJjuE7c",
  "token_type": "Bearer",
  "expires": 3600
}
```
