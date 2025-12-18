# **[Mailtrap Docs](https://api-docs.mailtrap.io/docs/mailtrap-api-docs/5tjdeg9545058-mailtrap-api)**

**[Back to Research List](../../../../research/research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## references

- **[email sending articles](https://help.mailtrap.io/category/108-email-sending)**

## Mailtrap API

This is documentation for API v2. Please refer here for Email Testing API v1 documentation.

Mailtrap API is based on the REST principles. The following documentation covers core resources that are used to manipulate the main entities. To start using the Mailtrap API, only a Mailtrap account is required. You have to be authenticated and call the simple HTTPS request on the URL specified below. Please read these basic instructions before you start working with the API.

We offer the following SDKs to integrate Mailtrap API in your application:

NodeJS SDK
Ruby SDK
PHP SDK
Python SDK
Elixir SDK

## There are several ways to send authenticated HTTP requests

- Send a HTTP header Api-Token: {api_token}, where {api_token} is your API token
- Send a HTTP header Authorization: Bearer #{token}, where {api_token} is your API token (more info: Token Access Authentication)
You can manage your API token on the API Tokens page. API token does not have an expiration date, you may reset it manually.

Allowed requests and common responses
Allowed HTTPs requests include:

POST - to create a resource
PATCH - to update a resource
PUT - to replace a resource
GET - to get a resource or a list of resources
DELETE - to delete a resource

Here is the description of common server responses:

200 OK - the request was successful (some API calls may return 201 instead).
204 No Content - the request was successful but there is no representation to return (i.e. the response is empty).
401 Unauthorized - authentication failed or user doesn't have permissions for requested operation.
403 Forbidden - access denied.
404 Not Found - resource was not found.
422 Unprocessable Entity - requested data contain invalid values.
All requests must be sent over HTTPS protocol.
