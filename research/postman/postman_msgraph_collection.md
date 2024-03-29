# [Microsoft Graph](https://dzone.com/articles/getting-access-token-for-microsoft-graph-using-oau)**

Microsoft Graph is here to unite Azure and Office 365 data under a single roof. It is a simple REST API and Microsoft provided many examples of how to use it, including an interactive Graph Explorer which allows us to discover the different methods.

Using the API is as simple as sending an HTTP request - for example, calling this method will return the details about the users in the directory:

```bash
https://graph.microsoft.com/v1.0/users
```

In the Graph Explorer demo page it all works fine, but as soon as we try to use the Graph API from outside the page, from another program or test application like Postman, we receive a "401 Unauthorized" exception.

What's the deal?

![](https://learn.microsoft.com/en-us/graph/images/microsoft-graph.png)

## references

- **[Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer)**

- **[Use the Graph API](https://learn.microsoft.com/en-us/graph/use-the-api)**

- **[Use Postman](https://learn.microsoft.com/en-us/graph/use-postman)**

## **[Step 1: Fork the Microsoft Graph Postman collection](https://learn.microsoft.com/en-us/graph/use-postman#step-1-fork-the-microsoft-graph-postman-collection)**

To use the Postman collection, fork it to your own Postman workspace. Do this from the web browser.

1. Go to **[Postman](https://www.postman.com/microsoftgraph)** and sign in.
2. Go to the Postman collection labeled Microsoft Graph.
3. Fill in a label for your own fork; this can be any text.
4. Under Workspace, ensure that My Workspace is selected in the dropdown list.
5. Select Fork Collection.

## Step 2: Download the Postman Agent (optional - Postman web browser only)

There is a lot of accessory programs for Postman.  I have not tried them yet.

## Step 2b: go to your **[My Postman web tenant](https://bold-shadow-4516.postman.co/)**

This is where your workspaces and collections are kept.

## Step 3: Create a Microsoft Entra application

To use this collection in your own developer tenant, create a Microsoft Entra application and give it the appropriate permissions for the requests that you want to call. If you don't have a Microsoft 365 tenant, you might qualify for one through the Microsoft 365 Developer Program; for details, see the FAQ. Alternatively, you can sign up for a 1-month free trial or purchase a Microsoft 365 plan.

1. Sign in to the Microsoft Entra admin center.
2. Expand the Identity menu > select Applications > App registrations > New registration.
3. Set the Application name to Postman.
4. From the dropdown menu, select Web.
5. Set the Redirect URI to <https://oauth.pstmn.io/v1/browser-callback>.
6. Select Register.
7. On the left menu, select API Permissions.
8. On the horizontal menu, select Add a permission, and choose Microsoft Graph.
9. Select the Delegated permissions option, type Mail., expand the Mail options, and then select Mail.Read.
10. Select the Application permissions option, type User., expand the User options, and then select User.Read.All. Type Mail., expand the Mail options, and then select Mail.Send. Noticed this says "Not granted for MSFT."
11. Select Add permissions to add both permissions from the previous steps.
12. On the horizontal menu, select Grant admin consent for, and then select Yes. Note that the prompt asks do you want to grant consent for the requests permissions for all accounts in MSFT. This will update any existing admin consent records this application already has to match what is listed below:

    ```text
    - Delegated:Mail.Read // Read user mail
    - Delegated:Mail.Send  // Send mail as a user
    - Delegated:User.Read // Sign in and read user profile
    - Application:User.Read.All // Read all users' full profiles
    - Application.Mail.ReadBasic.All // Read basic mail in all mailboxe
    - Application:Mail.Send // Send mail as any user
    ```

13. On the left menu, select Overview. From here, you can get the application (client) ID and directory (tenant) ID. You'll need these in step 4. CLIENT_ID=4bf317c1-3185-469f-8f13-8c37ccb2c31c,TENANT_ID=07476fd3-6a57-4e3f-80ab-a1be2af5d10a
14. On the left menu, select Certificates and secrets.
15. Select New client secret, enter a description, and then select Add. Hover over the new client secret Value and copy it; you'll need this in step 4. value=km78Q~h6peVsoA5aJKWBmH6JXoIItOO2OPBeKbEk,id=e10bf4da-eebf-423a-aaca-5a678a34a789
16. Fill out the **[app template](/media/brent/KINGSTON/secrets/azure/tenants/app_template.md)** and copy to it's tenant dir.

The application now has two permissions configured. Mail.Read is added as a delegated permission, which is a permission that requires a signed-in user. The application can read mail on behalf of the user. User.Read.All is added as an application permission, which is a permission that does not require a signed-in user. The application can read users in Microsoft Entra ID.

## **[Step 4: Configure authentication](https://learn.microsoft.com/en-us/graph/use-postman#step-4-configure-authentication)**

In this step, you set up the environment variables in Postman that you use to retrieve an access token.

Go to Fork environment.
**[app_info](/media/brent/KINGSTON/secrets/azure/tenants/msdev_1hkt5t/apps/postman.md)**

1. Add a label for the fork. This can be any text such as the name of the tenant, ie. msdev_1hkt5t.
2. Under Workspace, ensure that My Workspace is selected in the dropdown list.
Select Fork Environment. It was labeled app_name environment.
3. In ClientID, set the Current value to the application (client) ID value from step 3.15.
4. In TenantID, set the Current value to the directory (tenant) ID value from step 3.15.
5. In ClientSecret, set the Current value to the client secret value, km78Q~h6peVsoA5aJKWBmH6JXoIItOO2OPBeKbEk,from step 3.17.
6. On the top right, select Save.
7. Close the Manage Environments tab.
8. On the top right, next to the eye icon, verify that app_name Environment is selected in the dropdown and not No environment.

## Next steps

Now that you have successfully set up the environment to run Microsoft Graph on Postman, continue with the authentication steps:

- **[Use delegated authentication](./delegate_authentication.md)** with Postman for Microsoft Graph
- **[Use app-only (application) authentication](https://learn.microsoft.com/en-us/graph/use-postman-with-app-only-authentication)** with Postman for Microsoft Graph
