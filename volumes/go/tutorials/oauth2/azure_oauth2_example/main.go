package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
)

// github app
// const clientID = "4e83a11fd0182d7cbb02"
// const clientSecret = "58870f5f28410c3fce3ea5c0bd5fe6e1cbb41cfc"
// Azure IAM app
const tenantId = "5269b021-533e-4702-b9d9-72acbc852c97"
const clientID = "e0e65e2b-9f59-495a-81fd-b6738ab023fc"
const clientSecret = "nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss"

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

		// Next, call the microsoft oauth endpoint
		// to get our access token
		// https: //login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/token
		// https: //stackoverflow.com/questions/63852734/azure-oauth-getting-html-body-instead-of-code-from-angular-get-request
		// https: //stackoverflow.com/questions/67247541/how-to-acquire-oauth2-0-token-from-azure-ad-in-go
		// https: //github.com/mcordell/go-ms-graph/blob/master/auth/auth.go

		// Azure way
		// https://stackoverflow.com/questions/67247541/how-to-acquire-oauth2-0-token-from-azure-ad-in-go

		reqURL := fmt.Sprintf("https://login.microsoftonline.com/%s/oauth2/v2.0/token", tenantId)
		fmt.Sprintf("%s?client_id=%s&scope=", reqURL, clientID)
		// reqURL = `https://login.microsoftonline.com/${config.auth.tenantId}/oauth2/v2.0/token`;
		// https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize?redirect_uri=https%3A%2F%2Fportal.azure.com%2Fsignin%2Findex%2F&response_type=code%20id_token&scope=https%3A%2F%2Fmanagement.core.windows.net%2F%2Fuser_impersonation%20openid%20email%20profile&state=OpenIdConnect.AuthenticationProperties%3Df1H9Bx6T6cw2VkIwVFsGQvaUFaxKzi7PJxpHc0MoJ5q7Pql8XiNJUarbW2Cs89npSMx1VtXa86pc5zRbsFjIcnGfKvDZMCjQxImI0Zj3_gv-hRoCBLw89IrVoF-VW0fLqyHfQipBW5gklsCdcAHQC_fYP-jmbd-geEZ0ulIdYDCB-9l9vOYilbEnS0zWtKR83sPNJTR7zCywsZH6VhsxQv_nKzCp6oQpCGXqXTx3y_wUY-N-RtNN4gkN6c4ugPFPom7BqCzYjoob_U-2QayiiHXqDa3nr0eKS923z0j6FxF5RX5zNmnGZwD4d_HhhMlgyPXMNGWnXKqtJxG1ktSDM9uhVxQ-D-rZBTy1AjRmd2sb2VR6_kw9x3Hp3w1BPlR1bofr7d_KbHK5YXywX-wwIXm6aMfPyBZy4Dp9ic0kH0SoCIRBwn3-FA1LalQb1iaNRXX-vlvWAhggKwpmrPxkgGwzbviLamkFzKZ1Rb_ai5YZbjsJK_d60gqW1zK0zbed&response_mode=form_post&nonce=638446532632968419.Y2M4ZmQzMDMtYTYzOC00ZjMzLWE4MzgtOTgwZTY4YjJlZjdhY2Q0YmZkNmUtMWY5OC00N2JlLTkzZDEtNDUzMTZkYjU2NWY3&client_id=c44b4083-3bb0-49c1-b47d-974e53cbdf3c&site_id=501430&client-request-id=231ad948-1673-431c-a2d8-2b6e82507744&x-client-SKU=ID_NET472&x-client-ver=6.34.0.0
		// const tokenRequestBody = {
		// 		grant_type    : 'authorization_code',
		// 		client_id     : xxxxxxx,
		// 		code          : _accessCode,
		// 		redirect_uri  : xxxxxxx,
		// 		scope         : xxxxxxx,
		// 		client_secret : xxxxxxx     //Only required for web apps
		// };

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
		w.Header().Set("Location", "/welcome.html?access_token="+t.AccessToken)
		w.WriteHeader(http.StatusFound)
	})

	http.ListenAndServe(":8080", nil)
}

// https://stackoverflow.com/questions/63852734/azure-oauth-getting-html-body-instead-of-code-from-angular-get-request
// const tokenRequestUrl = `https://login.microsoftonline.com/${config.auth.tenantId}/oauth2/v2.0/token`;

// const tokenRequestBody = {
// 		grant_type    : 'authorization_code',
// 		client_id     : xxxxxxx,
// 		code          : _accessCode,
// 		redirect_uri  : xxxxxxx,
// 		scope         : xxxxxxx,
// 		client_secret : xxxxxxx     //Only required for web apps
// };

// request.post(
// 		{ url: tokenRequestUrl, form: tokenRequestBody },
// 		(err, httpResponse, body) => {
// 				if (!err) {
// 						console.log('Token Received!\n', body);
// 				} else {
// 						// Probably throw an error?
// 				}
// 		}
// );

// This could be done in html instead of golang
// https://stackoverflow.com/questions/63852734/azure-oauth-getting-html-body-instead-of-code-from-angular-get-request

// func GetTokens(c AuthorizationConfig, authCode AuthorizationCode, scope string) (t Tokens, err error) {
//     formVals := url.Values{}
//     formVals.Set("code", authCode.Value)
//     formVals.Set("grant_type", "authorization_code")
//     formVals.Set("redirect_uri", c.RedirectURL())
//     formVals.Set("scope", scope)
//     if c.ClientSecret != "" {
//         formVals.Set("client_secret", c.ClientSecret)
//     }
//     formVals.Set("client_id", c.ClientID)
//     response, err := http.PostForm(TokenURL, formVals)

//     if err != nil {
//         return t, errors.Wrap(err, "error while trying to get tokens")
//     }
//     body, err := ioutil.ReadAll(response.Body)

//     if err != nil {
//         return t, errors.Wrap(err, "error while trying to read token json body")
//     }

//     err = json.Unmarshal(body, &t)
//     if err != nil {
//         return t, errors.Wrap(err, "error while trying to parse token json body")
//     }

//     return
// }

type OAuthAccessResponse struct {
	AccessToken string `json:"access_token"`
}
