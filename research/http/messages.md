# HTTP Message

HTTP messages are how data is exchanged between a server and a client. There are two types of messages: requests sent by the client to trigger an action on the server, and responses, the answer from the server.

## references

<https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages>
<https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages>

## HTTP Messages

HTTP messages are composed of textual information encoded in ASCII, and span over multiple lines. In HTTP/1.1, and earlier versions of the protocol, these messages were openly sent across the connection. In HTTP/2, the once human-readable message is now divided up into HTTP frames, providing optimization and performance improvements.

Web developers, or webmasters, rarely craft these textual HTTP messages themselves: software, a Web browser, proxy, or Web server, perform this action. They provide HTTP messages through config files (for proxies or servers), APIs (for browsers), or other interfaces.

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages/httpmsg2.png)

HTTP requests, and responses, share similar structure and are composed of:

1. A start-line describing the requests to be implemented, or its status of whether successful or a failure. This is always a single line.
2. An optional set of HTTP headers specifying the request, or describing the body included in the message.
3. A blank line indicating all meta-information for the request has been sent.
4. An optional body containing data associated with the request (like content of an HTML form), or the document associated with a response. The presence of the body and its size is specified by the start-line and HTTP headers.

The start-line and HTTP headers of the HTTP message are collectively known as the head of the requests, whereas its payload is known as the body.

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages/httpmsgstructure2.png)

## HTTP Requests

### Request line

Note: The start-line is called the "request-line" in requests.

HTTP requests are messages sent by the client to initiate an action on the server. Their request-line contain three elements:

1. An HTTP method, a verb (like GET, PUT or POST) or a noun (like HEAD or OPTIONS), that describes the action to be performed. For example, GET indicates that a resource should be fetched or POST means that data is pushed to the server (creating or modifying a resource, or generating a temporary document to send back).
2. The request target, usually a URL, or the absolute path of the protocol, port, and domain are usually characterized by the request context. The format of this request target varies between different HTTP methods. It can be

    - An absolute path, ultimately followed by a '?' and query string. This is the most common form, known as the origin form, and is used with GET, POST, HEAD, and OPTIONS methods.

        - POST / HTTP/1.1
        - GET /background.png HTTP/1.0
        - HEAD /test.html?query=alibaba HTTP/1.1
        - OPTIONS /anypage.html HTTP/1.0
`
    - A complete URL, known as the absolute form, is mostly used with GET when connected to a proxy. GET <https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages> HTTP/1.1
    - The authority component of a URL, consisting of the domain name and optionally the port (prefixed by a ':'), is called the authority form. It is only used with CONNECT when setting up an HTTP tunnel. CONNECT developer.mozilla.org:80 HTTP/1.1
    - The asterisk form, a simple asterisk ('*') is used with OPTIONS, representing the server as a whole. OPTIONS* HTTP/1.1
3. The HTTP version, which defines the structure of the remaining message, acting as an indicator of the expected version to use for the response.

## Headers

HTTP headers from a request follow the same basic structure of an HTTP header: a case-insensitive string followed by a colon (':') and a value whose structure depends upon the header. The whole header, including the value, consists of one single line, which can be quite long.

Many different headers can appear in requests. They can be divided in several groups:

- General headers, like Via, apply to the message as a whole.
- Request headers, like User-Agent or Accept, modify the request by specifying it further (like Accept-Language), by giving context (like Referer), or by conditionally restricting it (like If-None-Match).
- Representation headers like Content-Type that describe the original format of the message data and any encoding applied (only present if the message has a body).

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages/http_request_headers3.png)

## Body

The final part of the request is its body. Not all requests have one: requests fetching resources like GET or HEAD usually don't need a body. Requests that send data to the server to create a resource, such as PUT or POST requests, typically require a body with the data used to fulfill the request (for instance, HTML form data).

Bodies can be broadly divided into two categories:

- Single-resource bodies, consisting of one single file, defined by the two headers: Content-Type and Content-Length.
- Multiple-resource bodies, consisting of a multipart body, each containing a different bit of information. This is typically associated with HTML Forms.

## HTTP Responses

Status line

Note: The start-line is called the "status line" in responses.

The start line of an HTTP response, called the status line, contains the following information:

- The protocol version, usually HTTP/1.1, but can also be HTTP/1.0.
- A status code, indicating success or failure of the request. Common status codes are 200, 404, or 302.
- A status text. A brief, purely informational, textual description of the status code to help a human understand the HTTP message.

A typical status line looks like: HTTP/1.1 404 Not Found.

## Headers

HTTP headers for responses follow the same structure as any other header: a case-insensitive string followed by a colon (':') and a value whose structure depends upon the type of the header. The whole header, including its value, presents as a single line.

Many different headers can appear in responses. These can be divided into several groups:

- General headers, like Via, apply to the whole message.
- Response headers, like Vary and Accept-Ranges, give additional information about the server which doesn't fit in the status line.
- Representation headers like Content-Type that describe the original format of the message data and any encoding applied (only present if the message has a body).

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages/http_response_headers3.png)

## Next

<https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages>

<https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Location>
