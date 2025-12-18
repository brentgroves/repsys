# **[Postman Microsoft Graph](https://www.postman.com/microsoftgraph/workspace/microsoft-graph/overview)**

Microsoft Graph is the unified API for modern work. It is the gateway to data and intelligence in Microsoft 365. Use the wealth of data in Microsoft Graph to build apps for organizations and consumers that interact with millions of users.
Microsoft Graph supports two access scenarios, delegated access and app-only access. In delegated access, the app calls Microsoft Graph on behalf of a signed-in user. In app-only access, the app calls Microsoft Graph with its own identity, without a signed in user.
In this collection, you can try out both delegated and application API calls.
To Get Started
Fork this collection into your workspace to get started with the Microsoft Graph APIs. For more details on how to use Postman with the Microsoft Graph APIs, see our step-by-step guide here.
Microsoft Graph API documentation
See the full API documentation here.

## Step 1: Fork the Microsoft Graph Postman collection

To use the Postman collection, fork it to your own Postman workspace.
Fork this collection by clicking this link or holding down Ctrl + Alt + F.
Fill in a label for your own fork; this can be any text.
Under Workspace, ensure that My Workspace is selected in the dropdown list.
brent_groves fork of Microsoft Graph project

## Step 2: Create an Azure AD application

To use this collection in your own developer tenant, create an Azure Active Directory (Azure AD) application and give it the appropriate permissions for the requests that you want to call. If you don't have a developer tenant, you can sign up for one through the Microsoft 365 Developer Program.
Note: My M365 Developer Program account no longer is licensed and the M365 developer program wont currently let you create a tenant with licenses and sample tenants like you used to.
For personal account which uses Delegated permission (you have tried in Microsoft Graph Explorer), the authority endpoint is <https://login.microsoftonline.com/commonm/oauth2/v2.0/authorize> or <https://login.microsoftonline.com/consumers/oauth2/v2.0/authorize>.

### Register your application

Sign in to the Microsoft Entra admin center.
Expand the Identity menu > select Applications > App registrations > New registration.
Set the Application name to Postman.
Set supported account types: For accounts linked to a basic M365 Office account select "Accounts in any organizational directory (Any Microsoft Entra ID tenant - Multitenant)" The reason is a M365 user is considered external to the tenant.
From the dropdown menu under Redirect URI, select Web.
Set the Redirect URI to <https://oauth.pstmn.io/v1/browser-callback>.
Select Register.

### Adding API Permissions

On the left menu, select API Permissions.
On the horizontal menu, select Add a permission, and choose Microsoft Graph.
Select the Delegated permissions option, type Mail., expand the Mail options, and then select Mail.Read.
Select the Application permissions option, type User., expand the User options, and then select User.Read.All.
Select Add permissions to add both permissions from the previous steps.
On the horizontal menu, select Grant admin consent for, and then select Yes. Note: Make sure you have logged into a developer tenant where you have admin access.

### Get the client ID and secret

On the left menu, select Overview. From here, you can get the application (client) ID and directory (tenant) ID. You'll need these in Step 3: Set up environment variables (next folder).
On the left menu, select Certificates and secrets.
Select New client secret, enter a description, and then select Add. Hover over the new client secret Value and copy it; you'll need this in Step 3: Set up environment variables (next folder).

The application now has two permissions configured. Mail.Read is added as a delegated permission, which is a permission that requires a signed-in user. The application can read mail on behalf of the user. User.Read.All is added as an application permission, which is a permission that does not require a signed-in user. The application can read users in Azure AD.

### Step 3: Set up environment variables

In this step, you set up the environment variables in Postman that you use to retrieve an access token.
Go to Fork environment.
Add a label for the fork. This can be any text.
Under Workspace, ensure that My Workspace is selected in the dropdown list.
Select Fork Environment.
In ClientID, set the Current value to the application (client) ID value from step 2: Get the client ID and secret section.
In TenantID, set the Current value to the directory (tenant) ID value from step 2: Get the client ID and secret section (previous folder).
In ClientSecret, set the Current value to the client secret value from step 2: Get the client ID and secret section (previous folder).
On the top right, select Save.
Close the Manage Environments tab.
On the top right, next to the eye icon, verify that M365 Environment is selected in the dropdown and not No environment.
