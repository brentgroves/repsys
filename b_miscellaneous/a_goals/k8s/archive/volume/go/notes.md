# packages

<https://thenewstack.io/understanding-golang-packages/>

Package Main
When you build reusable pieces of code, you will develop a package as a shared library. But when you develop executable programs, you will use the package “main” for making the package as an executable program. The package “main” tells the Go compiler that the package should compile as an executable program instead of a shared library. The main function in the package “main” will be the entry point of our executable program. When you build shared libraries, you will not have any main package and main function in the package.

Install Third-Party Packages
We can download and install third-party Go packages by using “Go get” command. The Go get command will fetch the packages from the source repository and put the packages on the GOPATH location.

Init Function
When you write Go packages, you can provide a function “init” that will be called at the beginning of the execution time. The init method can be used for adding initialization logic into the package.

We can use alias names for packages to avoid package name ambiguity.

# create a module to call

<https://go.dev/doc/tutorial/create-module>
Create a greetings directory for your Go module source code.
For example, from your home directory use the following commands:
pushd /home/brent/src/reports/volume/go
<https://go.dev/doc/modules/managing-dependencies#naming_module>

# create a repo with a readme and clone it

git clone github.com/brentgroves/greetings
cd greetings

# init module

go mod init github.com/brentgroves/greetings
The go mod init command creates a go.mod file to track your code's dependencies. So far, the file includes only the name of your module and the Go version your code supports. But as you add dependencies, the go.mod file will list the versions your code depends on. This keeps builds reproducible and gives you direct control over which module versions to use.
In your text editor, create a file in which to write your code and call it greetings.go.
Paste the following code into your greetings.go file and save the file.
package greetings

import "fmt"

// Hello returns a greeting for the named person.
func Hello(name string) string {
    // Return a greeting that embeds the name in a message.
    message := fmt.Sprintf("Hi, %v. Welcome!", name)
    return message
}

# check in the code

git add -A
git commit -m "added code"
git push origin main

This is the first code for your module. It returns a greeting to any caller that asks for one. You'll write code that calls this function in the next step.

In this code, you:
Declare a greetings package to collect related functions.
Implement a Hello function to return the greeting.
This function takes a name parameter whose type is string. The function also returns a string. In Go, a function whose name starts with a capital letter can be called by a function not in the same package. This is known in Go as an exported name. For more about exported names, see Exported names in the Go tour.

Declare a message variable to hold your greeting.
In Go, the := operator is a shortcut for declaring and initializing a variable in one line (Go uses the value on the right to determine the variable's type). Taking the long way, you might have written this as:

var message string
message = fmt.Sprintf("Hi, %v. Welcome!", name)
Use the fmt package's Sprintf function to create a greeting message. The first argument is a format string, and Sprintf substitutes the name
parameter's value for the %v format verb. Inserting the value of the name parameter completes the greeting text.
Return the formatted greeting text to the caller.

# create a repo for the calling module with a readme and clone it

pushd /home/brent/src/reports/volume/go
git clone github.com/brentgroves/hello
cd hello

# init module

go mod init github.com/brentgroves/hello
go: creating new go.mod: module github.com/brentgroves/hello

# call module code

<https://go.dev/doc/tutorial/call-module-code>

should have both a hello and a greetings directory at the same level in the hierarchy, like so:

~/src/reports/volume/go/
 |-- greetings/
 |-- hello/

go to <https://pkg.go.dev/>
search for quote.
notice the one we want rsc.io/quote

In your text editor, in the hello directory, create a file in which to write your code and call it hello.go.
Write code to call the Hello function, then print the function's return value.

To do that, paste the following code into hello.go.

package main

import (
    "fmt"

    "github.com/brentgroves/greetings"

    "rsc.io/quote"
)

func main() {
    fmt.Println(quote.Go())
    // Get a greeting message and print it.
    message := greetings.Hello("Gladys")
    fmt.Println(message)
}

<https://stackoverflow.com/questions/59154942/versioned-import-in-go-using-modules-fails>
The used versions are recorded in the go.mod file.

# this gets the latest version

go get rsc.io/quote

# this gets a specific version

go get rsc.io/quote@v1.5.2

# check in the code

git add -A
git commit -m "added code"
git push origin main

# create a workspace file of all the go modules

this helps the tooling and vscode to keep track of all your modules
<https://go.dev/doc/tutorial/workspaces>
pushd ~/src/reports
go work init ./volume/go/hello
go work use ./volume/go/greetings  
go work use ./volume/go/replib

# cant add other main packages

go work use ./volume/go/channels/simple  

# run main

pushd /home/brent/src/reports/volume/go/hello
go run .

# debug program

add configuration if not already in launch.json
    {
      "name": "Go: Launch hello",
      "type": "go",
      "request": "launch",
      "mode": "debug",
      "program": "${file}"
    },
open hello.go and set a breakpoint and run the debugger.

# build binary

<https://www.digitalocean.com/community/tutorials/how-to-build-and-install-go-programs>
go build
ls
./hello
Don't communicate by sharing memory, share memory by communicating.
Hi, Gladys. Welcome!

# rename it and change location

go build -o bin/hello

# install your program

The go install command behaves almost identically to go build, but instead of leaving the executable in the current directory, or a directory specified by the -o flag, it places the executable into the $GOPATH/bin directory.

To find where your $GOPATH directory is located, run the following command:

go env GOPATH
/home/brent/go

go install
ls
the hello file was delete
ls ~/go/bin
hello
