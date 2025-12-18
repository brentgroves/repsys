# Kong Academy

## references

<https://education.konghq.com/dashboard>

<brent.groves@gmail.com>

## Task 1: Configure a Request Transformer Advanced Plugin

We'll configure the request-transformer-advanced plugin to modify the HTTP request to:

Add the header X-Kong-Test-Request_Header:MyHeader, and
Rename header User-Agent to My-User-Agent

```bash
cat > transformations/adv-request.yaml <<EOF
plugins:
- name: request-transformer-advanced
  service: Mockbin_API_of_BanKonG
  config: 
    rename:
      headers:
      - User-Agent:My-User-Agent
    add:
      headers:
      - X-Kong-Test-Request-Header:MyRequestHeader
EOF

```

## Task 2: Create a Request to See Request Headers

Now submit a request and view the request headers echoed back in the body by the upstream:

```bash
deck gateway sync deck/bankong-base.yaml \
    transformations/adv-request.yaml
```

```bash
http GET localhost:8000/echo-request

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Headers: host,connection,x-forwarded-for,x-forwarded-proto,x-forwarded-host,x-forwarded-port,x-forwarded-path,x-real-ip,accept-encoding,accept,my-user-agent,x-kong-test-request-header
Access-Control-Allow-Methods: GET
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Length: 808
Content-Type: application/json; charset=utf-8
Date: Tue, 23 Jan 2024 20:34:00 GMT
ETag: W/"328-Yy7/Hpjon1ggcokobmOK6w"
Vary: Accept, Accept-Encoding
Via: kong/3.2.2.0-enterprise-edition
X-Kong-Proxy-Latency: 18
X-Kong-Upstream-Latency: 33
X-Powered-By: mockbin

{
    "bodySize": 0,
    "clientIPAddress": "172.18.0.1",
    "cookies": {},
    "headers": {
        "accept": "*/*",
        "accept-encoding": "gzip, deflate",
        "connection": "keep-alive",
        "host": "mockbin.bankong:8080",
        "my-user-agent": "HTTPie/3.2.1",
        "x-forwarded-for": "172.18.0.1",
        "x-forwarded-host": "localhost",
        "x-forwarded-path": "/echo-request",
        "x-forwarded-port": "8000",
        "x-forwarded-proto": "http",
        "x-kong-test-request-header": "MyRequestHeader",
        "x-real-ip": "172.18.0.1"
    },
    "headersSize": 388,
    "httpVersion": "HTTP/1.1",
    "method": "GET",
    "postData": {
        "mimeType": "application/octet-stream",
        "params": [],
        "text": ""
    },
    "queryString": {},
    "startedDateTime": "2024-01-23T20:34:00.785Z",
    "url": "http://localhost/request/echo-request"
}

## summary of changes
...
"my-user-agent": "HTTPie/3.2.1",
"x-kong-test-request-header": "MyRequestHeader",
...

HTTP/1.1 200 OK
```

## Task 3: Configure a Response Transformer Advanced Plugin

The Response Transformer Advanced plugin is very similar to the Request Transformer. We'll use it to:

Add the response header X-Kong-Test-Header:Test-Value
Add the JSON key json-key-added:Test-Key to the response body

```yaml
cat > transformations/adv-response.yaml <<EOF
plugins:
- name: response-transformer-advanced
  service: Mockbin_API_of_BanKonG
  config: 
    add:
      json:
      - json-key-added:Test-Key
      headers:
      - X-Kong-Test-Header:Test-Value
EOF

```

## Task 4: Create a Request to See Response Headers/Body

Now apply the configuration and submit a request and view the response headers and JSON key added to the response:

