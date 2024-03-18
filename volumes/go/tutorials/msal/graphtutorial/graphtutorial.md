# Graph tutorial

<https://ravichaganti.com/blog/azure-sdk-for-go-authentication-methods-environmental-credential/>
<https://github.com/AzureAD/microsoft-authentication-library-for-go>
<https://learn.microsoft.com/en-us/graph/tutorials/go?tabs=aad>
<https://learn.microsoft.com/en-us/entra/identity-platform/msal-authentication-flows#client-credentials>
<https://learn.microsoft.com/en-us/entra/msal/dotnet/acquiring-tokens/web-apps-apis/client-credential-flows>

repsys requestor
Application (client) Id: 3d156079-1781-42d2-9ba1-ee541109edca
Object Id: 26d30dca-23e8-471c-b4f0-5377cf2844be
Directory (tenant) Id: 07476fd3-6a57-4e3f-80ab-a1be2af5d10a
Supported account types:My organization only
platform: web

## Create a Go console app

25 minutes remaining
Begin by initializing a new Go module using the Go CLI. Open your command-line interface (CLI) in a directory where you want to create the project. Run the following command.

## Creating the project

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/msal
mkdir graphtutorial
cd graphtutorial
go mod init graphtutorial
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/msal/graphtutorial
dirs -v
pushd +X # where X is 0 based number from the bottom of dirs -v entries
```

## Install dependencies

Before moving on, add some additional dependencies that you will use later.

- Azure Identity Client Module for Go to authenticate the user and acquire access tokens.
- Microsoft Graph SDK for Go to make calls to the Microsoft Graph.
- GoDotEnv for reading environment variables from .env files.

Run the following commands in your CLI to install the dependencies.

```bash
go get github.com/Azure/azure-sdk-for-go/sdk/azidentity
go get github.com/microsoftgraph/msgraph-sdk-go
go get github.com/joho/godotenv
```

## Load application settings

In this section you'll add the details of your app registration to the project.

Create a file in the same directory as go.mod named .env and add the following code.

```bash
CLIENT_ID=3d156079-1781-42d2-9ba1-ee541109edca
TENANT_ID=common
GRAPH_USER_SCOPES=user.read,mail.read,mail.send
```

Update the values according to the following table.

```bash
CLIENT_ID The client ID of your app registration
TENANT_ID If you chose the option to only allow users in your organization to sign in, change this value to your tenant ID. Otherwise leave as common.
```

Optionally, you can set these values in a separate file named .env.local.

## Design the app

In this section you will create a simple console-based menu.

Create a new directory in the same directory as go.mod named graphhelper.

Add a new file in the graphhelper directory named graphhelper.go and add the following code.

```golang
package graphhelper

import (
    "context"
    "fmt"
    "os"
    "strings"

    "github.com/Azure/azure-sdk-for-go/sdk/azcore/policy"
    "github.com/Azure/azure-sdk-for-go/sdk/azidentity"
    auth "github.com/microsoft/kiota-authentication-azure-go"
    msgraphsdk "github.com/microsoftgraph/msgraph-sdk-go"
    "github.com/microsoftgraph/msgraph-sdk-go/models"
    "github.com/microsoftgraph/msgraph-sdk-go/users"
)

type GraphHelper struct {
    deviceCodeCredential *azidentity.DeviceCodeCredential
    userClient           *msgraphsdk.GraphServiceClient
    graphUserScopes      []string
}

func NewGraphHelper() *GraphHelper {
    g := &GraphHelper{}
    return g
}
```

This creates a basic GraphHelper type that you will extend in later sections to use Microsoft Graph.

Create a file in the same directory as go.mod named graphtutorial.go. Add the following code.

**[graphtutorial.go](graphtutorial.go)**

Add the following placeholder methods at the end of the file. You'll implement them in later steps.

```go
func initializeGraph(graphHelper *graphhelper.GraphHelper) {
    // TODO
}

func greetUser(graphHelper *graphhelper.GraphHelper) {
    // TODO
}

func displayAccessToken(graphHelper *graphhelper.GraphHelper) {
    // TODO
}

