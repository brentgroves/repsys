# test
https://learn.microsoft.com/en-us/graph/tutorials/go-app-only?tabs=aad
https://learn.microsoft.com/en-us/entra/identity-platform/tutorial-v2-nodejs-console
https://devblogs.microsoft.com/microsoft365dev/building-go-applications-with-the-microsoft-graph-go-sdk/
https://www.example-code.com/golang/microsoftGraph.asp
https://learn.microsoft.com/en-us/openapi/kiota/tutorials/go-azure?tabs=portal
1. switch auth/token url in postman to common
2. change app registration to any organization since brent.groves@outlook.com is an external user.
3. look at your applications at https://myapplications.microsoft.com/
 
https://learn.microsoft.com/en-us/entra/msal/python/

"https://login.microsoftonline.com/common"
any orginazation
The authority is set to /common to allow sign ins with both organizaiton and personal Microsoft accounts. You can change it to /organizations to only allow sign ins with work and school accounts, /consumers to only allow personal Microsoft accounts, or with /YOUR_TENANT_ID to only allow sign ins from work and school accounts associated with your tenant.

https://learn.microsoft.com/en-us/graph/auth/

https://github.com/AzureAD/microsoft-authentication-library-for-python

![](https://learn.microsoft.com/en-us/entra/msal/python/media/redirect-urls.png)