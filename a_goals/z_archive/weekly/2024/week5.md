# week5

## Father's direction

My son finish installing and testing the API gateway and remember all results are in my hands.  What seems like failures are not.  These seeming failures are all apart of my plan to create in you a "loving heart."

I love you my son and know all that you are going through. I am with you and have a plan for this day. Take courage you have nothing to fear because I am with you. Have hope my son I have many wonderful things for you to look forward to. I will revive your spirit and guide you every step of the way my son.

Trust me to take care of you my son.  Do not fear anything because I am always here to take care of you.  You will go through many trials both hard and difficult but fear not.  These troubles are necessary for you to grow to be the man I want you to be.

Good morning dear ones,

I hope all is well with you and your loved ones.  As always please feel free to get in contact with me at home or at work for anything.

Sincerely yours,
Brent
260-564-4868

Finished
Working on the report sytem API gateway.
To do continue working on the guage report.

## API Gatework tasks

### Key Authentication

Authentication is the process of verifying that a requester has permissions to access a resource. API gateway authentication authenticates the flow of data to and from your upstream services.

Kong Gateway has a library of plugins that support the most widely used methods of API gateway **[authentication](https://docs.konghq.com/hub/#authentication)**.

Common authentication methods include:

- Key Authentication
- Basic Authentication
- OAuth 2.0 Authentication (Kong for free) <https://docs.konghq.com/hub/kong-inc/oauth2/>
- LDAP Authentication Advanced
- OpenID Connect

Test that the API is secure by sending a request using curl -i $PROXY_IP/echo. Observe that a HTTP 401 is returned with this message:

```bash
curl -i $PROXY_IP/echo
HTTP/1.1 401 Unauthorized
Date: Fri, 05 Jan 2024 17:48:36 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
WWW-Authenticate: Key realm="kong"
Content-Length: 96
X-Kong-Response-Latency: 1
Server: kong/3.5.0
X-Kong-Request-Id: 2e0dbd1ac29f85282b68067dc25f032e

{
  "message":"No API key found in request",
  "request_id":"2e0dbd1ac29f85282b68067dc25f032e"
}% 
```

### test http connection with API key

curl -H 'apikey: hello_world' $PROXY_IP/echo
Welcome, you are connected to node reports52.
Running on Pod echo-74c66b778-j2n45.
In namespace default.
With IP address 10.1.184.161.

### Rate limiting

### Test the rate-limiting plugin

To test the rate-limiting plugin, rapidly send six requests to $PROXY_IP/echo:

```bash
for i in `seq 6`; do curl -H 'apikey: hello_world' -sv $PROXY_IP/echo 2>&1 | grep "< HTTP"; done
< HTTP/1.1 200 OK
< HTTP/1.1 200 OK
< HTTP/1.1 200 OK
< HTTP/1.1 200 OK
< HTTP/1.1 200 OK
< HTTP/1.1 429 Too Many Requests
```

This shows that the rate limiting plugin is preventing the request from reaching the upstream service.

### Test the proxy-cache plugin

To test the proxy-cache plugin, send another six requests to $PROXY_IP/echo:

```bash
for i in `seq 6`; do curl -sv $PROXY_IP/echo 2>&1 | grep -E "(Status|< HTTP)"; done
< HTTP/1.1 200 OK
< X-Cache-Status: Miss
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 429 Too Many Requests

```

The first request results in X-Cache-Status: Miss. This means that the request is sent to the upstream service. The next four responses return X-Cache-Status: Hit which indicates that the request was served from a cache.

The X-Cache-Status header can return the following cache results:

| STATE   | DESCRIPTION                                                                                                                                        |
|---------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| Miss    | The request could be satisfied in cache, but an entry for the resource was not found in cache, and the request was proxied upstream.               |
| Hit     | The request was satisfied and served from the cache.                                                                                               |
| Refresh | The resource was found in cache, but could not satisfy the request, due to Cache-Control behaviors or reaching its hard-coded cache_ttl threshold. |
| Bypass  | The request could not be satisfied from cache based on plugin configuration.                                                                       |

The final thing to note is that when a HTTP 429 request is returned by the rate-limit plugin, you do not see a X-Cache-Status header. This is because rate-limiting executes before proxy-cache. For more information, see **[plugin priority](https://docs.konghq.com/gateway/latest/plugin-development/custom-logic/#kong-plugins)**.

## service mesh vs. API gateway

Here are the key things to know about service mesh vs. API gateway:

- Service mesh acts as a centralized infrastructure layer for efficient microservices communication, simplifying tasks like service discovery and load balancing.
- API gateways, on the other hand, serves as the entry point for external clients to access microservices, managing functions like request routing and authentication.

## API gateway

- Continus installing and testing the API gateway
- Then test the k8s API gateway by following the instructions at Kong Academy's **[API Transformations Plugins and decK](https://education.konghq.com/dashboard)** tutorial and/or **[jq plugin tutorial](https://docs.konghq.com/hub/kong-inc/jq/how-to/basic-example/)**.

## Kong academy

Kong Academy is a great training environment for its API Gateway. Here is its **[training catalog](https://education.konghq.com/catalog)**

## **[Embedding Lua in Go](https://otm.github.io/2015/07/embedding-lua-in-go/)**

Command line parameters, environment variables, and configuration files are common ways to change the behavior of software. However, sometimes that is just not enough and an embedded language can be the solution. In this case we will embed Lua using gopher-lua.

```go
package main

import "github.com/yuin/gopher-lua"

func main() {
  L := lua.NewState()
  defer L.Close()
  if err := L.DoString(`print("Hello World")`); err != nil {
    panic(err)
  }
}
```

lua.NewState() creates our Lua VM, and it is though L (*lua.LState) we will interact with Lua in the future. Throughout the post L will denote a pointer to lua.LState. L.DoString runs the Lua code in the VM. Running the Go code will yield:

```bash
$ go run hello.go
Hello World
```

## Migration

- get password
Office 365
<bgroves@buschegroup.com>
JesusLives1!
<Bgroves@mobexglobal.com>
Office 365  
<bgroves@buschegroup.com>  
JesusLives1!  
<Bgroves@mobexglobal.com>  
Spirit1$! - Nov 21,2023
Messiah2!$ - previous

UserName:  <bGroves@linamar.com>
Password:
L1n@ALB2023!053

Linamar Email Address:  <Brent.Groves@linamar.com>

### fork Azure repos

```bash
git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/Reporting
git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/mobexsql
git@ssh.dev.azure.com:v3/MobexGlobal/ReportBuilder/TrialBalance
trial_balance_powerbi
```

### Update git scripts

- startday-old.sh
- pull new repos to dev machines

### PowerBI

- License of PowerBI and PowerBI paginated reports

### Power BI Report Builder

- Publish Trial Balance to teams tab

## **[Multipass](https://multipass.run/docs)** Documentation

Multipass is a tool to generate cloud-style Ubuntu VMs quickly on Linux, macOS, and Windows.

It gives you a simple but powerful CLI that allows you to quickly access an Ubuntu command line or create your own local mini-cloud.

Local development and testing is a pain, but Multipass makes it easier by automating all of your setup and teardown. Multipass has a growing library of images that give you the ability to launch purpose-built VMs, or custom VMs you’ve configured yourself through its powerful cloud-init interface.

Developers can use Multipass to prototype cloud deployments and to create fresh, customized Linux dev environments on any machine. Mac and Windows users can use Multipass as the quickest way to get an Ubuntu command line on their system. New Ubuntu users can use it as a sandbox to try new things without affecting their host machine, and without the need to dual boot.