func listInbox(graphHelper *graphhelper.GraphHelper) {
    // TODO
}

func sendMail(graphHelper *graphhelper.GraphHelper) {
    // TODO
}

func makeGraphCall(graphHelper *graphhelper.GraphHelper) {
    // TODO
}
```

## Add user authentication

In this section you will extend the application from the previous exercise to support authentication with Azure AD. This is required to obtain the necessary OAuth access token to call the Microsoft Graph. In this step you will integrate the Azure Identity Client Module for Go into the application and configure authentication for the Microsoft Graph SDK for Go.

The Azure Identity library provides a number of TokenCredential classes that implement OAuth2 token flows. The Microsoft Graph client library uses those classes to authenticate calls to Microsoft Graph.

## Configure Graph client for user authentication

In this section you will use the DeviceCodeCredential class to request an access token by using the device code flow.

Add the following function to ./graphhelper/graphhelper.go.

```go
func (g *GraphHelper) InitializeGraphForUserAuth() error {
    clientId := os.Getenv("CLIENT_ID")
    tenantId := os.Getenv("TENANT_ID")
    scopes := os.Getenv("GRAPH_USER_SCOPES")
    g.graphUserScopes = strings.Split(scopes, ",")

    // Create the device code credential
    credential, err := azidentity.NewDeviceCodeCredential(&azidentity.DeviceCodeCredentialOptions{
        ClientID: clientId,
        TenantID: tenantId,
        UserPrompt: func(ctx context.Context, message azidentity.DeviceCodeMessage) error {
            fmt.Println(message.Message)
            return nil
        },
    })
    if err != nil {
        return err
    }

    g.deviceCodeCredential = credential

    // Create an auth provider using the credential
    authProvider, err := auth.NewAzureIdentityAuthenticationProviderWithScopes(credential, g.graphUserScopes)
    if err != nil {CLIENT_ID
        return err
    }

    // Create a request adapter using the auth provider
    adapter, err := msgraphsdk.NewGraphRequestAdapter(authProvider)
    if err != nil {
        return err
    }

    // Create a Graph client using request adapter
    client := msgraphsdk.NewGraphServiceClient(adapter)
    g.userClient = client

    return nil
}
```

If you are using goimports, some modules may have been auto-removed from your import statement in graphhelper.go on save. You may need to re-add the modules to build.

Replace the empty initializeGraph function in graphtutorial.go with the following.

```go
func initializeGraph(graphHelper *graphhelper.GraphHelper) {
    err := graphHelper.InitializeGraphForUserAuth()
    if err != nil {
        log.Panicf("Error initializing Graph for user auth: %v\n", err)
    }
}
```

This code initializes two properties, a DeviceCodeCredential object and a GraphServiceClient object. The InitializeGraphForUserAuth function creates a new instance of DeviceCodeCredential, then uses that instance to create a new instance of GraphServiceClient. Every time an API call is made to Microsoft Graph through the userClient, it will use the provided credential to get an access token.

## Test the DeviceCodeCredential

Next, add code to get an access token from the DeviceCodeCredential.

Add the following function to ./graphhelper/graphhelper.go.

```go
func (g *GraphHelper) GetUserToken() (*string, error) {
    token, err := g.deviceCodeCredential.GetToken(context.Background(), policy.TokenRequestOptions{
        Scopes: g.graphUserScopes,
    })
    if err != nil {
        return nil, err
    }

    return &token.Token, nil
}
```

Replace the empty displayAccessToken function in graphtutorial.go with the following.

```go
func displayAccessToken(graphHelper *graphhelper.GraphHelper) {
    token, err := graphHelper.GetUserToken()
    if err != nil {
        log.Panicf("Error getting user token: %v\n", err)
    }

    fmt.Printf("User token: %s", *token)
    fmt.Println()
}
```

Build and run the app by running go run graphtutorial. Enter 1 when prompted for an option. The application displays a URL and device code.

```bash
Go Graph Tutorial

Please choose one of the following options:
0. Exit
1. Display access token
2. List my inbox
3. Send mail
4. Make a Graph call
1
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and
enter the code RB2RUD56D to authenticate.

```
