# **[GoLang OOP](https://www.toptal.com/golang/golang-oop-tutorial)**

## Create a github repo

Call the repo vin1 and clone it.

```bash
pushd .
cd ~/src/go/tutorials/oop/
git clone git@github.com:brentgroves/vin1.git
Cloning into 'vin1'...
remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 4 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (4/4), done.
cd vin1
```

## Create the Go project and **[initialize a module](https://go.dev/ref/mod#go-mod-init)**

If you publish a module, this must be a path from which your module can be downloaded by Go tools. That would be your code's repository.

For more on naming your module with a module path, see Managing dependencies.

```bash
pushd .
cd ~/src/go/tutorials/oop/vin1

# Run go mod init {module name} to create a go.mod file for the current directory. For example go mod init github.com/brutella/dnssd 

go mod init github.com/brentgroves/vin1
go: creating new go.mod: module github.com/brentgroves/vin1

# Add module to go.work so vscode can find it
cd ~/src/go
go work use ./tutorials/oop/vin1
code go.work 
dirs -v
pushd +x
```

The go mod init command creates a go.mod file to track your code's dependencies. So far, the file includes only the name of your module and the Go version your code supports. But as you add dependencies, the go.mod file will list the versions your code depends on. This keeps builds reproducible and gives you direct control over which module versions to use.

## Well-structured Logic: A Golang OOP Tutorial

Can Golang be object-oriented? Go is a post-OOP programming language, however, it can still leverage OOP patterns to structure the code in a clear and understandable way. This tutorial demonstrates how to use Go with OOP concepts, including constructors, subtyping, polymorphism, dependency injection, and testing with mocks.

**[Is Go object-oriented](https://www.toptal.com/golang)**? Can it be? Go (or “Golang”) is a post-OOP programming language that borrows its structure (packages, types, functions) from the Algol/Pascal/Modula language family. Nevertheless, in Go, object-oriented patterns are still useful for structuring a program in a clear and understandable way. This Golang tutorial will take a simple example and demonstrate how to apply the concepts of binding functions to types (aka classes), constructors, subtyping, polymorphism, dependency injection, and testing with mocks.

## Case Study in Golang OOP: Reading the Manufacturer Code from a Vehicle Identification Number (VIN)

The unique **[vehicle identification number](https://en.wikipedia.org/wiki/Vehicle_identification_number)** of every car includes—beside a “running” (i.e., serial) number—information about the car, such as the manufacturer, the producing factory, the car model, and if it is driven from the left- or right-hand side.

A function to determine the manufacturer code might look like this:

```go
package vin

func Manufacturer(vin string) string {

  manufacturer := vin[: 3]
  // if the last digit of the manufacturer ID is a 9
  // the digits 12 to 14 are the second part of the ID
  if manufacturer[2] == '9' {
    manufacturer += vin[11: 14]
  }

  return manufacturer
}
```

## Create a github repo for main app

Call the repo vin_main and clone it.

```bash
pushd .
cd ~/src/go/tutorials/oop/
git clone git@github.com:brentgroves/vin_main.git
Cloning into 'vin_main'...
remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 4 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (4/4), done.
cd vin_main
```

## Create the vin_main Go project and **[initialize a module](https://go.dev/ref/mod#go-mod-init)**

If you publish a module, this must be a path from which your module can be downloaded by Go tools. That would be your code's repository.

For more on naming your module with a module path, see Managing dependencies.

```bash
pushd .
cd ~/src/go/tutorials/oop/vin_main

# Run go mod init {module name} to create a go.mod file for the current directory. For example go mod init github.com/brutella/dnssd 

go mod init github.com/brentgroves/vin_main
go: creating new go.mod: module github.com/brentgroves/vin_main

# Add module to go.work so vscode can find it
cd ~/src/go
go work use ./tutorials/oop/vin_main
code go.work 
dirs -v
pushd +x
```

The go mod init command creates a go.mod file to track your code's dependencies. So far, the file includes only the name of your module and the Go version your code supports. But as you add dependencies, the go.mod file will list the versions your code depends on. This keeps builds reproducible and gives you direct control over which module versions to use.

## **[Commit, test, merge, tag, and publish](commit_test_merge_tag_publish.md)**