```bash
deck gateway sync deck/bankong-base.yaml \
    transformations/adv-response.yaml 

http GET localhost:8000/echo-request

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Headers: host,connection,x-forwarded-for,x-forwarded-proto,x-forwarded-host,x-forwarded-port,x-forwarded-path,x-real-ip,accept-encoding,accept,user-agent
Access-Control-Allow-Methods: GET
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Type: application/json; charset=utf-8
Date: Tue, 23 Jan 2024 20:51:30 GMT
ETag: W/"2f0-DgOZxH0hzilEu8nsVM0XdQ"
Transfer-Encoding: chunked
Vary: Accept, Accept-Encoding
Via: kong/3.2.2.0-enterprise-edition
X-Kong-Proxy-Latency: 1
X-Kong-Test-Header: Test-Value
X-Kong-Upstream-Latency: 2
X-Powered-By: mockbin

{
    "bodySize": 0,
    "clientIPAddress": "172.18.0.1",
    "cookies": {},
    "headers": {
        "accept": "*/*",
        "accept-encoding": "gzip, deflate",
        "connection": "keep-alive",
        "host": "mockbin.bankong:8080",
        "user-agent": "HTTPie/3.2.1",
        "x-forwarded-for": "172.18.0.1",
        "x-forwarded-host": "localhost",
        "x-forwarded-path": "/echo-request",
        "x-forwarded-port": "8000",
        "x-forwarded-proto": "http",
        "x-real-ip": "172.18.0.1"
    },
    "headersSize": 340,
    "httpVersion": "HTTP/1.1",
    "json-key-added": "Test-Key",
    "method": "GET",
    "postData": {
        "mimeType": "application/octet-stream",
        "params": [],
        "text": ""
    },
    "queryString": {},
    "startedDateTime": "2024-01-23T20:51:30.515Z",
    "url": "http://localhost/request/echo-request"
}

```

## jq Plugin

What is the jq Plugin?
jq is a lightweight and flexible CLI JSON processor that allows the user to manipulate and transform JSON documents. jq is like awk, grep or sed for JSON data, you can use it to slice, filter, map and transform structured data within a JSON document.

The jq plugin enables arbitrary jq transformations on JSON objects included in API requests or responses. This plugin covers the functionality of both request and response transformer plugins, and adds more capabilities when working with JSON bodies.

Note: In the response context the entire body must be buffered to be processed. This requirement implies that the Content-Length header will be dropped if present, and the body transferred with chunked encoding.

jq Plugin Sample Use Cases
Sample use cases for jq plugin could be

Transform a request body to maintain backwards compatibility
Delete sensitive Information from a response
Convert a JSON response to CSV
Convert celsius to fahrenheit
Many more….

## Using the **[jq Plugin](https://docs.konghq.com/hub/kong-inc/jq/how-to/basic-example/)**

In this section you will:

Configure jq Plugin to Remove IP Address Information
Create Request to See Updated Response

## Task 1: Configure jq Plugin to Remove IP Address Information

We'll configure jq plugin to update the response as follows

Remove clientIPAddress and headers.x-real-ip
Add test123 to .postData.text

```bash
cat > transformations/jq.yaml <<EOF
plugins:
- name: jq
  service: Mockbin_API_of_BanKonG
  config:
    response_jq_program: del(.clientIPAddress,.headers."x-real-ip") | .postData.text = "test123"
    response_if_media_type:
    - application/json
    response_if_status_code:
    - 200
EOF
```

```bash
deck gateway sync deck/bankong-base.yaml \
    transformations/jq.yaml
```

## Task 2: Create Request to See Updated Response

Now submit a request and see the response has been updated accordingly

```bash
http GET localhost:8000/echo-request

HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Access-Control-Allow-Headers: host,connection,x-forwarded-for,x-forwarded-proto,x-forwarded-host,x-forwarded-port,x-forwarded-path,x-real-ip,accept-encoding,accept,user-agent
Access-Control-Allow-Methods: GET
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Type: application/json; charset=utf-8
Date: Tue, 23 Jan 2024 21:02:49 GMT
ETag: W/"2f0-w4En/hrHe46rLgl7m/ytbQ"
Transfer-Encoding: chunked
Vary: Accept, Accept-Encoding
Via: kong/3.2.2.0-enterprise-edition
X-Kong-Proxy-Latency: 116
X-Kong-Upstream-Latency: 3
X-Powered-By: mockbin

{
    "bodySize": 0,
    "cookies": {},
    "headers": {
        "accept": "*/*",
        "accept-encoding": "gzip, deflate",
        "connection": "keep-alive",
        "host": "mockbin.bankong:8080",
        "user-agent": "HTTPie/3.2.1",
        "x-forwarded-for": "172.18.0.1",
        "x-forwarded-host": "localhost",
        "x-forwarded-path": "/echo-request",
        "x-forwarded-port": "8000",
        "x-forwarded-proto": "http"
    },
    "headersSize": 340,
    "httpVersion": "HTTP/1.1",
    "method": "GET",
    "postData": {
        "mimeType": "application/octet-stream",
        "params": [],
        "text": "test123"
    },
    "queryString": {},
    "startedDateTime": "2024-01-23T21:02:49.670Z",
    "url": "http://localhost/request/echo-request"
}

# summary

...
{
    "bodySize": 0,
    "cookies": {},
    "headers": {
     ...
        "x-forwarded-path": "/echo-request",
        "x-forwarded-port": "8000",
        "x-forwarded-proto": "http"
    },
    "headersSize": 342,
    "httpVersion": "HTTP/1.1",
    "method": "GET",
    "postData": {
        "mimeType": "application/octet-stream",
        "params": [],
        "text": "test123"
```

