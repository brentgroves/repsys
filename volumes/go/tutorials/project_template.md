# **[Project Template](https://gobyexample.com/hello-world)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## Creating a project for repsys repo

```bash
pushd .
mkdir ~/src/repsys/volumes/go/tutorials/helloworld
cd ~/src/repsys/volumes/go/tutorials/helloworld
go mod init
touch main.go
# add code to main
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/helloworld
dirs -v
pushd +(count from end)
```

Our first program will print the classic “hello world” message. Here’s the full source code.

To run the program, put the code in helloworld.go and use go run.

```go
package main
import "fmt"
func main() {
    fmt.Println("hello world")
}```

```bash
go run helloworld.go

// Sometimes we’ll want to build our programs into binaries. We can do this using go build.
go build helloworld.go
ls
helloworld    helloworld.go

// We can then execute the built binary directly.

./helloworld
hello world
```
