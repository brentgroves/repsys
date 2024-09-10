# **[Quick Start](https://grpc.io/docs/languages/go/quickstart/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

This guide gets you started with gRPC in Go with a simple working example.

## Prerequisites

Go, any one of the two latest major releases of Go.

For installation instructions, see Go’s Getting Started guide.
Protocol buffer compiler, protoc, version 3.
For installation instructions, see Protocol Buffer Compiler Installation.
Go plugins for the protocol compiler:
Install the protocol compiler plugins for Go using the following commands:

```bash
$ go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
$ go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
Update your PATH so that the protoc compiler can find the plugins:

$ export PATH="$PATH:$(go env GOPATH)/bin"
```

## Get the example code

The example code is part of the grpc-go repo.

Download the repo as a zip file and unzip it, or clone the repo:

```bash
pushd .
cd ~/src
git clone -b v1.66.0 --depth 1 https://github.com/grpc/grpc-go
```

Change to the quick start example directory:

```bash
cd ~/src/grpc-go/examples/helloworld
```

## Run the example

From the examples/helloworld directory:

Compile and execute the server code:

```bash
cd ~/src/grpc-go/examples/helloworld
go run greeter_server/main.go
```

From a different terminal, compile and execute the client code to see the client output:

```bash
cd ~/src/grpc-go/examples/helloworld
go run greeter_client/main.go
Greeting: Hello world
```

## Congratulations! You’ve just run a client-server application with gRPC

## Update the gRPC service

In this section you’ll update the application with an extra server method. The gRPC service is defined using protocol buffers. To learn more about how to define a service in a .proto file see Basics tutorial. For now, all you need to know is that both the server and the client stub have a SayHello() RPC method that takes a HelloRequest parameter from the client and returns a HelloReply from the server, and that the method is defined like this:

```proto
// The greeting service definition.
service Greeter {
  // Sends a greeting
  rpc SayHello (HelloRequest) returns (HelloReply) {}
}

// The request message containing the user's name.
message HelloRequest {
  string name = 1;
}

// The response message containing the greetings
message HelloReply {
  string message = 1;
}
```
