# **[OAuth2 Example](https://pkg.go.dev/golang.org/x/oauth2@v0.18.0)**

Config describes a typical 3-legged OAuth2 flow, with both the client application information and the server's endpoint URLs. For the client credentials 2-legged OAuth2 flow, see the clientcredentials package (<https://golang.org/x/oauth2/clientcredentials>).

## Create the Go project

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/oauth2
mkdir oauth2_example
cd oauth2_example
go mod init oath2_example
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/oauth2/oauth2_example
dirs -v
pushd +x

```

## **[Register the web app](register_app.md)**

Dev Account Client Application
Client Id:e0e65e2b-9f59-495a-81fd-b6738ab023fc
value:nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss
Application:b08211fd-0bcf-4700-a70a-e600bc0bcf77
Application ID URI=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77
scope=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read
redirect uri:<http://localhost:8080/oauth/redirect>
Visible to users? Yes
directory name: MSFT
domain: 1hkt5t.onmicrosoft.com
directory id:5269b021-533e-4702-b9d9-72acbc852c97
tenant: 5269b021-533e-4702-b9d9-72acbc852c97

href="<https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?response_type=code&client_id=b08211fd-0bcf-4700-a70a-e600bc0bcf77&scope=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read">>
