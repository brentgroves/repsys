# Embedding Lua in Go

Jul 22, 2015
Command line parameters, environment variables, and configuration files are common ways to change the behavior of software. However, sometimes that is just not enough and an embedded language can be the solution. In this case we will embed Lua using gopher-lua.

## references

https://otm.github.io/2015/07/embedding-lua-in-go/

Godoc: http://godoc.org/github.com/yuin/gopher-lua

All code in the post can be found at http://github.com/otm/embedding-lua-in-go

## Running Lua Code in Go

First lets set up the environment and test that it works, start by install gopher-lua:

go get github.com/yuin/gopher-lua
Secondly let’s create a minimal implementation:

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