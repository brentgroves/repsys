# **[Use delegated authentication](https://learn.microsoft.com/en-us/graph/use-postman-with-delegated-authentication)** with Postman for Microsoft Graph

## Step 1: Get a delegated access token

The first time you run a request as a delegated authentication flow, you need to get an access token:

1. Select the Delegated folder.
2. Select the Authorization tab.
3. In the Configure New Token section, make sure the callback URL matches with what you provided when you created the application registration, for example, <https://oauth.pstmn.io/v1/browser-callback>. Leave all the fields as preconfigured, including the Grant type that is set to Authorization Code.
4. Scroll down on the right and select Get New Access Token.
5. Sign in with your developer tenant administrator account.
6. Select Proceed, and then select the Use Token button.
7. You have now a valid access token to use for delegated requests.

## Step 2: Run your first delegated request

The Delegated folder contains many requests for Microsoft Graph workloads that you can consume:

1. Expand the Delegated folder, and then expand the Mail folder.
2. Double-click Get my messages to open the request.
On the top right, select Send.