## Exit Transformer Plugin

What is the Exit Transformer Plugin?
The 'Exit Transformer Plugin' is used to customize and transform Kong response exit messages using Lua functions. This plugin has a range of capabilities from changing body/header/status code to complete transformation of the structure of responses.

Kong API Gateway is built on OpenResty, which extends the NGINX proxy server to run Lua scripts, so you can use Lua to create custom function or plugins.

## Using Exit Transformer Plugin

In this section you will:

1. Using Transformer Plugin
2. Create Plugin Config & Transformation Function
3. Configure Exit Transformer Plugin
4. Create Request to See Response Header/Body Transformation

## Task 1: Using Transformer Plugin

We'll configure 'Exit Transformer' plugin to add a header, append to any message, and add error and status field to the response body, in case of an error.

First, let's create a deck state file to add the key-auth plugin to our Mockbin service so we can simulate a 401 Unauthorized error

```bash
cat > transformations/mockbin-key-auth.yaml <<EOF
plugins:
- name: key-auth
  service: Mockbin_API_of_BanKonG
  config:
    key_names:
    - x-api-key
    key_in_header: true
    key_in_query: false
    key_in_body: false
EOF
```

```bash
deck gateway sync deck/bankong-base.yaml \
    transformations/mockbin-key-auth.yaml
```

Now we can make a call before applying the plugin to see the exit response:

```bash
http GET localhost:8000/echo-request

HTTP/1.1 401 Unauthorized
Connection: keep-alive
Content-Length: 45
Content-Type: application/json; charset=utf-8
Date: Tue, 23 Jan 2024 21:10:07 GMT
Server: kong/3.2.2.0-enterprise-edition
WWW-Authenticate: Key realm="kong"
X-Kong-Response-Latency: 1

{
    "message": "No API key found in request"
}
```

## Task 2: Create Plugin Config & Transformation Function

Next, create an instance of the exit transformer plugin, supplying a Lua function to

1. Add a header "X-Transform-Header: Exit Transformer Plugin Triggered"
2. Change the message to "***WARNING: No API key found in request**"
3. Add 'error: true' and the HTTP status to the JSON body:

```bash
cat << EOF > transformations/exit-transformer.yaml
plugins:
- name: exit-transformer
  service: Mockbin_API_of_BanKonG
  config:
    functions:
    - |
      -- transform.lua
          return function(status, body, headers)
            if not body or not body.message then
              return status, body, headers
            end

            headers = { ["X-Transform-Header"] = "Exit Transformer Plugin Triggered" }
            local new_body = {
              error = true,
              status = status,
              message =  "***WARNING: " .. body.message .. "***",
            }

            return status, new_body, headers
          end
EOF
```

## Task 3: Configure Exit Transformer Plugin

Next, apply the Exit Transformer plugin configuration and reissue our proxy request

```bash
deck gateway sync deck/bankong-base.yaml \
  transformations/mockbin-key-auth.yaml \
  transformations/exit-transformer.yaml
```

## Task 4: Create Request to See Response Header/Body Transformation

Now submit a request and view the response body from the upstream transformed by the exit transformer plugin:

```bash
http GET localhost:8000/echo-request
HTTP/1.1 401 Unauthorized
Connection: keep-alive
Content-Length: 82
Content-Type: application/json; charset=utf-8
Date: Tue, 23 Jan 2024 21:15:46 GMT
Server: kong/3.2.2.0-enterprise-edition
WWW-Authenticate: Key realm="kong"
X-Kong-Response-Latency: 1
X-Transform-Header: Exit Transformer Plugin Triggered

{
    "error": true,
    "message": "***WARNING: No API key found in request***",
    "status": 401
}
```

## Kongratulations

Kongratulations! You have now completed the "API Transformations Plugins and decK" course.

Note: This is one of a series of developer track courses on Controlling API Traffic on Kong Gateway using decK. See also

KDLL-211 Controlling API Traffic using Rate Limiting Plugins and decK
KDLL-212 Controlling API Traffic using Proxy Caching Plugins and decK
KDLL-213 Controlling API Traffic using ACL Plugin and decK
KDLL-214 Controlling API Traffic using Canary Deployments Plugin and decK
Please visit <https://education.konghq.com/> to continue your Kong education.

Thinking of becoming Kong Certified? Visit <https://konghq.com/academy/certification.it> status.
