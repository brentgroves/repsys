# Microsoft Identity Platform

## references

<https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-web-app-python-sign-in?tabs=windows>

<https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc>

<https://github.com/Azure-Samples/ms-identity-python-webapp>

<https://learn.microsoft.com/en-us/entra/identity-platform/index-web-app?pivots=devlang-python>

<https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc>

## OpenID Connect on the Microsoft identity platform

OpenID Connect (OIDC) extends the OAuth 2.0 authorization protocol for use as an additional authentication protocol. You can use OIDC to enable single sign-on (SSO) between your OAuth-enabled applications by using a security token called an ID token.

The full specification for OIDC is available on the OpenID Foundation's website at OpenID Connect Core 1.0 specification.

## Protocol flow: Sign-in

The following diagram shows the basic OpenID Connect sign-in flow. The steps in the flow are described in more detail in later sections of the article.

![](https://learn.microsoft.com/en-us/entra/identity-platform/media/v2-protocols-oidc/convergence-scenarios-webapp.svg)

 Tip

Try running this request in **[Postman](https://app.getpostman.com/run-collection/f77994d794bab767596d)**
Try executing this request and more in Postman -- don't forget to replace tokens and IDs!

Followed link above and imported myworkspace into web app.  Web app showed Azure OAuth2 requests such as:

```Postman UI and Azure Postman collection
A set of requests for trying out the Azure AD v2.0 endpoint, including sign-in requests and token requests.
GET requests should be copy & pasted into a browser, since they'll require interactive user login.
POST requests can be run in Postman, of course.  Make sure to replace the placeholder values for parameters with your own.
These requests use a sample application that we've registered with Azure AD ahead of time.  
Good luck!
```

## Enable ID tokens

The ID token introduced by OpenID Connect is issued by the authorization server, the Microsoft identity platform, when the client application requests one during user authentication. The ID token enables a client application to verify the identity of the user and to get other information (claims) about them.

ID tokens aren't issued by default for an application registered with the Microsoft identity platform. ID tokens for an application are enabled by using one of the following methods:

1. Sign in to the **[Microsoft Entra admin center](https://entra.microsoft.com/#home)** as at least a Cloud Application Administrator.
main account: <brentgroves@1hkt5t.onmicrosoft.com>
<AlexW@1hkt5t.onmicrosoft.com>
EAxejwisiakJip3

2. Browse to Identity > Applications > App registrations and select New registration.
3. Under Supported account types, select "Accounts in any organizational directory (Any Microsoft Entra ID tenant - Multitenant)".
4. Enter a Name for your application, for example oidc_test.
5. Under Platform configurations, select Add a platform.
In the pane that opens, select the appropriate platform for your application. For example, select Web for a web application.
6. Under Redirect URIs, select Web for the platform.
Enter a redirect URI of <http://localhost:5000/getAToken>. This can be changed later.
7. Under Implicit grant and hybrid flows, select the ID tokens (used for implicit and hybrid flows) checkbox.
Or:
Select Identity > Applications > App registrations > oidc_test > Manifest.
Set oauth2AllowIdTokenImplicitFlow to true in the app registration's application manifest.
If ID tokens are not enabled for your app and one is requested, the Microsoft identity platform returns an unsupported_response error similar to:

Display name:oidc_test
Application (client) ID:2248d178-a9be-4ede-8bed-f1e72e381f59
Object ID:9eed2b39-d690-42b3-a6d2-36620c5b2f1a
Directory (tenant) ID:5269b021-533e-4702-b9d9-72acbc852c97
Supported account types:Multiple organizations
Client credentials:Add a certificate or secret
Redirect URIs:1 web, 0 spa, 0 public client
<http://localhost:5000/getAToken>
Application ID URI:Add an Application ID URI
Managed application in local directory:oidc_test
ID tokens (used for implicit and hybrid flows)

I later changed assigned Brent as an Owner because for some reason he was not already.

## Add a client secret

<https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-web-app-python-sign-in?tabs=windows>

- On the app Overview page, note the Application (client) ID value for later use. 2248d178-a9be-4ede-8bed-f1e72e381f59
- Under Manage, select the Certificates & secrets and from the Client secrets section, select New client secret.
- Enter a description for the client secret, leave the default expiration, and select Add.
Save the Value of the Client Secret in a safe location. You'll need it to configure the code, and you can't retrieve it later.

description: oidc_test
expires:12/29/2025
value: bQC8Q~u2PKduUfMBPZNIaubG14F6ZeXCL0u4Oa7O
       bQC8Q~u2PKduUfMBPZNIaubG14F6ZeXCL0u4Oa7O
secret id:ccdd3c2d-2837-4c42-bc7e-fc62e753999a
          ccdd3c2d-2837-4c42-bc7e-fc62e753999a

## Step 3: Add a scope

- Under Manage, select API permissions > Add a permission.
Ensure that the Microsoft APIs tab is selected.
- From the Commonly used Microsoft APIs section, select Microsoft Graph.
- From the Delegated permissions section, ensure that User.- ReadBasic.All is selected. Use the search box if necessary.
- Select Add permissions.

## Step 4: Download the sample app

Download the Python code sample or clone the repository:

```bash
pushd .
cd ~/src
git clone git@github.com:brentgroves/ms-identity-python-webapp.git
```

## Notice Identity Library

This Identity library is an authentication/authorization library that:

Suitable for apps that are targeting end users on Microsoft identity platform (which includes Work or school accounts provisioned through Azure AD, and Personal Microsoft accounts such as Skype, Xbox, Outlook.com).
Currently designed for web apps, regardless of which Python web framework you are using.
Provides a set of high level API that is built on top of, and easier to be used than Microsoft's MSAL Python library.
Written in Python, for Python apps.

Step 5: Configure the sample app

1.Go to the application folder.

2.Create an .env file in the root folder of the project using .env.sample as a guide.

- Set the value of CLIENT_ID to the Application (client) ID for the registered application, available on the overview page.
- Set the value of CLIENT_SECRET to the client secret you created in Certificates & Secrets for the registered application.
-Set the value of AUTHORITY to a URL that includes Directory (tenant) ID of the registered application. That ID is also available on the overview page.

The environment variables are referenced in app_config.py, and are kept in a separate .env file to keep them out of source control. The provided .gitignore file prevents the .env file from being checked in.

Step 6: Run the sample app

get out of conda environments since this tutorial uses python virtual environments instead.

```bash
conda deactivate
```

1.Create a virtual environment for the app:

```bash
pushd .
cd ~/src/ms-identity-python-webapp
python3 -m venv .venv
source .venv/bin/activate
```

2.Install the requirements using pip:

```bash

```

3.Run the app from the command line, specifying the host and port to match the redirect URI:

```bash
python3 -m flask run --debug --host=localhost --port=5000
```

This quickstart application uses a client secret to identify itself as confidential client. Because the client secret is added as a plain-text to your project files, for security reasons, it is recommended that you use a certificate instead of a client secret before considering the application as production application. For more information on how to use a certificate, see these **[instructions](https://learn.microsoft.com/en-us/entra/identity-platform/certificate-credentials)**.

4.goto browser and login from <http://localhost:5000>

Trace what is happenning using chrome network tab.

```bash
# enter into browser
http://localhost:5000/

# redirected to
http://localhost:5000/login

# look at signin button link
https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?client_id=2248d178-a9be-4ede-8bed-f1e72e381f59&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A5000%2FgetAToken&scope=User.ReadBasic.All+offline_access+openid+profile&state=pOImkfPoJiWMrXNv&code_challenge=ORuS97m1gkZlyxOJZ8F3SlXJobYdQEP-MwrP9XZKh4E&code_challenge_method=S256&nonce=286fe7722ea3f632b41c31c0736c29fe045c80e7a986461411c2b5c3507155da&client_info=1&prompt=select_account

https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/oauth2/v2.0/authorize?client_id=2248d178-a9be-4ede-8bed-f1e72e381f59&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A5000%2FgetAToken&scope=User.ReadBasic.All+offline_access+openid+profile&state=BPpmIJyoZurLQFOK&code_challenge=LbCASFNS3SIEk5-467jlZyUq8rl0MmKJoyeByWwGLhA&code_challenge_method=S256&nonce=0543d788ba83e5a5783d2f994d90d380ac1e7f87aaab8b93efe024b5fc1596b5&client_info=1&prompt=select_account

## redirect
https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/reprocess?ctx=rQQIARAAhZE_bBJRAMZ5HKVKYkt0c5GBxEQ87t0_7h2xiRCqPUAQBWlZmnfv3nkn1zvkjj8yOnWsg9G4tYMD2qRxMg7qaqeOxjiZmCga42KCm5Cms9_wy7d9X77vEiOkYTYpCBIyeAWxWNUpK1GDskinBmvyVBGoiHhTVrtnY_EXu9OL0S8vK_uLn7ed1J8PY3DBCoJOluMcj2DH8vwgK0MIubs0yNW9NnVfA3AEwDcAxuGrUJZEQ0FIx0ikMpYVJBqCqaqSoUJDRBCTWZyJFIyxjnRVpCaFgqTLJuFlNaPLn8LL1VwvsIQ5vK49opPwkk8dSoJNTIjXc4NnTDx_s7OlFR94rV63XLtWLY2ZJDyWyM55DHLiTvSKScpCRtWhwLOyKM5WUKDA6qqhsoqAiU6QLBBVOWRgw6fd9C2KjTz2bZLOOU7CM03Hdum8BfX9hNehrm0kOl3PtB36kQFHETCJhOGpaQTsLcx2fKw_32efTKpv39Wu_Px-njlc4OoN1G-UBpyCrRbXJOVUr9XsW_nR1vp9qlxHnha013Bl1b29Lq3IWX4nCnai535HwfZi6M3p_73wNAbGsRTvma0caltOwUW4tWG6irchFmtt6KvoHhnm_f7gRrmujTaruYMYeH8mNF36-ujH3u7fh7_WJsuXe5U7ZMCVcsV-CpcUSy9nJG3YytNCs10ckYJWsod1V9PsVcdfOYiH_gE1&sessionid=51589427-9585-4ab0-bbf3-8b121d27fbc0

# get token

http://localhost:5000/getAToken?code=0.AXwAIbBpUj5TAke52XKsvIUsl3jRSCK-qd5Oi-3x5y44H1nMALI.AgABAAIAAAAmoFfGtYxvRrNriQdPKIZ-AgDs_wUA9P-56ErV35-bOeMtHVtwrSzeiB9-199lJ1cc67u0NwVXHk2UK83GFp9kr-yGu57OFq1E1sBaMCRLsiuwfqHxDFU3zxSybD2jKdnla4s1YIYa0gPSDFU0eI4ldF1d4Ul3HMReBIFUPtCiFogvKdq778siuXxClTGIfz7XLJriTWNWfDsKABS68d3os5d8HY8MDCuCsvfTiYwYDt3zXPIZfi6gfEXCuPmco7XMu2ROXSWZ4KfJ--6XPDeAzd91VQPcPXVdSDil963Dn9hcr6nimqWbMmnY_bqPTSze-l0YdWH2NfTs4_F4OqE2scInWLhoZsxpxW-lnmM9Z7LgzPbKSENgwbMwoyS24F0Q4kucEiSEPlROM0FpAOgq16fskvKGIKBzy3NZVFbneELt1ewrK-1ZNOnvnXVFd2McNwWsg9Q4kyv0wjj25UuLAA0MKHv1WWKmO6IVgSiu5d-VqmisSqP9XC_53LjqtenG4gYZKT0TsWoEpd2O_bImBjfw93IiDruS7SmKtIoFp2G6uicf3fGVQJzoxeO3ML8xc4mBscq0ph5PLnvUdbjdmm4FkfhFouDjhvBtPgIACsKG51BxOG3QC9-cQTWKI50RD0CAh5zcE3DVabxAG45aKv9m2RNdUzj00x7xHASQ67_QsnbbaHJTLNIi6VqWLOn1xRZStrkUUy1J1pZdbu3aMiH2_OVTADwU1No94lSc3OXmeJvbqmyf1uluZiMtjQVMJs7ryXeUavKskSLELXDCgXBoGIzQVskpNXnWGZva0vNHXE-e_iGki3WdZd80nrrWEPvJ3iTbtvlVO-nv5aF3ZyU2_YnidUGpjHhYBbFbnyZp9ITItEVEJDfXPrbFGx_sGFinT4CQvt1oDoi_pI3nvHL_umjhX_zKug&client_info=eyJ1aWQiOiI5YWNjZmE4OS05ODcyLTRiNjYtOWQ3MC1iNzVmMjM0MmYzYmEiLCJ1dGlkIjoiNTI2OWIwMjEtNTMzZS00NzAyLWI5ZDktNzJhY2JjODUyYzk3In0&state=BPpmIJyoZurLQFOK&session_state=51589427-9585-4ab0-bbf3-8b121d27fbc0

```

## Next

<https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-web-app-python-sign-in?tabs=windows#step-4-download-the-sample-app>

<https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc#fetch-the-openid-configuration-document>

**[start_here](./api_management/openid_connect/oidc_azure/identity_platform/oidc_microsoft_identity_platform.md)**
