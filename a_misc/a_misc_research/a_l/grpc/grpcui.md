# **[grpcui](https://github.com/fullstorydev/grpcui)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Install

## From Source

If you already have the Go SDK installed, you can use the go tool to install grpcurl:

```bash
go install github.com/fullstorydev/grpcui/cmd/grpcui@latest
```

This installs the command into the bin sub-folder of wherever your $GOPATH environment variable points. (If you have no GOPATH environment variable set, the default install location is $HOME/go/bin). If this directory is already in your $PATH, then you should be good to go.

If you have already pulled down this repo to a location that is not in your $GOPATH and want to build from the sources, you can cd into the repo and then run make install.

If you encounter compile errors and are using a version of the Go SDK older than 1.13, you could have out-dated versions of grpcurl's dependencies. You can update the dependencies by running make updatedeps. Or, if you are using Go 1.11 or 1.12, you can add GO111MODULE=on as a prefix to the commands above, which will also build using the right versions of dependencies (vs. whatever you may already have in your GOPATH).

## Usage

The usage doc for the tool explains the numerous options:

```bash
grpcui -help
```

Most of the flags control how the program connects to the gRPC server that to which requests will be sent. However, there is one flag that controls grpcui itself: the -port flag controls what port the HTTP server should use to expose the web UI. If no port is specified, an ephemeral port will be used (so likely a different port each time it is run, allocated by the operating system).

## Web Form

When you run grpcui, it will show you a URL to put into a browser in order to access the web UI.

```bash
$ grpcui -plaintext localhost:12345
gRPC Web UI available at http://127.0.0.1:60551/...
```

When you navigate to this URL, you are presented with the user interface:

The top two listboxes allow you to select the service and method of the RPC to issue. Once a selection is made, the panel below will show a form that allows you to define an RPC request. The form is constructed, dynamically, based on the actual request message structure of the selected RPC.

You'll notice a second tab that lets you view (and edit) the raw JSON value for the request data. This can be useful to copy+paste a large request message, without having to point-and-click to define each field value, one at a time.

The third tab shows the response data. This tab is grayed out and disabled until you actually click the "Invoke" button, which can be found at the bottom of the page.
