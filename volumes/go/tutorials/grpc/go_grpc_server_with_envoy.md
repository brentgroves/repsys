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
go mod init
touch main.go
# add code to main
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/grpc/go-grpc-server-with-envoy
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

## Step 2: Create a Protobuf Definition

Define your service and messages using Protocol Buffers (Protobuf). Create a .proto file inside the “proto” folder, e.g., UserInfo.proto, and define your service and message types:

```bash
mkdir ~/src/repsys/volumes/go/tutorials/go_react_envoy/go-grpc-server-with-envoy/proto
cd ~/src/repsys/volumes/go/tutorials/go_react_envoy/go-grpc-server-with-envoy/proto
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
# Install protoc
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
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

 "github.com/digvijay17july/golang-projects/go-grpc-react-example/go-grpc-server-with-envoy/app/proto"
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
