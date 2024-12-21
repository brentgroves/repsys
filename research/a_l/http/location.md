# **[Location](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Location)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

The HTTP Location response header indicates the URL to redirect a page to. It only provides a meaning when served with a 3XX redirection response or a 201 Created status response.

In redirections, the HTTP method used to make the redirected request to fetch the page pointed to by Location depends on the original method and the kind of redirection:

- 303 See Other responses always result in a GET request in the redirection.
- 307 Temporary Redirect and 308 Permanent Redirect use the same method as the initiating request.
- 301 Moved Permanently and 302 Found should use the same request method as the initiating request, although this is not guaranteed for older user-agents.

Location and Content-Location are different. Content-Location indicates the URL to use to directly access the resource in future when content negotiation occurred. Location is associated with the response, while Content-Location is associated with the representation that was returned.
