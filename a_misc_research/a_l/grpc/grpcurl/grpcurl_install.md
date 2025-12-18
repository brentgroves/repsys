# **[gRPCurl](https://github.com/fullstorydev/grpcurl)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Install

## From Source

If you already have the Go SDK installed, you can use the go tool to install grpcurl:

```bash
go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
```

This installs the command into the bin sub-folder of wherever your $GOPATH environment variable points. (If you have no GOPATH environment variable set, the default install location is $HOME/go/bin). If this directory is already in your $PATH, then you should be good to go.

If you have already pulled down this repo to a location that is not in your $GOPATH and want to build from the sources, you can cd into the repo and then run make install.

If you encounter compile errors and are using a version of the Go SDK older than 1.13, you could have out-dated versions of grpcurl's dependencies. You can update the dependencies by running make updatedeps. Or, if you are using Go 1.11 or 1.12, you can add GO111MODULE=on as a prefix to the commands above, which will also build using the right versions of dependencies (vs. whatever you may already have in your GOPATH).
