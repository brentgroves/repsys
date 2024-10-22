# **[Call your code from another module](https://go.dev/doc/tutorial/call-module-code)**

In the previous section, you created a greetings module. In this section, you'll write code to make calls to the Hello function in the module you just wrote. You'll write code you can execute as an application, and which calls code in the greetings module.

Note: This topic is part of a multi-part tutorial that begins with Create a Go module.

## Create a github repo

Call the repo hello2 and clone it.

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/modules/
git clone git@github.com:brentgroves/hello3.git
cd hello2
```

## Create the Go project and **[initialize a module](https://go.dev/ref/mod#go-mod-init)**

If you publish a module, this must be a path from which your module can be downloaded by Go tools. That would be your code's repository.

For more on naming your module with a module path, see Managing dependencies.

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/modules/hello3

# Run go mod init {module name} to create a go.mod file for the current directory. For example go mod init github.com/brutella/dnssd 

go mod init github.com/brentgroves/hello3
go: creating new go.mod: module github.com/brentgroves/hello3
cd ~/src/repsys
go work use ./volumes/go/tutorials/modules/hello3
code go.work 
dirs -v
pushd +x

```

The go mod init command creates a go.mod file to track your code's dependencies. So far, the file includes only the name of your module and the Go version your code supports. But as you add dependencies, the go.mod file will list the versions your code depends on. This keeps builds reproducible and gives you direct control over which module versions to use.

In your text editor, in the hello directory, create a file in which to write your code and call it hello.go.

Write code to call the Hello function, then print the function's return value.

```go
package main

import (
    "fmt"

    "github.com/brentgroves/greetings3"
)

func main() {
    // Get a greeting message and print it.
    message := greetings.Hello("Gladys")
    fmt.Println(message)
}
```

In this code, you:

- Declare a main package. In Go, code executed as an application must be in a main package.
- Import two packages: github.com/brentgroves/greetings2 and the fmt package. This gives your code access to functions in those packages. Importing github.com/brentgroves/greetings2 (the package contained in the module you created earlier) gives you access to the Hello function. You also import fmt, with functions for handling input and output text (such as printing text to the console).
- Get a greeting by calling the greetings package’s Hello function.

## Production add dependancy from github published module

```bash
cd ~/src/repsys/volumes/go/tutorials/modules/hello3
go get github.com/brentgroves/greetings3@v0.1.0
go: downloading github.com/brentgroves/greetings3 v0.1.0
go: added github.com/brentgroves/greetings3 v0.1.0

# verify dependancy was added
code go.mod
# require github.com/brentgroves/greetings3 v0.1.0 // indirect
```

At the command prompt in the hello directory, run your code to confirm that it works.

```bash
go run .
Hi, Gladys. Welcome!
```

## Development change go.mod to access ../greetings3

- Edit the github.com/brentgroves/hello2 module to use your local github.com/brentgroves/greetings2 module.
For production use, you’d publish the github.com/brentgroves/greetings2 module from its repository (with a module path that reflected its published location), where Go tools could find it to download it. For now, because you haven't published the module yet, you need to adapt the github.com/brentgroves/hello2 module so it can find the github.com/brentgroves/greetings2 code on your local file system.

To do that, use the **[go mod edit](https://go.dev/ref/mod#go-mod-edit)** command to edit the github.com/brentgroves/hello2 module to redirect Go tools from its module path (where the module isn't) to the local directory (where it is).

```bash
go mod edit -replace github.com/brentgroves/greetings3=../greetings3
```

The command specifies that github.com/brentgroves/greetings2 should be replaced with ../greetings2 for the purpose of locating the dependency. After you run the command, the go.mod file in the hello2 directory should include a replace directive:

```go
module example.com/hello

go 1.16

replace github.com/brentgroves/greetings3 => ../greetings3
```

From the command prompt in the hello2 directory, run the ```go mod tidy``` command to synchronize the github.com/brentgroves/hello2 module's dependencies, adding those required by the code, but not yet tracked in the module.

```bash
go mod tidy
go: found github.com/brentgroves/greetings3 in github.com/brentgroves/greetings3 v0.0.0-00010101000000-000000000000
```

After the command completes, the github.com/brentgroves/hello2 module's go.mod file should look like this:

```go
module github.com/brentgroves/hello1

go 1.16

replace github.com/brentgroves/greetings2 => ../greetings2

require github.com/brentgroves/greetings2 v0.0.0-00010101000000-000000000000
```

The command found the local code in the greetings directory, then added a require directive to specify that github.com/brentgroves/hello2 requires github.com/brentgroves/greetings2. You created this dependency when you imported the greetings package in hello.go.

The number following the module path is a pseudo-version number -- a generated number used in place of a semantic version number (which the module doesn't have yet).

To reference a published module, a go.mod file would typically omit the replace directive and use a require directive with a tagged version number at the end.
