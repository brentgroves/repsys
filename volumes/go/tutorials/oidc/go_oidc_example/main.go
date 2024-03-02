package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/golang-jwt/jwt/v5"
)

// Use to encode jwt
// id: b51ee493-22c4-44db-99d5-237a143d8a84
// value: DWK8Q~VbQQLmmYPPoFyic_2LI2er5evbB7otwdmf

type UserClaim struct {
	jwt.RegisteredClaims
	Email string
	Name  string
}

// response1 = requests.get("https://login.microsoftonline.com/fb134080-e4d2-45f4-9562-f3a0c218f3b0/discovery/keys")

// https://stackoverflow.com/questions/76730014/decoding-azure-access-token-obtained-by-client-credential-flow
const key2 = "MIIC/jCCAeagAwIBAgIJAKysonliFZLIMA0GCSqGSIb3DQEBCwUAMC0xKzApBgNVBAMTImFjY291bnRzLmFjY2Vzc2NvbnRyb2wud2luZG93cy5uZXQwHhcNMjQwMjA4MTcwMjUzWhcNMjkwMjA4MTcwMjUzWjAtMSswKQYDVQQDEyJhY2NvdW50cy5hY2Nlc3Njb250cm9sLndpbmRvd3MubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvRIL3aZt+xVqOZgMOr71ltWe9YY2Wf/B28C4Jl2nBSTEcFnf/eqOHZ8yzUBbLc4Nti2/ETcCsTUNuzS368BWkSgxc45JBH1wFSoWNFUSXaPt8mRwJYTF0H32iNhw/tBb9mvdQVgVs4Ci0dVJRYiz+ilk3PeO8wzlwRuwWIsaKFYlMyOKG9DVFbg93DmP5Tjq3C3oJlATyhAiJJc1T2trEP8960an33dDEaWwVAHh3c/34meAO4R6kLzIq0JnSsZMYB9O/6bMyIlzxmdZ8F442SynCUHxhnIh3yZew+xDdeHr6Ofl7KeVUcvSiZP9X44CaVJvknXQbBYNl+H7YF5RgQIDAQABoyEwHzAdBgNVHQ4EFgQU8Sqmrf0UFpZbGtl5y1CjUdQq5ycwDQYJKoZIhvcNAQELBQADggEBAA57FiIOUs5yyLD6a6rWCbQ4Z2XJTfQb+TM/tZ6V6QqNhSS+Q98KFOIWe9Sit0iAyDsCCKuA8f08PYnUiHmHq8dG/7YRTShE/3zCZXHYKJgMaBhYfS788zQuq/hXDdVVc5X0pZwM4ibc6+2XpcpeDHxpMOLwo2AwujDdHVLzedAkIaTCzwPIizP4LB6l6IxR+xRXsH/1f034Gk3ReAEGgHW12NkajtXmC3DKl6vGIHvx1PgAMWQbxq3F2OopNx6aZEIIZWcMpQZ6/62f3pxRJHzZiJZN+khV8hpNjJvCNf6/hNbxkLcjLAycjW8AttcCRSTM4F+02S3TyHmoE4pYywA="

const jwtToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IlhSdmtvOFA3QTNVYVdTblU3Yk05blQwTWpoQSJ9.eyJhdWQiOiJkNmI2NjhjNy1lMTgxLTQ0MTUtYjZmZS1mYjdhNzZkNDhkNGEiLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vNTI2OWIwMjEtNTMzZS00NzAyLWI5ZDktNzJhY2JjODUyYzk3L3YyLjAiLCJpYXQiOjE3MDkzMjY1MjIsIm5iZiI6MTcwOTMyNjUyMiwiZXhwIjoxNzA5MzMwNDIyLCJhaW8iOiJBV1FBbS84V0FBQUFvYVVOU2lKaDNETklDN2xVRnVLUnhGTUg0NDRzNkRxNlVMTUY5bnVNclVMSFJHOTNkRytpRHN1MWNld2hvNk9EMkZhckdpQXk3WTdickNTOGl4blB2R3plNWM1dEJXYTZ6MnZYRnVVNk82elpleTA5MVFWakIzbVdTTXBDZzFsaCIsIm5hbWUiOiJCcmVudCBHcm92ZXMiLCJub25jZSI6IjY3ODkxMCIsIm9pZCI6IjlhY2NmYTg5LTk4NzItNGI2Ni05ZDcwLWI3NWYyMzQyZjNiYSIsInByZWZlcnJlZF91c2VybmFtZSI6ImJyZW50Z3JvdmVzQDFoa3Q1dC5vbm1pY3Jvc29mdC5jb20iLCJyaCI6IjAuQVh3QUliQnBVajVUQWtlNTJYS3N2SVVzbDhkb3R0YUI0UlZFdHY3N2VuYlVqVXJNQUxJLiIsInN1YiI6IndJaGtqazNPbVQ1cVc2WE1ETVktRFMwTGVZUkt3UU56UE5NcjJ2NGtNQUkiLCJ0aWQiOiI1MjY5YjAyMS01MzNlLTQ3MDItYjlkOS03MmFjYmM4NTJjOTciLCJ1dGkiOiJpTzI1SDZrYnVrNnhJQ3RKM2VUNkFBIiwidmVyIjoiMi4wIn0.rtnjkC094uliFOjygWwVg9RYTfr0ie56OojPvaFg4LL3VZYTB88-EMPAdcdaNVrXuRRy_r7Cda4bYaOkAunnjFs3PiW2s6rEvTQC079ja3QeGD9SZ9lHgfq234yP10GwuTuc31G28s89HMPWYX2966AeZtwHeELZsF7GTGtXs_P0_QeMnaIUnLYZdSKbyUd8l5iQPGtWSfvwHhVkDmNcBbsCStIlxHQ5SlhOE7HLMM-jOYBOBdD28mv1bY8Kwu-2l-ldhN7JM0LjFTK5ZK7FOa42GfDEOQvSQHvcmCfbB6PjqIzp_ktqNUEKd1pPOYdADsXo0QboynEE4ywvuwPgWA"

func main() {

	var userClaim UserClaim
	token, err := jwt.ParseWithClaims(jwtToken, &userClaim, func(token *jwt.Token) (interface{}, error) {
		return []byte(key2), nil
	})

	if err != nil {
		log.Fatal(err)
	}

	// Checking token validity
	if !token.Valid {
		log.Fatal("invalid token")
	}
	fmt.Printf("Parsed User Claim:%s %s\n", userClaim.Email, userClaim.Name)

	fs := http.FileServer(http.Dir("public"))
	http.Handle("/", fs)

	// Create a new redirect route
	http.HandleFunc("/oauth/redirect", func(w http.ResponseWriter, r *http.Request) {
		// First, we need to get the value of the `code` query param
		err := r.ParseForm()

		if err != nil {
			fmt.Fprintf(os.Stdout, "could not parse query: %v", err)
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		// code := r.FormValue("code")
		jwtToken := r.FormValue("id_token")
		state := r.FormValue("state")
		fmt.Fprintf(os.Stdout, "id_token: %s", jwtToken)
		fmt.Fprintf(os.Stdout, "state: %s", state)
		var userClaim UserClaim

		// 👇
		token, err := jwt.ParseWithClaims(jwtToken, &userClaim, func(token *jwt.Token) (interface{}, error) {
			return []byte(key2), nil
		})

		if err != nil {
			log.Fatal(err)
		}

		// Checking token validity
		if !token.Valid {
			log.Fatal("invalid token")
		}
		fmt.Printf("Parsed User Claim:%s %s\n", userClaim.Email, userClaim.Name)

		// fmt.Printf("Parsed User Claim: %d %s %s\n", userClaim.ID, userClaim.Email, userClaim.Name)

	})

	http.ListenAndServe(":8080", nil)
}

// https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/token?client_id=d6b668c7-e181-4415-b6fe-fb7a76d48d4a&response_type=id_token&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Foauth%2Fredirect&response_mode=form_post&scope=openid%20profile&state=12345&nonce=678910
