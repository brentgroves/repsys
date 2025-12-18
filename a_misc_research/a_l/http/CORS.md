# CORS

## references

<https://developer.mozilla.org/en-US/docs/Glossary/CORS>

CORS
CORS (Cross-Origin Resource Sharing) is a system, consisting of transmitting HTTP headers, that determines whether browsers block frontend JavaScript code from accessing responses for cross-origin requests.

The same-origin security policy forbids cross-origin access to resources. But CORS gives web servers the ability to say they want to opt into allowing cross-origin access to their resources.

CORS headers
Access-Control-Allow-Origin
Indicates whether the response can be shared.

Access-Control-Allow-Credentials
Indicates whether or not the response to the request can be exposed when the credentials flag is true.

Access-Control-Allow-Headers
Used in response to a preflight request to indicate which HTTP headers can be used when making the actual request.

Access-Control-Allow-Methods
Specifies the method or methods allowed when accessing the resource in response to a preflight request.

Access-Control-Expose-Headers
Indicates which headers can be exposed as part of the response by listing their names.

Access-Control-Max-Age
Indicates how long the results of a preflight request can be cached.

Access-Control-Request-Headers
Used when issuing a preflight request to let the server know which HTTP headers will be used when the actual request is made.

Access-Control-Request-Method
Used when issuing a preflight request to let the server know which HTTP method will be used when the actual request is made.

Origin
Indicates where a fetch originates from.

Timing-Allow-Origin
Specifies origins that are allowed to see values of attributes retrieved via features of the Resource Timing API, which would otherwise be reported as zero due to cross-origin restrictions.
