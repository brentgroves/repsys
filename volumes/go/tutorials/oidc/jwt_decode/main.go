https://stackoverflow.com/questions/41077953/how-to-verify-jwt-signature-with-jwk-in-go
const jwksURL = `https://companyx.okta.com/oauth2/v1/keys`

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

    return nil, fmt.Errorf("unable to find key %q", keyID)
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
