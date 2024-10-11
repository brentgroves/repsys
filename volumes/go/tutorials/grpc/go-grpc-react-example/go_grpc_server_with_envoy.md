# **[Building Scalable Microservices: Creating a GRPC Service with Go and Consuming it in a React App via Envoy](https://medium.com/@digvijay17july/building-scalable-microservices-creating-a-grpc-service-with-go-and-consuming-it-in-a-react-app-1de3c4385c05)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

In today’s blog post, we’ll explore the process of creating a GRPC service using Go and consuming it in a React app with the help of Envoy proxy. GRPC is a high-performance, language-agnostic remote procedure call (RPC) framework, and when combined with Go and Envoy, it becomes a powerful tool for building distributed systems. We’ll walk through each step of the process, from setting up the GRPC service in Go to creating a React app that communicates with it via Envoy.

![goenvoy](https://miro.medium.com/v2/resize:fit:720/format:webp/1*xV7ITojvENF-CMgXE-MJ4w.png)

## Prerequisites

Before we dive into the implementation, make sure you have the following prerequisites installed on your system:

- Go: Install Go from the official website (<https://golang.org/>).
- Node.js and npm: Download and install Node.js from (<https://nodejs.org/>).
- Docker: Install Docker to run the Envoy proxy container (<https://www.docker.com/>).

## Step 1: Creating the GRPC Service in Go

We’ll start by building the GRPC service in Go. Create a new directory for your project and set up the Go environment:

```bash
pushd .
mkdir ~/src/repsys/volumes/go/tutorials/grpc/go-grpc-server-with-envoy
cd ~/src/repsys/volumes/go/tutorials/grpc/go-grpc-server-with-envoy
go mod init go-grpc-server-with-envoy2
touch main.go
# add code to main
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/grpc/go-grpc-react-example/go-grpc-server-with-envoy2/
dirs -v
pushd +(count from end)
```

Now, create a new Go file for your service, e.g., main.go. In this file, define your GRPC service and the methods it exposes. Here's a simplified example:

```go
package main

import (
 "context"
 "log"
 "net"
 "google.golang.org/grpc"
)

// YourService should implement the methods of your GRPC service.
type YourService struct{}

// Implement your GRPC methods here.

func main() {
 listener, err := net.Listen("tcp", ":8080")
 if err != nil {
  log.Fatalf("Failed to listen: %v", err)
 }

 grpcServer := grpc.NewServer()
 // Register your service here.
 
 if err := grpcServer.Serve(listener); err != nil {
  log.Fatalf("Failed to serve: %v", err)
 }
```

## **[Install Protobuf](./protobuf-install.md)**

## Create a Protobuf Definition

Define your service and messages using Protocol Buffers (Protobuf). Create a .proto file inside the “proto” folder, e.g., UserInfo.proto, and define your service and message types:

```bash
mkdir ~/src/repsys/volumes/go/tutorials/grpc/go-grpc-react-example/go-grpc-server-with-envoy2/proto
cd ~/src/repsys/volumes/go/tutorials/grpc/go-grpc-react-example/go-grpc-server-with-envoy2/proto
touch UserInfo.proto

```proto
syntax = "proto3";

package proto;

option go_package = "app/proto";

message User {
    string name = 1;
    int32 age = 2;
    Address address = 3;
    PhoneNumber phone = 4;
    string updated_at = 5; 
    string created_at =6;
}

message Address{
    string street = 1;
    string city = 2;
    string state = 3;
    string zip = 4;
}

message PhoneNumber{
    string primary = 1;
    map<string, string> others = 2;
}


message UserRequest {
    string name = 1;
}

message UserResponse {
    User user = 1;
    int32 status = 2;
    string error = 3;
}
service Usr {
    rpc GetUser (UserRequest) returns (UserResponse) {}
}
```

Compile the .proto file to generate Go code:

```bash
protoc ./proto/userInfo.proto --go_out=. --go-grpc_out=.
# this command creates app/proto/*.go files
```

## Step 3: Implement Your GRPC Service

Implement the GRPC service methods in your main.go file according to the definition in the .proto file.

```go
package main

import (
 "context"
 "log"
 "net"
 "time"
 "go-grpc-server-with-envoy2/app/proto"
//  "github.com/digvijay17july/golang-projects/go-grpc-react-example/go-grpc-server-with-envoy/app/proto"
 "google.golang.org/grpc"
)

type server struct {
 proto.UnimplementedUsrServer
}

func (*server) GetUser(ctx context.Context, in *proto.UserRequest) (*proto.UserResponse, error) {
 
 others := make(map[string]string)
 others["secondary"] = "233453"
 phone := &proto.PhoneNumber{Primary: "1234567890", Others: others}
 user := &proto.User{Name: "Digvijay", Age: 23, Address: &proto.Address{Street: "Pune", City: "Pune", State: "MAHARASHTRA", Zip: "201223"}, Phone: phone, UpdatedAt: time.Now().UTC().String(), CreatedAt: time.Now().UTC().String()}
 return &proto.UserResponse{User: user, Status: 200, Error: ""}, nil
}

func main() {
 lis, err := net.Listen("tcp", ":8080")
 if err != nil {
  log.Fatalf("failed to listen: %v", err)
 }
 s := grpc.NewServer()
 grpcServer := &server{}
 proto.RegisterUsrServer(s, grpcServer)
 log.Printf("Starting server on port :%v", lis.Addr())
 if err := s.Serve(lis); err != nil {
  log.Fatalf("failed to serve: %v", err)
 }

}
```

## Get dependancy

```bash
go get google.golang.org/grpc
go get google.golang.org/protobuf

## Step 4: Building and Running the GRPC Service Docker image

Dockerfile for the Grpc Service app-

```dockerfile
FROM golang:1.21.4-alpine

WORKDIR /app

COPY go.sum ./


COPY . ./

RUN go build -o  /go-grpc-server-with-envoy

EXPOSE 8080

CMD [ "/go-grpc-server-with-envoy" ]
```

## Build the image-

```bash
cd ~/src/repsys/volumes/go/tutorials/grpc/go-grpc-server-with-envoy
docker build -t go-grpc-server-with-envoy2 .
```

## Step 5: Setting up Envoy Proxy-

create an envoy folder which will contain 2 files.

### 1. ./config/envoy.yaml

```yaml
admin:
  address:
    socket_address: { address: 0.0.0.0, port_value: 9901 }
static_resources:
  listeners:
    - name: listener_0
      address:
        socket_address: { address: 0.0.0.0, port_value:  8080 }
      filter_chains:
        - filters:
            - name: envoy.filters.network.http_connection_manager
              typed_config:
                "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
                codec_type: auto
                stat_prefix: ingress_http
                route_config:
                  name: local_route
                  virtual_hosts:
                    - name: local_service
                      domains: ["*"]
                      routes:
                        - match: { prefix: "/"}
                          route: { cluster: grpc_service}
                      cors:
                        allow_origin_string_match:
                          - prefix: "*"
                        allow_methods: GET, PUT, DELETE, POST, OPTIONS
                        allow_headers: keep-alive,user-agent,cache-control,content-type,content-transfer-encoding,custom-header-1,x-accept-content-transfer-encoding,x-accept-response-streaming,x-user-agent,x-grpc-web,grpc-timeout
                        max_age: "1728000"
                        expose_headers: custom-header-1,grpc-status,grpc-message
                http_filters:
                  - name: envoy.filters.http.grpc_web
                    typed_config:
                      "@type": type.googleapis.com/envoy.extensions.filters.http.grpc_web.v3.GrpcWeb
                  - name: envoy.filters.http.cors
                    typed_config:
                      "@type": type.googleapis.com/envoy.extensions.filters.http.cors.v3.Cors
                  - name: envoy.filters.http.router
                    typed_config:
                      "@type": type.googleapis.com/envoy.extensions.filters.http.router.v3.Router
  clusters:
    - name: grpc_service
      connect_timeout: 0.25s
      type: LOGICAL_DNS
      typed_extension_protocol_options:
        envoy.extensions.upstreams.http.v3.HttpProtocolOptions:
          "@type": type.googleapis.com/envoy.extensions.upstreams.http.v3.HttpProtocolOptions
          explicit_http_config:
            http2_protocol_options: {}
      lb_policy: ROUND_ROBIN
      load_assignment:
        cluster_name: grpc_service
        endpoints:
          - lb_endpoints:
              - endpoint:
                  address:
                    socket_address:
                      address: host.docker.internal
                      port_value: 8080
```

### 2. ./config/Dockerfile

```dockerfile
FROM envoyproxy/envoy:v1.28.0
COPY ./envoy.yaml /etc/envoy/envoy.yaml
```

## Step 6: Create a docker-compose.yaml to run the app

To run the backend with envoy proxy-

```bash
docker-compose up
grpcurl -plaintext localhost:8083 Usr/GetUser

```

## **[Add reflection](https://chromium.googlesource.com/external/github.com/grpc/grpc-go/+/HEAD/Documentation/server-reflection-tutorial.md)**

gRPC Server Reflection Tutorial
gRPC Server Reflection provides information about publicly-accessible gRPC services on a server, and assists clients at runtime to construct RPC requests and responses without precompiled service information. It is used by gRPCurl, which can be used to introspect server protos and send/receive test RPCs.

Enable Server Reflection
gRPC-go Server Reflection is implemented in package reflection. To enable server reflection, you need to import this package and register reflection service on your gRPC server.

For example, to enable server reflection in example/helloworld, we need to make the following changes:

```diff
--- a/examples/helloworld/greeter_server/main.go
+++ b/examples/helloworld/greeter_server/main.go
@@ -40,6 +40,7 @@ import (
        "google.golang.org/grpc"
        pb "google.golang.org/grpc/examples/helloworld/helloworld"
+       "google.golang.org/grpc/reflection"
 )

 const (
@@ -61,6 +62,8 @@ func main() {
        }
        s := grpc.NewServer()
        pb.RegisterGreeterService(s, &pb.GreeterService{SayHello: sayHello})
+       // Register reflection service on gRPC server.
+       reflection.Register(s)
        if err := s.Serve(lis); err != nil {
                log.Fatalf("failed to serve: %v", err)
        }
```

An example server with reflection registered can be found at examples/features/reflection/server.
