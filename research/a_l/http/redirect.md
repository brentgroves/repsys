# **[Redirections in HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP/Redirections)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

URL redirection, also known as URL forwarding, is a technique to give more than one URL address to a page, a form, a whole website, or a web application. HTTP has a special kind of response, called a HTTP redirect, for this operation.

Redirects accomplish numerous goals:

- Temporary redirects during site maintenance or downtime
- Permanent redirects to preserve existing links/bookmarks after changing the site's URLs, progress pages when uploading a file, etc.

## Principle

In HTTP, redirection is triggered by a server sending a special redirect response to a request. Redirect responses have status codes that start with 3, and a Location header holding the URL to redirect to.

![rd](https://developer.mozilla.org/en-US/docs/Web/HTTP/Redirections/httpredirect.svg)
