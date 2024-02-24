# OAuth Azure App registration

## references

<https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app>
<https://learn.microsoft.com/en-us/azure/healthcare-apis/register-application>
<https://learn.microsoft.com/en-us/graph/auth-register-app-v2>

## **[Enabling OAuth 2.0 Authentication with Azure Active Directory](https://support.smartbear.com/readyapi/docs/requests/auth/types/oauth2/tutorial-azure.html)**

When you use OAuth 2.0 authentication, you get access to a web service from a client application. The way you do this depends on the grant you use. In this tutorial, we will show how to configure the client credentials grant type for applications in Azure Active Directory. In the Client Credentials Grant type, the client application gets access to the web service by using its own credentials.

1. Register applications in Azure Active Directory
To be able to perform OAuth 2.0 authentication by using the client credentials grant type, you need to register both the web service and the client applications in Azure Active Directory. To learn how to do this, see the **[Microsoft documentation](https://docs.microsoft.com/en-us/graph/auth-register-app-v2)**.

Dev Account Client Application
Client Id:e0e65e2b-9f59-495a-81fd-b6738ab023fc
value:nRH8Q~HGjz4eSmS~~nGPxOdbILLOZfLM62~iScss
Application ID URI=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77
scope=api://b08211fd-0bcf-4700-a70a-e600bc0bcf77/Files.Read
redirect uri:<http://localhost:8080/oauth/redirect>

b08211fd-0bcf-4700-a70a-e600bc0bcf77

Outlook Client Application
Client Id:2e2f796f-09ce-4800-8267-3c5a2d85ec78
value:t4U8Q~Pvrih6CSyS_CX1ztrVzdeuWevudbvycdk7
Application ID URI=api://4c914e6c-f56e-4a77-a59f-733d6d37942e
redirect uri:<http://localhost:8080/oauth/redirect>
<http://localhost:8080/oauth/redirect>
