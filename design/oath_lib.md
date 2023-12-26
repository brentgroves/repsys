# OAuth2 Libraries
use oauth2 to access 2 apis at once
OAuth 2 Access Token Usage Strategies For Multiple Resources (APIs)
https://medium.com/@robert.broeckelmann/oauth2-access-token-usage-strategies-for-multiple-resources-apis-part-3-780ea3decfe6
https://medium.com/@robert.broeckelmann/oauth2-access-token-usage-strategies-for-multiple-resources-apis-part-3-780ea3decfe6
https://www.pingidentity.com/en/resources/blog/post/oauth2-access-token-multiple-resources-usage-strategies.html
## references
https://reintech.io/blog/implementing-authentication-authorization-go
https://medium.com/@shujaamarwat/securing-react-apps-with-oauth-and-jwt-22a82490fe1a
https://oauth.net/code/nodejs/
https://codeculturepro.medium.com/implementing-authentication-in-nodejs-app-using-oauth2-0-59fee8f63798

## Goal

Use a server to perform OAuth2 authentication.
Use redis to distribute private part to each API.
Clients may access any API with a single JWT token.

## REST API authentication

https://stackoverflow.blog/2021/10/06/best-practices-for-authentication-and-authorization-for-rest-apis/
https://blog.hubspot.com/website/api-authentication

Use API keys to give existing users programmatic access
While your REST endpoints can serve your own website, a big advantage of REST is that it provides a standard way for other programs to interact with your service. To keep things simple, don't make your users do OAuth2 locally or make them provide a username/password combo—that would defeat the point of having used OAuth2 for authentication in the first place. Instead, keep things simple for yourself and your users, and issue API keys. Here's how:

When a user signs up for access to your API, generate an API key: var token = crypto.randomBytes(32).toString('hex');
Store this in your database, associated with your user.
Carefully share this with your user, making sure to keep it as hidden as possible. You might want to show it only once before regenerating it, for instance.
Have your users provide their API keys as a header, like curl -H "Authorization: apikey MY_APP_API_KEY" https://myapp.example.com
To authenticate a user's API request, look up their API key in the database.
When a user generates an API key, let them give that key a label or name for their own records. Make it possible to later delete or regenerate those keys, so your user can recover from compromised credentials.

