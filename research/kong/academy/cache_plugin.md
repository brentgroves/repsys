# Using Proxy Caching Plugins

In this course, we will look at optimizing traffic using the 'Proxy Cache' and 'Proxy Caching Advanced' plugins for Kong Gateway.

(KDLL-212) Controlling API Traffic using Proxy Caching Plugins and decK

<https://education.konghq.com/enrollments/197600325/details>

## Controlling API Traffic using Proxy Caching Plugins and decK

### Introduction

Traffic control is an important aspect of API management, not only for security purposes but also performance and business reasons.

In this course, we will look at optimizing traffic using the Proxy Cache and Proxy Caching Advanced plugins for Kong Gateway.

We will manually configure our Kong Gateway using a declarative approach with decK. However, bear in mind that in a production environment decK YAML manifests will not be applied manually but applied within the context of an APIOps pipeline. The setup and usage of APIOps pipelines using GitHub are covered in another course.

### Setup Lab Environment

Run the following command to start your lab.

source ./start_lab.sh
This will deploy a Kong Gateway and instantiate several services and routes.

Please note you may need to wait for up to a minute before the system is available.

Once the script completes, run the following command in the terminal window.

```bash
http http://localhost:8000/transactions
HTTP/1.1 200 OK
Access-Control-Allow-Credentials: true
Cache-Control: no-cache
Connection: keep-alive
Content-Length: 517
Content-Type: application/json; charset=utf-8
Date: Thu, 25 Jan 2024 19:08:06 GMT
ETag: W/"205-u4o2XSHOR6oYVCAyD/5BTbm6Xgk"
Expires: -1
Pragma: no-cache
Vary: Origin, Accept-Encoding
Via: kong/3.2.2.0-enterprise-edition
X-Content-Type-Options: nosniff
X-Kong-Proxy-Latency: 96
X-Kong-Upstream-Latency: 10
X-Powered-By: Express

[
    {
        "amount": 10.2,
        "currency": "EUR",
        "destination": "GR872659435350353",
        "id": "b88f7029-fa93-41a5-9462-4884e544bf63",
        "senderName": "Max Mustermann",
        "source": "DE8412325587359375895",
        "subject": "The money we have talked about"
    },
    {
        "amount": 10000,
        "currency": "EUR",
        "destination": "GR872559435350353",
        "id": "143aadce-f995-4503-ba6e-01ed01c6af88",
        "senderName": "Mister Smith",
        "source": "UK8412325587359375895",
        "subject": "Invoice #34078ja"
    }
]
```

You should get a HTTP 200 OK response.

However, you'll notice this is an anonymous request, so there are no controls on usage or any optimizations in place. In this course, we will use the Proxy Cache and Proxy Caching Advanced plugins to control the traffic flow.

## About the Lab Environment

In this course, we will be using a fictional banking application called BanKonG.

You can verify the service & routes

http localhost:8001/services | jq '.data[].name'

## About the Workspace

Kong Manager is available by clicking the 'Kong Manager' tab in the lab environment. You may need to click the refresh icon on the bottom right of the screen.

## Proxy Cache Plugins

The Proxy Cache and Proxy Caching Advanced plugins both cache HTTP responses, reducing the number of requests proxied to the upstream Service, hence significantly reducing latency & improving performance.

They both cache responses based on configurable response codes, content types, or request methods, either on a per-consumer or per-API basis, however

- Proxy Cache plugin stores cache entities in memory
- Proxy Caching Advanced plugin stores cache entities in memory or in Redis, making the entities available across dataplanes.

## Caching Plugin Operations

The status of the request’s proxy cache is defined in the X-Cache-Status header as

**Hit**: The request was satisfied and served from cache.
**Miss**: The request could be satisfied in cache, but an entry for the resource was not found in cache, and the request was proxied upstream.
**Refresh**: The resource was found in cache, but could not satisfy the request, due to Cache-Control behaviors or reaching its hard-coded cache_ttl threshold.
**Bypass**: The request could not be satisfied from cache based on plugin configuration

The Cache-Control response header is respected when the cache_control option is enabled. However, resource entities can be stored longer than the cache_ttl or Cache-Control values so clients using max-age and max-stale headers can request stale copies of data if necessary.

## Using Proxy Caching Advanced Plugin

In this section we will

- Configure Proxy Cache Advanced Plugin
- Verify that Requests to the Service are Cached
- Proxy Cache Plugin API
- Retrieve & Delete a Cache Entity

## Task 1: Configure Proxy Cache Advanced Plugin

Let's add Proxy Cache Advanced plugin to improve the performance of our service.

We will proxy 200 OK responses to GET and HEAD requests, with cache entities being stored in redis for 10 minutes (the default is 300 seconds or 5 minutes).

```bash
cat > traffic-control/proxy-cache-advanced.yaml <<EOF
plugins:
- name: proxy-cache-advanced
  service: Transactions_API_of_BanKonG
  config: 
    cache_ttl: 600
    response_code:
    - 200
    request_method:
    - GET
    - HEAD
    content_type:
    - text/plain
    - application/json; charset=utf-8
    strategy: redis
    redis: 
      host: redis
      port: 6379
EOF

```
