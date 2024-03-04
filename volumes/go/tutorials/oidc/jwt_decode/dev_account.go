package main

// https://stackoverflow.com/questions/41077953/how-to-verify-jwt-signature-with-jwk-in-go

import (
	"fmt"
	"log"

	"github.com/MicahParks/keyfunc/v3"
	"github.com/golang-jwt/jwt/v5"
)

// const token = "eyJhbGciOiJSUzI1NiIsImtpZCI6Ind5TXdLNEE2Q0w5UXcxMXVvZlZleVExMTlYeVgteHlreW1ra1h5Z1o1T00ifQ.eyJzdWIiOiIwMHUxOGVlaHUzNDlhUzJ5WDFkOCIsIm5hbWUiOiJva3RhcHJveHkgb2t0YXByb3h5IiwidmVyIjoxLCJpc3MiOiJodHRwczovL2NvbXBhbnl4Lm9rdGEuY29tIiwiYXVkIjoidlpWNkNwOHJuNWx4ck45YVo2ODgiLCJpYXQiOjE0ODEzODg0NTMsImV4cCI6MTQ4MTM5MjA1MywianRpIjoiSUQuWm9QdVdIR3IxNkR6a3RUbEdXMFI4b1lRaUhnVWg0aUotTHo3Z3BGcGItUSIsImFtciI6WyJwd2QiXSwiaWRwIjoiMDBveTc0YzBnd0hOWE1SSkJGUkkiLCJub25jZSI6Im4tMFM2X1d6QTJNaiIsInByZWZlcnJlZF91c2VybmFtZSI6Im9rdGFwcm94eUBva3RhLmNvbSIsImF1dGhfdGltZSI6MTQ4MTM4ODQ0MywiYXRfaGFzaCI6Im1YWlQtZjJJczhOQklIcV9CeE1ISFEifQ.OtVyCK0sE6Cuclg9VMD2AwLhqEyq2nv3a1bfxlzeS-bdu9KtYxcPSxJ6vxMcSSbMIIq9eEz9JFMU80zqgDPHBCjlOsC5SIPz7mm1Z3gCwq4zsFJ-2NIzYxA3p161ZRsPv_3bUyg9B_DPFyBoihgwWm6yrvrb4rmHXrDkjxpxCLPp3OeIpc_kb2t8r5HEQ5UBZPrsiScvuoVW13YwWpze59qBl_84n9xdmQ5pS7DklzkAVgqJT_NWBlb5uo6eW26HtJwHzss7xOIdQtcOtC1Gj3O82a55VJSQnsEEBeqG1ESb5Haq_hJgxYQnBssKydPCIxdZiye-0Ll9L8wWwpzwig"

// const jwksURL = "https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/discovery/v2.0/keys"

// type UserClaim struct {
// 	jwt.RegisteredClaims
// 	Email string
// 	Name  string
// }

