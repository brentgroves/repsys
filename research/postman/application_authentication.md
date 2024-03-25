# **[Use app-only (application) authentication with Postman for Microsoft Graph](https://learn.microsoft.com/en-us/graph/use-postman-with-app-only-authentication)**

This article describes how you can use app-only (application) authentication with Postman for Microsoft Graph to run requests without a signed-in user.

## Prerequisite

Complete the setup instructions in the **[Use Postman with the Microsoft Graph API](https://learn.microsoft.com/en-us/graph/use-postman)** article, before you can continue with this tutorial.

Got this to work to retrieve user profile but to send mail only got it to work users with M365 E5 licenses.

## Step 1: Get an application access token

The first time you run a request as an application authentication flow, you need to get an access token:

1. Select the Application folder.
2. Select the Authorization tab.
3. In the Configure New Token section, leave all the fields as preconfigured, including the Grant type that is set to Client Credentials.
4. Scroll down on the right and select Get New Access Token.
5. Select Proceed, and then select the Use Token button.

You have now a valid access token to use for application requests.

## Step 2: Run your first application request

The Application folder contains many requests for Microsoft Graph workloads that you can consume:

1. Expand the Application folder, and then expand the User folder.
2. Double-click Get Users to open the request.
3. On the top right, select Send.
4. Expand the mail folder and open the "send mail as user" request. I had to make this it was not part of the collection.

    ```json
    // https://graph.microsoft.com/v1.0/users/{{UserId}}/sendMail
    // raw json
    {
    "message": {
        "subject": "RepSys Test",
        "body": {
        "contentType": "Text",
        "content": "The new cafeteria is open."
        },
        "toRecipients": [
        {
            "emailAddress": {
            "address": "{{UserName}}"
            }
        }
        ],
        "ccRecipients": [
        {
            "emailAddress": {
            "address": "{{UserName}}"
            }
        }
        ]
    },
    "saveToSentItems": "false"
    }
    ```

5. On the top right, select Send.

You have now successfully run a Microsoft Graph request using application authentication.

You can repeat these steps to run other requests to Microsoft Graph. Note that you have to add **[permissions](https://learn.microsoft.com/en-us/graph/permissions-reference)** to your Microsoft Entra application for other requests to work; otherwise, you get permission denied errors in your responses. To find the right permissions, check the Permissions section of the relevant API and look for the application permission type.
