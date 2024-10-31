# install **[Protobuf](https://www.geeksforgeeks.org/how-to-install-protobuf-on-ubuntu/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

Protocol Buffers, commonly known as Protobuf, is a free, open-source, and cross-platform library developed by Google. It is used for serializing structured data, making it ideal for applications that need to communicate over a network or store data efficiently. Protobuf allows developers to define how they want their data structured using an interface description language (IDL), from which a program generates source code.

This code can then create or parse byte streams that represent the structured data, making data transfer and storage seamless and effective. Initially created for Google’s internal use, Protobuf is now available as an open-source project, supporting multiple programming languages.

## Conclusion

Protobuf is an essential tool for developers looking to optimize data serialization and communication between services or applications. With robust support for multiple programming languages, easy installation on Ubuntu, and a proven track record within Google and beyond, Protobuf offers a superior alternative to traditional data serialization methods like XML and JSON. By learning these two easy methods, one can install Protobuf on Ubuntu efficiently.

```bash
sudo apt install protobuf-compiler
which protoc           
/bin/protoc
# or
/home/brent/anaconda3/bin/protoc

```bash
# Install protoc and golang plugins
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
which protoc-gen-go-grpc      
/home/brent/go/bin/protoc-gen-go-grpc
which protoc-gen-go     
/bin/protoc-gen-go
protoc ./proto/userInfo.proto --go_out=. --go-grpc_out=.
# this command creates app/proto/*.go files
```

```
