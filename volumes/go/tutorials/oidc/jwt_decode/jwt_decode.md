# Decode JWT

## references

<https://stackoverflow.com/questions/41077953/how-to-verify-jwt-signature-with-jwk-in-go>

## Steps

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/oidc
mkdir jwt_decode
cd jwt_decode
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/oidc/jwt_decode
pushd +0
go mod init jwt_decode
go get -u github.com/MicahParks/keyfunc/v3

```
