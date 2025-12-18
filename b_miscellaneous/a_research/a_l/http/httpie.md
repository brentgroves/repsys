# HTTPIE

## references

<https://httpie.io/docs/cli>

<https://httpie.io/>

<https://httpie.io/cli>

## HTTPIE FOR TERMINAL

A simple yet powerful command-line HTTP and API testing client for the API era.

## install

sudo apt install httpie

## Getting started

HTTPie installs http and https:

Hello World:

```bash
https httpie.io/hello
```

## Custom HTTP method, HTTP headers and JSON data

```bash
http PUT pie.dev/put X-API-Token:123 name=John
```

## Submitting forms

```bash
http -f POST pie.dev/post hello=World
```

## See the request that is being sent using one of the output options

```bash
http -v pie.dev/get
```

## Build and print a request without sending it using offline mode

```bash
http --offline pie.dev/post hello=offline
```

## Upload a file using redirected input

```bash
http pie.dev/post < files/data.json
```

## Download a file and save it via redirected output

```bash
http pie.dev/image/png > image.png

```

## Download a file wget style

```bash
http --download pie.dev/image/png
```

## Use named **[sessions](https://httpie.io/docs/cli/sessions)** to make certain aspects of the communication persistent between requests to the same host

```bash
http --session=logged-in -a username:password pie.dev/get API-Key:123
http --session=logged-in pie.dev/headers
```

## Set a custom Host header to work around missing DNS records

```bash
http localhost:8000 Host:example.com
```