func main() {
	// Step 1: Create the keyfunc.Keyfunc
	// This is a sample JWKS service. Visit https://jwks-service.appspot.com/ and grab a token to test this example.
	jwksURL := "https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/discovery/v2.0/keys"
	// jwksURL := "https://jwks-service.appspot.com/.well-known/jwks.json"
	// Create the keyfunc.Keyfunc.
	k, err := keyfunc.NewDefault([]string{jwksURL})
	// When using the keyfunc.NewDefault function, the JWK Set will be automatically refreshed using jwkset.NewDefaultHTTPClient.
	// This does launch a " refresh goroutine". If you want the ability to end this goroutine, use the keyfunc.NewDefaultCtx function.

	if err != nil {
		log.Fatalf("Failed to create a keyfunc.Keyfunc from the server's URL.\nError: %s", err)
	}
	// Step 2: Use the keyfunc.Keyfunc to parse and verify JWTs
	// Parse the JWT.
	signed := "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IlhSdmtvOFA3QTNVYVdTblU3Yk05blQwTWpoQSJ9.eyJhdWQiOiJkNmI2NjhjNy1lMTgxLTQ0MTUtYjZmZS1mYjdhNzZkNDhkNGEiLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vNTI2OWIwMjEtNTMzZS00NzAyLWI5ZDktNzJhY2JjODUyYzk3L3YyLjAiLCJpYXQiOjE3MDk1OTM2MDYsIm5iZiI6MTcwOTU5MzYwNiwiZXhwIjoxNzA5NTk3NTA2LCJhaW8iOiJBV1FBbS84V0FBQUFhRlZOaDN3VVhZbktQalRxTEYxRy9RYjJhT01ycHN6U2pNSTM0SmFwRzc5K3FVclpSRXJDUC82WDZGTEo5WkR3Zk5OZEhUcS9OR2FBMjM3RE1ycHlMTXdnY2NhbUtuNlJlRTVhVkFsNnhVTlpNT1FVbnhIQW9oanVYR3RqTHQ0MCIsImVtYWlsIjoiYnJlbnRncm92ZXNAMWhrdDV0Lm9ubWljcm9zb2Z0LmNvbSIsIm5hbWUiOiJCcmVudCBHcm92ZXMiLCJub25jZSI6IjY3ODkxMCIsIm9pZCI6IjlhY2NmYTg5LTk4NzItNGI2Ni05ZDcwLWI3NWYyMzQyZjNiYSIsInByZWZlcnJlZF91c2VybmFtZSI6ImJyZW50Z3JvdmVzQDFoa3Q1dC5vbm1pY3Jvc29mdC5jb20iLCJyaCI6IjAuQVh3QUliQnBVajVUQWtlNTJYS3N2SVVzbDhkb3R0YUI0UlZFdHY3N2VuYlVqVXJNQUxJLiIsInN1YiI6IndJaGtqazNPbVQ1cVc2WE1ETVktRFMwTGVZUkt3UU56UE5NcjJ2NGtNQUkiLCJ0aWQiOiI1MjY5YjAyMS01MzNlLTQ3MDItYjlkOS03MmFjYmM4NTJjOTciLCJ1dGkiOiJLbFRPQW4wMUgwR285ZjNQcVJ5N0FRIiwidmVyIjoiMi4wIn0.epbKRPX0zlvhwqFuLd9dxbNKzEXCB0io2-puoMHQeE1a12UziAgibg4rlY3VTmNhWs5kqt6-fVz7H0DHRAG7w80oRzIgS5StLZyyVz4nYbN49ZPiqM6_ofUXAPsaY99SWI-LGP4E4p77cwosSuw9717EMD_ReDAP5im06qqxMu7pIwd_PAIBz3K1LwUdAy_I-XZasbRBTNeuuiD_w0uyJp2As8vHk0tsDBEZMAIabFt_6tt1dNokJ7Ibezwzp5XLWgWlZNY_nUbFRKaNsL3AomvVANbLJsjZC-8i0vO0oJnKPyzooepbGFz6IMoaq4BwNDoqnKkm8q2_kaUcYo-t3w"
	// signed := "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IlhSdmtvOFA3QTNVYVdTblU3Yk05blQwTWpoQSJ9.eyJhdWQiOiJkNmI2NjhjNy1lMTgxLTQ0MTUtYjZmZS1mYjdhNzZkNDhkNGEiLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vNTI2OWIwMjEtNTMzZS00NzAyLWI5ZDktNzJhY2JjODUyYzk3L3YyLjAiLCJpYXQiOjE3MDk1Nzk5MDYsIm5iZiI6MTcwOTU3OTkwNiwiZXhwIjoxNzA5NTgzODA2LCJhaW8iOiJBV1FBbS84V0FBQUE0aHRhdzhmaFc5aUptVllvODU1b2ZhZXJGUHowam9RZWM1YzNSRU5mdlRJckxVWEFTVzlkbVlUT1BlMEdDWnRRSlppd0pVaUhRcm5YOWNpT3FWdmZMcWg0SEw4c3BBUW01WnRIdSs3cUZuYXg3cXV1N0dtYUg4dGI1b09DVGMvdiIsImVtYWlsIjoiYnJlbnRncm92ZXNAMWhrdDV0Lm9ubWljcm9zb2Z0LmNvbSIsIm5hbWUiOiJCcmVudCBHcm92ZXMiLCJub25jZSI6IjY3ODkxMCIsIm9pZCI6IjlhY2NmYTg5LTk4NzItNGI2Ni05ZDcwLWI3NWYyMzQyZjNiYSIsInByZWZlcnJlZF91c2VybmFtZSI6ImJyZW50Z3JvdmVzQDFoa3Q1dC5vbm1pY3Jvc29mdC5jb20iLCJyaCI6IjAuQVh3QUliQnBVajVUQWtlNTJYS3N2SVVzbDhkb3R0YUI0UlZFdHY3N2VuYlVqVXJNQUxJLiIsInN1YiI6IndJaGtqazNPbVQ1cVc2WE1ETVktRFMwTGVZUkt3UU56UE5NcjJ2NGtNQUkiLCJ0aWQiOiI1MjY5YjAyMS01MzNlLTQ3MDItYjlkOS03MmFjYmM4NTJjOTciLCJ1dGkiOiJxQ0pJYnpwdXdrZXh2UjhWSDdtRUFRIiwidmVyIjoiMi4wIn0.Lx4qAVioYjE-l9X6f0i_nB4Omt0UyZY6BdpG2akk6QNQyOND4KJzTmqQnfkJib2EOL8u_8NgmLIdkgYu8D2Bmzvt-FOBFPPUBySbkVCbYl66StArAjdxGAwI_9t9xMtNX9z3FDwxV5-ts0fEnvolItss2U5q2cN9HF8qySFFfFJFpp4i4dCwoeq4mQCN79lUrXJz95z8F2HKzGtU7ic0_H0aL-L5_9p71nCUunG1fZaqjYS2IgcWRrEpWfQpgFtYms1Ekz14oyK_7PAJLhZpxP_xVQXP9cH9azyQWo9GkfKP0Q5hOAUwXx2xdqFgtHgohzTRQyYzPVPAA9Q7g4qGYw"

	// type UserClaim struct {
	// 	jwt.RegisteredClaims
	// 	Email              string
	// 	Name               string
	// 	oid                string
	// 	preferred_username string
	// 	nonce              string
	// }
	type MyCustomClaims struct {
		Oid                string `json:"oid"`
		Email              string `json:"email"`
		Name               string `json:"name"`
		Nonce              string `json:"nonce"`
		Preferred_username string `json:"preferred_username"`

		jwt.RegisteredClaims
	}

	// "preferred_username": "brentgroves@1hkt5t.onmicrosoft.com"
	// // Parse the token
	token, err := jwt.ParseWithClaims(signed, &MyCustomClaims{}, k.Keyfunc)
	if err != nil {
		log.Fatalf("Failed to parse the JWT.\nError: %s", err)
	}

	// token2, err2 := jwt.ParseWithClaims(signed, &MyCustomClaims{}, func(token *jwt.Token) (interface{}, error) {
	// 	// since we only use the one private key to sign the tokens,
	// 	// we also only use its public counter part to verify
	// 	return []byte("AllYourBase"), nil
	// })
	// token signature is invalid
	// fatal(err)

	// claims := token.Claims.(*UserClaim)
	// fmt.Println(claims.Name)
	// fmt.Println(claims.oid)
	claims, _ := token.Claims.(*MyCustomClaims)
	fmt.Println(token.Header["typ"])
	fmt.Println(claims.Oid, claims.Email)
	fmt.Println(claims.Name, claims.Preferred_username)
	fmt.Println(claims.Nonce, claims.RegisteredClaims.Issuer)

	// parsed, err := jwt.Parse(signed, k.Keyfunc)
	// if err != nil {
	// 	log.Fatalf("Failed to parse the JWT.\nError: %s", err)
	// }
	// fmt.Printf("%s\n", parsed.Raw)
	// fmt.Printf("%s\n",parsed.Raw.Claims.data.oid)
	// parsed.Claims.data.preferred_username
	// parsed.Claims.GetIssuer()
	// parsed.Claims.data.email
	// parsed.Claims.data.nonce

}

func fatal(err2 error) {
	panic("unimplemented")
}
