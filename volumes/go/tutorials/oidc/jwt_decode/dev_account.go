package main

// https://stackoverflow.com/questions/41077953/how-to-verify-jwt-signature-with-jwk-in-go
import (
	"errors"
	"fmt"

	"github.com/dgrijalva/jwt-go"
	"github.com/lestrrat/go-jwx/jwk"
)

const token = "eyJhbGciOiJSUzI1NiIsImtpZCI6Ind5TXdLNEE2Q0w5UXcxMXVvZlZleVExMTlYeVgteHlreW1ra1h5Z1o1T00ifQ.eyJzdWIiOiIwMHUxOGVlaHUzNDlhUzJ5WDFkOCIsIm5hbWUiOiJva3RhcHJveHkgb2t0YXByb3h5IiwidmVyIjoxLCJpc3MiOiJodHRwczovL2NvbXBhbnl4Lm9rdGEuY29tIiwiYXVkIjoidlpWNkNwOHJuNWx4ck45YVo2ODgiLCJpYXQiOjE0ODEzODg0NTMsImV4cCI6MTQ4MTM5MjA1MywianRpIjoiSUQuWm9QdVdIR3IxNkR6a3RUbEdXMFI4b1lRaUhnVWg0aUotTHo3Z3BGcGItUSIsImFtciI6WyJwd2QiXSwiaWRwIjoiMDBveTc0YzBnd0hOWE1SSkJGUkkiLCJub25jZSI6Im4tMFM2X1d6QTJNaiIsInByZWZlcnJlZF91c2VybmFtZSI6Im9rdGFwcm94eUBva3RhLmNvbSIsImF1dGhfdGltZSI6MTQ4MTM4ODQ0MywiYXRfaGFzaCI6Im1YWlQtZjJJczhOQklIcV9CeE1ISFEifQ.OtVyCK0sE6Cuclg9VMD2AwLhqEyq2nv3a1bfxlzeS-bdu9KtYxcPSxJ6vxMcSSbMIIq9eEz9JFMU80zqgDPHBCjlOsC5SIPz7mm1Z3gCwq4zsFJ-2NIzYxA3p161ZRsPv_3bUyg9B_DPFyBoihgwWm6yrvrb4rmHXrDkjxpxCLPp3OeIpc_kb2t8r5HEQ5UBZPrsiScvuoVW13YwWpze59qBl_84n9xdmQ5pS7DklzkAVgqJT_NWBlb5uo6eW26HtJwHzss7xOIdQtcOtC1Gj3O82a55VJSQnsEEBeqG1ESb5Haq_hJgxYQnBssKydPCIxdZiye-0Ll9L8wWwpzwig"

const jwksURL = "https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/discovery/v2.0/keys"

func getKey(token *jwt.Token) (interface{}, error) {

	// TODO: cache response so we don't have to make a request every time
	// we want to verify a JWT
	set, err := jwk.FetchHTTP(jwksURL)
	if err != nil {
		return nil, err
	}

	keyID, ok := token.Header["kid"].(string)
	if !ok {
		return nil, errors.New("expecting JWT header to have string kid")
	}

	if key := set.LookupKeyID(keyID); len(key) == 1 {
		return key[0].Materialize()
	}

	return nil, errors.New("unable to find key")
}

func main() {
	token, err := jwt.Parse(token, getKey)
	if err != nil {
		panic(err)
	}
	claims := token.Claims.(jwt.MapClaims)
	for key, value := range claims {
		fmt.Printf("%s\t%v\n", key, value)
	}
}
