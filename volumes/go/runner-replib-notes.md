# create replib

## create replib repo with a license and readme and clone it

```bash
pushd ~/src/repsys/volumes/go
git clone git@github.com:brentgroves/replib.git 
cd replib
```

## init module

go mod init github.com/brentgroves/replib
go: creating new go.mod: module github.com/brentgroves/replib
go: to add module requirements and sums:
        go mod tidy
The go mod init command creates a go.mod file to track your code's dependencies. So far, the file includes only the name of your module and the Go version your code supports. But as you add dependencies, the go.mod file will list the versions your code depends on. This keeps builds reproducible and gives you direct control over which module versions to use.

mkdir trlbal
cd trlbal
In your text editor, create a file in which to write your code and call it hello.go
Paste the following code into your hello.go file and save the file.
package trlbal

import "fmt"

// Hello returns a greeting for the named person.
func Hello(name string) string {
    // Return a greeting that embeds the name in a message.
    message := fmt.Sprintf("Hi, %v. Welcome!", name)
    return message
}

cd ..
mkdir mtbf
cd mtbf
In your text editor, create a file in which to write your code and call it hello.go
Paste the following code into your hello.go file and save the file.
package mtbf

import "fmt"

// Hello returns a greeting for the named person.
func Hello(name string) string {
    // Return a greeting that embeds the name in a message.
    message := fmt.Sprintf("Hi, %v. Welcome!", name)
    return message
}

## Add config.go

config.go this is the first code file we're examining; it contains a single trivial function [1]:

```go
package replib

func Config() string {
  return "replib config"
}
```

The most important part here is the package replib. Since this file is at the top level of the module, its package name is considered to be the module name.

## check in the code

```bash
pushd ~/src/repsys/volumes/go/replib
git add -A
git commit -m "added code"
git push origin main

git remote -v
origin  git@github.com:brentgroves/replib (fetch)
origin  git@github.com:brentgroves/replib (push)

```

## add replib submodule to the repsys repo

```bash
pushd ~/src/repsys
git submodule add git@github.com:brentgroves/replib volumes/go/replib
```

## add replib module to go.work

<https://go.dev/doc/tutorial/workspaces>
This tutorial introduces the basics of multi-module workspaces in Go. With multi-module workspaces, you can tell the Go command that you’re writing code in multiple modules at the same time and easily build and run code in those modules.

```bash
pushd ~/src/repsys
go work init ./volumes/go/replib
# git rm -r --cached volumes/go/runner
```

## create the report system runner repo with a license and readme and clone it

```bash
pushd ~/src/repsys/volumes/go
git clone git@github.com:brentgroves/runner.git
cd runner
```

## init runner module

go mod init github.com/brentgroves/runner
go: creating new go.mod: module github.com/brentgroves/runner
go: to add module requirements and sums:
        go mod tidy

## Add runner config.go

config.go this is the first code file we're examining; it contains a single trivial function [1]:

```go
package runner

func Config() string {
  return "runner config"
}
```

The most important part here is the package runner. Since this file is at the top level of the module, its package name is considered to be the module name.

## Add runner main.go

```bash
mkdir main
cd main
code main.go
```

```go
package main

import (
    "fmt"

    "github.com/brentgroves/replib"

    "rsc.io/quote"
)

func main() {
    fmt.Println(quote.Go())
    // Get a greeting message and print it.
    message := greetings.Hello("Gladys")
    fmt.Println(message)
}
```

## check in runner code

```bash
pushd /home/brent/src/repsys/volumes/go/runner
git add -A
git commit -m "added code"
git push origin main

```

## add runner as a submodule

```bash
pushd ~/src/reports
git submodule add git@github.com:brentgroves/runner volumes/go/runner
```

## add runner module to go.work

```bash
pushd ~/src/repsys
go work use ./volumes/go/runner
# git rm -r --cached volumes/go/runner
```

## tidy runner go.mod

open go.mod
click run go mod tidy

## run main

pushd ~/src/reports/volume/go/runner
go run main/main.go

## debug program

add configuration if not already in launch.json
    {
      "name": "Go: Launch hello",
      "type": "go",
      "request": "launch",
      "mode": "debug",
      "program": "${file}"
    },
open main.go and set a breakpoint and run the debugger.

## build binary

<https://www.digitalocean.com/community/tutorials/how-to-build-and-install-go-programs>

## build runner

cd main
go build -o ../bin/runner
../bin/runner

## install your program

The go install command behaves almost identically to go build, but instead of leaving the executable in the current directory, or a directory specified by the -o flag, it places the executable into the $GOPATH/bin directory. Unfortunately the binary is called main.

To find where your $GOPATH directory is located, run the following command:

go env GOPATH
/home/brent/go

we can run below commands to generate binary executable with the desired name and path:
optional if you want dep to be downloaded and installed
go install
// installs main instead of runner so do 2 extra steps.
go build -o ~/go/bin/runner
rm ~/go/bin/main

## tutorial from web

<https://go.dev/doc/tutorial/getting-started>
go version go1.20 linux/amd64
cd /home/brent/src/reports/volume/go
mkdir hello
cd hello

# enable dependancy tracking

go mod init example/hello

# create a file hello.go in which to write your code

Paste the following code into your hello.go file and save the file.

package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
This is your Go code. In this code, you:

Declare a main package (a package is a way to group functions, and it's made up of all the files in the same directory).
Import the popular fmt package, which contains functions for formatting text, including printing to the console. This package is one of the standard library packages you got when you installed Go.
Implement a main function to print a message to the console. A main function executes by default when you run the main package.
Run your code to see the greeting.

$ go run .
Hello, World!

# Call code in an external package

Make your printed message a little more interesting with a function from an external module.
Visit pkg.go.dev and search for a "quote" package.
Locate and click the rsc.io/quote package in search results (if you see rsc.io/quote/v3, ignore it for now).
In the Documentation section, under Index, note the list of functions you can call from your code. You'll use the Go function.
At the top of this page, note that package quote is included in the rsc.io/quote module.
You can use the pkg.go.dev site to find published modules whose packages have functions you can use in your own code. Packages are published in modules -- like rsc.io/quote -- where others can use them. Modules are improved with new versions over time, and you can

# upgrade your code to use the improved versions

package main

import "fmt"

import "rsc.io/quote"

func main() {
    fmt.Println(quote.Go())
}

# Add new module requirements and sums

Go will add the quote module as a requirement, as well as a go.sum file for use in authenticating the module. For more, see Authenticating modules in the Go Modules Reference.

$ go mod tidy
go: finding module for package rsc.io/quote
go: found rsc.io/quote in rsc.io/quote v1.5.2

# Run your code to see the message generated by the function you're calling

$ go run .
Don't communicate by sharing memory, share memory by communicating.
Notice that your code calls the Go function, printing a clever message about communication.

When you ran go mod tidy, it located and downloaded the rsc.io/quote module that contains the package you imported. By default, it downloaded the latest version -- v1.5.2.
