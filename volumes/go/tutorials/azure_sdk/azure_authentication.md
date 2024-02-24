# Azure SDK for Go - Authentication methods for local development environment

## references

<https://ravichaganti.com/blog/azure-sdk-for-go-authentication-methods-for-local-dev-environment/>

## azidentity package

The earlier article introduced you to the Azure SDK for Go. In the example towards the end of that article, you may have noticed how the NewAzureCLICredential method of the azidentity package was used to access locally available Azure CLI credentials. This is perfect for local development and is not recommended for production environments. The Azure SDK supports different types of credentials depending on where your Go code is running. In this article in the Azure SDK for Go series, you will learn about each of these credential types and when you use each of these credentials.

The azidentity package provides Azure Active Directory (or should we call it Entra!) authentication support through different types of token credential implementations. Azure SDK clients are lazily initialized; therefore, authentication and authorization do not occur until an actual Azure resource operation is performed. Therefore, the following program will not return an error even when the local Azure CLI credentials are unavailable.

```go
package main

import (
 "log"

 "github.com/Azure/azure-sdk-for-go/sdk/azidentity"
)

func main() {
 _, err := azidentity.NewDefaultAzureCredential(nil)
 if err != nil {
  log.Fatal(err)
 }

}
```

This is an important point to remember because many of us think this method should fail when no credentials are available or when the credentials are invalid.

To authenticate and access/manage Azure services, your user account needs appropriate permissions/roles assigned to it. In the examples outlined in this series, it is assumed that you have the appropriate permissions.

Credential Types
The azidentity package supports authentication through different types of credentials. At a higher level, these credentials can be classified as development (or local) and production (or hosted service) types. Note that this is not an official classification. The development type credentials are useful in local dev, test, and debug scenarios. This includes:

- Azure CLI credentials
- Device code credentials
- Interactive browser-based credentials
- Username and Password credentials
- Environment credentials

The hosted service or production-type credentials are useful in Azure-hosted service scenarios. This includes:

- Environment credentials
- Managed identity credentials
- Workload identity credentials

The next few sections of this article will walk you through the different credential types for local development, testing, and debugging and show you how to use these credentials to authenticate your Go programs.

## Azure CLI credential

In the previous part of this series, you have seen an example that used the NewAzureCLICredential() method to retrieve locally available credentials. This method returns a token credential implemented as the AzureCLICredential type.

The NewAzureCLICredential() method takes an optional parameter of type AzureCLICredentialOptions. Using this struct, you can specify the additional tenants for which the credential may acquire tokens. If you need only the home tenant of the logged-in user, you can specify nil as the parameter value.

```go
// github.com/rchaganti/azure-go/02-auth101/azcli.go
cred, err := azidentity.NewAzureCLICredential(nil)
if err != nil {
    log.Fatal(err)
}
```

When you use this method in a program and there are no Azure CLI credentials available locally, the program will exit with an error prompting you to run az login.

```bash
$ go run azcli.go 
2023/07/15 06:59:49 AzureCLICredential: ERROR: Please run 'az login' to setup account.
exit status 1
```

Interactive browser login
When you run az login, you will typically see an interactive browser window open automatically, and you will be prompted to log in to your Azure account. Once the login is successful, the authentication process returns the token credentials that can be cached locally. The same method can be implemented in your Go programs managing Azure or accessing Azure services. This is done using the NewInteractiveBrowserCredential method. You can pass the optional InteractiveBrowserCredentialOptions parameter to modify the allowed tenants, specify a login hint, and enable support for disconnected clouds such as Azure stack. The usage of this method is similar to what you have already seen for Azure CLI credentials.

```go
// github.com/rchaganti/azure-go/02-auth101/interactivebrowser.go
cred, err := azidentity.NewInteractiveBrowserCredential(nil)
if err != nil {
    log.Fatal(err)
}

This method fails if the local session has no support for an interactive browser.

```bash
go run interactivebrowser.go 
2023/07/15 07:14:05 InteractiveBrowserCredential: exec: "xdg-open,x-www-browser,www-browser": executable file not found in $PATH
exit status 1
```

If a browser is available, you will see a screen similar to what is shown below. You can log in to an authorized account to access Azure services and authenticate.

![alt](https://ravichaganti.com/images/azlogin.png)

## Device code credential

The device code base authentication should be familiar if you have used Azure PowerShell or similar tools. This is especially useful when your local environment lacks Azure CLI or a browser for interactive login. This method generates an alpha-numeric code that you need to input into a browser window for authentication. The azidentity package provides the NewDeviceCodeCredential() method to achieve device code-based authentication. This method takes an optional DeviceCodeCredentialOptions parameter using which you can specify additional allowed tenants and a custom prompt.

```go
// github.com/rchaganti/azure-go/02-auth101/devicecode.go
deviceCodeCredOptions := &azidentity.DeviceCodeCredentialOptions{
    UserPrompt: func(ctx context.Context, deviceCodeMessage azidentity.DeviceCodeMessage) error {
        fmt.Printf("Enter code %s at https://microsoft.com/devicelogin to complete authentication.\n", deviceCodeMessage.UserCode)
        return nil
    },
}

cred, err := azidentity.NewDeviceCodeCredential(deviceCodeCredOptions)
if err != nil {
    log.Fatal(err)
}
```

The custom prompt is implemented using the UserPrompt field of the DeviceCodeCredentialOptions struct.

```bash
go run devicecode.go 
Enter code HMYPYSK8J at https://microsoft.com/devicelogin to complete authentication.
```

## Username and Password credential

This method of using a username and password is slightly involved and is not recommended for security reasons. However, a developer may use this within the local environment. The NewUsernamePasswordCredential() method in the azidentity package is used for this type of authentication. The account you use must satisfy the following requirements.

- It should be a school or work account and not a Microsoft account.
- You need an Azure AD application registration.
- A client secret must exist within the Azure AD application.
- The Azure AD application registration must be granted admin consent

The NewUsernamePasswordCredential() takes a few parameters such as tenantID, clientID, username, and password and includes UsernamePasswordCredentialOptions that specify additional allowed tenants and enable authentication in disconnected cloud scenarios. tenantID is the Azure tenant ID, and clientID is the Azure AD application ID.

```go
// github.com/rchaganti/azure-go/02-auth101/usernamepassword.go
cred, err := azidentity.NewUsernamePasswordCredential(tenantID, clientID, username, password, nil)
if err != nil {
    log.Fatal(err)
}
```

If all the prerequisites are met and the username and password are valid, executing this program must return a list of resource groups within the subscription.

## Next

<https://ravichaganti.com/blog/azure-sdk-for-go-authentication-methods-managed-identity-credential/>

<https://ravichaganti.com/categories/azure/>
<https://learn.microsoft.com/en-us/openapi/kiota/tutorials/go-azure?tabs=portal>
