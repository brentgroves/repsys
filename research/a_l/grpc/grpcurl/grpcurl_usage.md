# **[gRPCurl usage](https://chromium.googlesource.com/external/github.com/grpc/grpc-go/+/HEAD/Documentation/server-reflection-tutorial.md#grpcurl)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## gRPCurl

After enabling Server Reflection in a server application, you can use gRPCurl to check its services. gRPCurl is built with Go and has packages available. Instructions on how to install and use gRPCurl can be found at **[gRPCurl Installation](https://github.com/fullstorydev/grpcurl#installation)**.

## Use gRPCurl to check services

First, start the helloworld server in grpc-go directory:

```bash
pushd .
cd ~/src/grpc-go/examples
go run features/reflection/server/main.go
output:

server listening at [::]:50051
```

After installing gRPCurl, open a new terminal and run the commands from the new terminal.

**NOTE:** gRPCurl expects a TLS-encrypted connection by default. For all of the commands below, use the -plaintext flag to use an unencrypted connection.

## List services and methods

The list command lists services exposed at a given port:

- List all the services exposed at a given port

```bash
grpcurl -plaintext localhost:50051 list
grpc.examples.echo.Echo
grpc.reflection.v1.ServerReflection
grpc.reflection.v1alpha.ServerReflection
helloworld.Greeter
```

- List all the methods of a service

The list command lists methods given the full service name (in the format of <package>.<service>).

```bash
grpcurl -plaintext localhost:50051 list helloworld.Greeter
helloworld.Greeter.SayHello
```

## Describe services and methods

- Describe all services

The describe command inspects a service given its full name (in the format of <package>.<service>).

```bash
grpcurl -plaintext localhost:50051 describe helloworld.Greeter
helloworld.Greeter is a service:
service Greeter {
  rpc SayHello ( .helloworld.HelloRequest ) returns ( .helloworld.HelloReply );
}
```

- Describe all methods of a service

The describe command inspects a method given its full name (in the format of <package>.<service>.<method>).

```bash
grpcurl -plaintext localhost:50051 describe helloworld.Greeter.SayHello
helloworld.Greeter.SayHello is a method:
rpc SayHello ( .helloworld.HelloRequest ) returns ( .helloworld.HelloReply );
```

- Inspect message types

We can use the describe command to inspect request/response types given the full name of the type (in the format of <package>.<type>).

Get information about the request type

```bash
grpcurl -plaintext localhost:50051 describe helloworld.HelloRequest

helloworld.HelloRequest is a message:
message HelloRequest {
  string name = 1;
}
```

## Call a remote method

We can send RPCs to a server and get responses using the full method name (in the format of <package>.<service>.<method>). The -d <string> flag represents the request data and the -format text flag indicates that the request data is in text format.

- Call a unary method

```bash
grpcurl -plaintext -format text -d 'name: "gRPCurl"' \
  localhost:50051 helloworld.Greeter.SayHello

message: "Hello gRPCurl"

grpcurl -plaintext -format text -d 'name: "gRPCurl"' \
  localhost:8080 proto.Usr.GetUser

user: <
  name: "Digvijay"
  age: 23
  address: <
    street: "Pune"
    city: "Pune"
    state: "MAHARASHTRA"
    zip: "201223"
  >
  phone: <
    primary: "1234567890"
    others: <
      key: "secondary"
      value: "233453"
    >
  >
  updated_at: "2024-10-11 21:05:53.412691491 +0000 UTC"
  created_at: "2024-10-11 21:05:53.412697929 +0000 UTC"
>
status: 200  

```  
