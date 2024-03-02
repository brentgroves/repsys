# **[Missing oid claim](https://stackoverflow.com/questions/48786606/oid-claim-is-missing-in-microsoft-id-token-claims)**

The oid claim will only be returned if the scope profile was requested.

From the **[documentation](https://learn.microsoft.com/en-us/azure/active-directory/develop/active-directory-v2-tokens)**:

Because the oid allows multiple apps to correlate users, the profile scope is required in order to receive this claim.

For users where you don't receive the oid claim, check the token to make sure the profile scope is there. If it isn't there (and you've confirmed it was requested) then you can force the scopes for that token to be refreshed by adding &prompt=consent to the end of your authentication URI. This will force the user to re-consent to the scopes and ensure you're not getting a cached token.

## **[Important Claim note](https://stackoverflow.com/questions/48786606/oid-claim-is-missing-in-microsoft-id-token-claims)**

You must request the **profile** scope to see the oid claim
