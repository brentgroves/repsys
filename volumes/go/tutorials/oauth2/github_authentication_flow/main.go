package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
)

// github app
const clientID = "4e83a11fd0182d7cbb02"
const clientSecret = "58870f5f28410c3fce3ea5c0bd5fe6e1cbb41cfc"

// Azure IAM app
// const clientID = "e0e65e2b-9f59-495a-81fd-b6738ab023fc"
// const clientSecret = "nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss"

// Dev Account Client Application
// Client Id:e0e65e2b-9f59-495a-81fd-b6738ab023fc
// value:nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss
// Application ID URI=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77
// redirect uri:<http://localhost:8080/oauth/redirect>

// Outlook Client Application
// Client Id:2e2f796f-09ce-4800-8267-3c5a2d85ec78
// value:t4U8Q~Pvrih6CSyS_CX1ztrVzdeuWevudbvycdk7
// Application ID URI=api://4c914e6c-f56e-4a77-a59f-733d6d37942e
// redirect uri:<http://localhost:8080/oauth/redirect>
// <http://localhost:8080/oauth/redirect>

func main() {
	fs := http.FileServer(http.Dir("public"))
	http.Handle("/", fs)

	// We will be using `httpClient` to make external HTTP requests later in our code
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
		// https://pkg.go.dev/net/http
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

		// Parse the request body into the `OAuthAccessResponse` struct
		var t OAuthAccessResponse
		if err := json.NewDecoder(res.Body).Decode(&t); err != nil {
			fmt.Fprintf(os.Stdout, "could not parse JSON response: %v", err)
			w.WriteHeader(http.StatusBadRequest)
			return
		}

		// Finally, send a response to redirect the user to the "welcome" page
		// with the access token
		// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Location
		w.Header().Set("Location", "/welcome.html?access_token="+t.AccessToken)
		w.WriteHeader(http.StatusFound)
	})

	http.ListenAndServe(":8080", nil)
}

type OAuthAccessResponse struct {
	AccessToken string `json:"access_token"`
}
