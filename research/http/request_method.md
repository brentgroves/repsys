# HTTP Method

## references

<https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods>

## HTTP request methods

HTTP defines a set of request methods to indicate the desired action to be performed for a given resource. Although they can also be nouns, these request methods are sometimes referred to as HTTP verbs. Each of them implements a different semantic, but some common features are shared by a group of them: e.g. a request method can be **[safe](https://developer.mozilla.org/en-US/docs/Glossary/Safe/HTTP)**, **[idempotent](https://developer.mozilla.org/en-US/docs/Glossary/Idempotent)**, or **[cacheable](https://developer.mozilla.org/en-US/docs/Glossary/Cacheable)**

**Safe (HTTP Methods)**
An HTTP method is safe if it doesn't alter the state of the server. In other words, a method is safe if it leads to a read-only operation. Several common HTTP methods are safe: GET, HEAD, or OPTIONS. All safe methods are also idempotent, but not all idempotent methods are safe. For example, PUT and DELETE are both idempotent but unsafe..

**Idempotent**
An HTTP method is idempotent if the intended effect on the server of making a single request is the same as the effect of making several identical requests.

All safe methods are idempotent, as well as PUT and DELETE. The POST method is not idempotent.

To be idempotent, only the state of the server is considered. The response returned by each request may differ: for example, the first call of a DELETE will likely return a 200, while successive ones will likely return a 404. Another implication of DELETE being idempotent is that developers should not implement RESTful APIs with a delete last entry functionality using the DELETE method.

Note that the idempotence of a method is not guaranteed by the server and some applications may incorrectly break the idempotence constraint.

GET /pageX HTTP/1.1 is idempotent, because it is a safe (read-only) method. Successive calls may return different data to the client, if the data on the server was updated in the meantime.

POST /add_row HTTP/1.1 is not idempotent; if it is called several times, it adds several rows:

HTTP
POST /add_row HTTP/1.1
POST /add_row HTTP/1.1   -> Adds a 2nd row
POST /add_row HTTP/1.1   -> Adds a 3rd row

DELETE /idX/delete HTTP/1.1 is idempotent, even if the returned status code may change between requests:

HTTP
DELETE /idX/delete HTTP/1.1   -> Returns 200 if idX exists
DELETE /idX/delete HTTP/1.1   -> Returns 404 as it just got deleted
DELETE /idX/delete HTTP/1.1   -> Returns 404

## Cacheable

A cacheable response is an HTTP response that can be cached, that is stored to be retrieved and used later, saving a new request to the server. Not all HTTP responses can be cached; these are the constraints for an HTTP response to be cacheable:

- The method used in the request is cacheable, that is either a GET or a HEAD method. A response to a POST or PATCH request can also be cached if freshness is indicated and the Content-Location header is set, but this is rarely implemented. For example, Firefox does not support it (Firefox bug 109553). Other methods, like PUT or DELETE are not cacheable and their result cannot be cached.
- The status code of the response is known by the application caching, and is cacheable. The following status codes are cacheable: 200, 203, 204, 206, 300, 301, 404, 405, 410, 414, and 501.
- There are no specific headers in the response, like Cache-Control, with values that would prohibit caching.

Note that some requests with non-cacheable responses to a specific URI may invalidate previously cached responses from the same URI. For example, a PUT to /pageX.html will invalidate all cached responses to GET or HEAD requests to /pageX.html.

When both the method of the request and the status of the response are cacheable, the response to the request can be cached:

HTTP
GET /pageX.html HTTP/1.1
(…)

200 OK
(…)
The response to a PUT request cannot be cached. Moreover, it invalidates cached data for requests to the same URI using HEAD or GET methods:

HTTP
PUT /pageX.html HTTP/1.1
(…)

200 OK
(…)
The presence of the Cache-Control header with a particular value in the response can prevent caching:

HTTP
GET /pageX.html HTTP/1.1
(…)

200 OK
Cache-Control: no-cache
(…)

GET
The GET method requests a representation of the specified resource. Requests using GET should only retrieve data.

HEAD
The HEAD method asks for a response identical to a GET request, but without the response body.

POST
The POST method submits an entity to the specified resource, often causing a change in state or side effects on the server.

PUT
The PUT method replaces all current representations of the target resource with the request payload.

DELETE
The DELETE method deletes the specified resource.

CONNECT
The CONNECT method establishes a tunnel to the server identified by the target resource.

OPTIONS
The OPTIONS method describes the communication options for the target resource.

TRACE
The TRACE method performs a message loop-back test along the path to the target resource.

PATCH
The PATCH method applies partial modifications to a resource.
