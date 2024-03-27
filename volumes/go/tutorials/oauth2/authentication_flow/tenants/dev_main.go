package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"

	"golang.org/x/oauth2"
)

// const tenantId = "5269b021-533e-4702-b9d9-72acbc852c97"
// const clientID = "e0e65e2b-9f59-495a-81fd-b6738ab023fc"
// const clientSecret = "nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss"

func main() {
	ctx := context.Background()
	conf := &oauth2.Config{
		ClientID: "b08211fd-0bcf-4700-a70a-e600bc0bcf77",
		// ClientID:     "d6b668c7-e181-4415-b6fe-fb7a76d48d4a",
		ClientSecret: "nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss",
		Scopes:       []string{"api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/User.Read.All"},
		// Scopes: []string{"openid", "profile", "email"},
		// RedirectURL: "",
		// Scopes:       []string{"api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read", "SCOPE2"},

		// Scopes:       []string{"api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read", "SCOPE2"},
		Endpoint: oauth2.Endpoint{
			AuthURL:  "https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize",
			TokenURL: "https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/token",
		},
	}
	// 5269b021-533e-4702-b9d9-72acbc852c97
	// Application with identifier 'e0e65e2b-9f59-495a-81fd-b6738ab023fc' was not found in the directory 'MSFT'.
	// use PKCE to protect against CSRF attacks
	// https://www.ietf.org/archive/id/draft-ietf-oauth-security-topics-22.html#name-countermeasures-6
	verifier := oauth2.GenerateVerifier()

	// Redirect user to consent page to ask for permission
	// for the scopes specified above.
	url := conf.AuthCodeURL("state", oauth2.AccessTypeOffline, oauth2.S256ChallengeOption(verifier))
	fmt.Printf("Visit the URL for the auth dialog: %v", url)

	// Create a new redirect route
	http.HandleFunc("/oauth/redirect", func(w http.ResponseWriter, r *http.Request) {
		// First, we need to get the value of the `code` query param
		err := r.ParseForm()
		if err != nil {
			fmt.Fprintf(os.Stdout, "could not parse query: %v", err)
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		code := r.FormValue("code")

		// Use the authorization code that is pushed to the redirect
		// URL. Exchange will do the handshake to retrieve the
		// initial access token. The HTTP Client returned by
		// conf.Client will refresh the token as necessary.
		// if _, err := fmt.Scan(&code); err != nil {
		// 	log.Fatal(err)
		// }
		tok, err := conf.Exchange(ctx, code, oauth2.VerifierOption(verifier))
		if err != nil {
			log.Fatal(err)
		}

		client := conf.Client(ctx, tok)
		res, err := client.Get("https://graph.microsoft.com/v1.0/me")
		// res, err := client.Get("https://graph.microsoft.com/v1.0/oidc/userinfo")
		if err != nil {
			fmt.Fprintf(os.Stdout, "could not send HTTP request: %v", err)
			w.WriteHeader(http.StatusInternalServerError)
			return
		}
		defer res.Body.Close()

		// Parse the request body into the `OAuthAccessResponse` struct
		var t OAuthAccessResponse

		// Parse the request body into the `OAuthAccessResponse` struct
		if err := json.NewDecoder(res.Body).Decode(&t); err != nil {
			fmt.Fprintf(os.Stdout, "could not parse JSON response: %v", err)
			w.WriteHeader(http.StatusBadRequest)
			return
		}

	})

	fs := http.FileServer(http.Dir("public"))
	http.Handle("/", fs)
	http.ListenAndServe(":8080", nil)
	// href="https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?response_type=code&client_id=b08211fd-0bcf-4700-a70a-e600bc0bcf77&scope=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read">

}

type OAuthAccessResponse struct {
	AccessToken string `json:"access_token"`
}
