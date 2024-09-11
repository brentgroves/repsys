# install **[Protobuf](https://www.geeksforgeeks.org/how-to-install-protobuf-on-ubuntu/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

## reference

```bash
sudo apt install protobuf-compiler
which protoc           
/bin/protoc

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
