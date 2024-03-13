# **[OAuth PKCE with Go](https://chrisguitarguy.com/2022/12/07/oauth-pkce-with-go/)**

This is going to describe how to do Proof Key for Code Exchange (PKCE) with Go’s golang.org/x/oauth2.

## A Brief Overview of PKCE

PKCE is meant to be an extra layer of client authentication during the authorization code grant flow with public oauth clients (native apps, single page JS apps — basically anything that cant’ kep it’s oauth client secret a secret). It’s very similar to a **[nonce](https://en.wikipedia.org/wiki/Cryptographic_nonce)**.

For each authorization request, the client generates a cryptographically random set of bytes called a code verifier. The code verifier should have at least 256 bits (32 bytes) of entropy and be 43 – 128 characters with letters, numbers, dashes, periods, underscores, and tildes.

The client SHOULD create a **["code_verifier"](https://www.rfc-editor.org/rfc/rfc7636#section-7.1)** with a minimum of 256 bits of entropy.

**[code_verifier](https://www.rfc-editor.org/rfc/rfc7636#section-4.1)** = high-entropy cryptographic random STRING using the unreserved characters [A-Z] / [a-z] / [0-9] / “-” / “.” / “_” / “~” from Section 2.3 of [RFC3986], with a minimum length of 43 characters and a maximum length of 128 characters.

For the initial authorization request, this code verifier is run through a transformation and then sent to the oauth servers authorization endpoint as code_challenge along with code_challenge_method. There are two code challenge methods: plain and S256. Plain is about what it sounds like: no transformation. Don’t do this. With S256 the code verifier is run through a SHA256 hash then the result is base64url encoded.

On the server side, the authorization server stores the code challenge + method as part of the auth code. Then redirects back to the server with code and state in the query string as usual.

When the client exchange the authorization code for a grant, it now sends the code verifier along with the usual client_id, grant_type, etc. The server then runs the code_verifier value through the same transformation and verifies that the code verifier was used to generate the code challenge then issues its access token.

The RFC is a little confusing as it recommends ASCII encoding the code verifier, but anything that can be sent with the auth code exchange is, generally, fine. The examples here are going to hex encode the random bytes.

Go’s OAuth2 library provides ways to do PKCE, but it’s not entirely obvious hence this article.

## Generating a Code Verifier (and State)

For this we’ll use crypto/rand and encoding/hex

```go
package login
 
import (
    "crypto/rand"
    "encoding/hex"
    "fmt"
    "io"
)
 
func randomBytesInHex(count int) (string, error) {
    buf := make([]byte, count)
    _, err := io.ReadFull(rand.Reader, buf)
    if err != nil {
        return "", fmt.Errorf("Could not generate %d random bytes: %v", count, err)
    }
 
    return hex.EncodeToString(buf), nil
}
```

## Generating the Authorization URL

The OAuth2 library provides ways to do this, we just need a little bit of modification for the code challenge. Remender the code challenge needs to be run through a SHA256 hash then base64url encoded. oauth2.SetAuthURLParam is used to append the appropriate query string values to the authorization url.

```bash
go get -u golang.org/x/oauth2
go help get
```

```go
import (
    "crypto/sha256"
    "encoding/base64"
    "fmt"
    "io"
 
    "golang.org/x/oauth2"
)
 
type AuthURL struct {
    URL          string
    State        string
    CodeVerifier string
}
 
func (u *AuthURL) String() string {
    return u.URL
}
 
func AuthorizationURL(config *oauth2.Config) (*AuthURL, error) {
    codeVerifier, verifierErr := randomBytesInHex(32) // 64 character string here
    if verifierErr != nil {
        return nil, fmt.Errorf("Could not create a code verifier: %v", verifierErr)
    }
    sha2 := sha256.New()
    io.WriteString(sha2, codeVerifier)
    codeChallenge := base64.RawURLEncoding.EncodeToString(sha2.Sum(nil))
 
    state, stateErr := randomBytesInHex(24)
    if stateErr != nil {
        return nil, fmt.Errorf("Could not generate random state: %v", stateErr)
    }
 
    authUrl := config.AuthCodeURL(
        state,
        oauth2.SetAuthURLParam("code_challenge_method", "S256"),
        oauth2.SetAuthURLParam("code_challenge", codeChallenge),
    )
 
    return &AuthURL{
        URL:          authUrl,
        State:        state,
        CodeVerifier: codeVerifier,
    }, nil
}
```

The state and code verifier are passed back alongside the URL here, these would be stored in sessions or HTTP only cookies, in memory, etc. Something to make sure that they stick around to verify the state and are able to send the code verifier along with the auth code request.

## Getting an Access Token

Going to just provide an HTTP Handler example here. This will take the oauth config, state, and code verifier as members of a struct. Again, the oauth2 library provides what we need to do a code -> token exchange, we just need to use oauth2.SetAuthURLParam again this time to send the code_verifier.

```go
import (
    "crypto/subtle"
    "io"
    "net/http"
 
    "golang.org/x/oauth2"
)
 
const (
    QUERY_STATE = "state"
    QUERY_CODE  = "code"
)
 
type OAuthRedirectHandler struct {
    State        string
    CodeVerifier string
    OAuthConfig  *oauth2.Config
}
 
func textResponse(rw http.ResponseWriter, status int, body string) {
    rw.Header().Add("Content-Type", "text/plain")
    rw.WriteHeader(status)
    io.WriteString(rw, body)
}
 
func (h *OAuthRedirectHandler) ServeHTTP(rw http.ResponseWriter, request *http.Request) {
    query := request.URL.Query()
 
    state := query.Get(QUERY_STATE)
    // prevent timing attacks on state
    if subtle.ConstantTimeCompare([]byte(h.State), []byte(state)) == 0 {
        textResponse(rw, http.StatusBadRequest, "Invalid State")
        return
    }
 
    code := query.Get(QUERY_CODE)
    if code == "" {
        textResponse(rw, http.StatusBadRequest, "Missing Code")
        return
    }
 
    token, err := h.OAuthConfig.Exchange(
        request.Context(),
        code,
        oauth2.SetAuthURLParam("code_verifier", h.CodeVerifier),
    )
    if err != nil {
        textResponse(rw, http.StatusInternalServerError, err.Error())
        return
    }
 
    // probably do something more legit with this token...
    textResponse(rw, http.StatusOK, token.AccessToken)
}
```
