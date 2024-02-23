# **[Enabling OAuth 2.0 Authentication with Azure Active Directory](https://support.smartbear.com/readyapi/docs/requests/auth/types/oauth2/tutorial-azure.html)**

When you use OAuth 2.0 authentication, you get access to a web service from a client application. The way you do this depends on the grant you use. In this tutorial, we will show how to configure the client credentials grant type for applications in Azure Active Directory. In the Client Credentials Grant type, the client application gets access to the web service by using its own credentials.

1. Register applications in Azure Active Directory
To be able to perform OAuth 2.0 authentication by using the client credentials grant type, you need to register both the web service and the client applications in Azure Active Directory. To learn how to do this, see the **[Microsoft documentation](https://docs.microsoft.com/en-us/graph/auth-register-app-v2)**.
<brent.groves@outlook.com>
Name:Outlook Client Application
Display name:Outlook Client Application
Application (client) ID:4c914e6c-f56e-4a77-a59f-733d6d37942e
Object ID:8c35eed5-c802-4f9a-ad52-e29e88f44129
Directory (tenant) ID:07476fd3-6a57-4e3f-80ab-a1be2af5d10a
Supported account types:My organization only

<brentgroves@1hkt5t.onmicrosoft.com>
Name:Dev Account Client Application
Display name:Dev Account Client Application
Application (client) ID:b08211fd-0bcf-4700-a70a-e600bc0bcf77
Object ID:69dddb21-32be-4d6b-89ba-e2ca5f722ba3
Directory (tenant) ID:5269b021-533e-4702-b9d9-72acbc852c97
Supported account types:My organization only

Accounts in this organizational directory only (MSFT only - Single tenant)

Redirect URI (optional)
We’ll return the authentication response to this URI after successfully authenticating the user. Providing this now is optional and it can be changed later, but a value is required for most authentication scenarios.

2.Configure a client application
A client application is an application that requests a protected resource. After you register it in Azure Active Directory, you need to perform the following steps to apply the client credentials grant type:

    1. Open the Azure Active Directory service. In App registrations, open the registration of your client application.
    2. Copy the Application (client) ID to some place. You will need it to link the client to the web service and to configure the request authentication:

![alt](https://support.smartbear.com/readyapi/docs/_images/requests/auth/types/oauth2/azure-tutorial-client-app-id.png)

    3.In the Client Credentials Grant type, you will need a client secret. To get it, open the Certificates & secrets page and click New client secret:

![alt](https://support.smartbear.com/readyapi/docs/_images/requests/auth/types/oauth2/azure-tutorial-new-client-secret.png)

    Add a short description and click Add.
    Dev Account Client Application
secretId:e0e65e2b-9f59-495a-81fd-b6738ab023fc
value:nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss
Application ID URI=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77
redirect uri:<http://localhost:8080/oauth/redirect>

Outlook Client Application
secretId:2e2f796f-09ce-4800-8267-3c5a2d85ec78
value:t4U8Q~Pvrih6CSyS_CX1ztrVzdeuWevudbvycdk7
Application ID URI=api://4c914e6c-f56e-4a77-a59f-733d6d37942e
redirect uri:<http://localhost:8080/oauth/redirect>

    Credentials enable confidential applications to identify themselves to the authentication service when receiving tokens at a web addressable location (using an HTTPS scheme). For a higher level of assurance, we recommend using a certificate (instead of a client secret) as a credential.

    4.Copy the generated value to some place:
     You will not be able to get the client secret after you leave the Certificates & secrets page.

3.Configure a web service application
To configure a web service application, you need to authorize your client application. To do this, perform the following steps:
    1.Open the Azure Active Directory service. In App registrations, open the registration of your web service application.
    2.Open the Expose an API page.
    3.Set the Application ID URI:
![alt](https://support.smartbear.com/readyapi/docs/_images/requests/auth/types/oauth2/azure-tutorial-set-app-id-uri.png)
The globally unique URI used to identify this web API. It is the prefix for scopes and in access tokens, it is the value of the audience claim. Also referred to as an identifier URI.
Dev Account Client Application
Application ID URI=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77
Outlook Client Application
Application ID URI=api://4c914e6c-f56e-4a77-a59f-733d6d37942e

4.When you authorize a client, you specify the scope to restrict client access. To define the scope, click Add a scope and configure it as you need:
![alt](https://support.smartbear.com/readyapi/docs/_images/requests/auth/types/oauth2/azure-tutorial-add-scope.png)
5.To authorize the client application, click Add a client application and specify the Application ID you got earlier:
![alt](https://support.smartbear.com/readyapi/docs/_images/requests/auth/types/oauth2/azure-tutorial-authorize-app.png)

4.Configure a request authentication
Now, you can configure authentication to a protected resource.
Choose web app type:
