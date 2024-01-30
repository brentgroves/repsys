# Tool dependancy

## references

<https://play-with-go.dev/tools-as-dependencies_go119_en/>

## Developer tools as module dependencies

By Jon Calhoun, creator of Gophercises and other Go courses and learning material.

Go modules support developer tools (commands) as dependencies. For example, your project might require a tool to help with code generation, or to lint/vet your code for correctness. Adding developer tool dependencies ensures that all developers use the same version of each tool.

This guide shows you how to manage developer tool dependencies with a Go module, specifically the code generator stringer.

You will:

- create a module that contains a main package (your “project” for this guide)
- add the stringer tool as a dependency
- use stringer via a go:generate directive

Prerequisites
You should already have completed:

Go Fundamentals
This guide is running using:

$ go version
go version go1.19.1 linux/amd64

Why stringer?
Let’s motivate the use of stringer by getting started on your project. Your project will be a simple command line application that gives advice on what painkillers to take for certain ailments. So let’s name your module accordingly:

```bash
$ mkdir painkiller
$ cd painkiller
$ go mod init painkiller
go: creating new go.mod: module painkiller

```

Start with a basic version of your application. Given that you are writing a command line application, you need to declare a main package; do so in a file named painkiller.go:

```go
package main

import "fmt"

type Pill int

const (
 Placebo Pill = iota
 Ibuprofen
)

func main() {
 fmt.Printf("For headaches, take %v\n", Ibuprofen)
}
```

This first version of your app provides some basic advice on what to take for headaches. Using integer types provides a nice convenient way to define a sequence of constant values. Here you define the type Pill.

Run the program to see its output:

$ go run .
For headaches, take 1

Hmm, that’s not particularly user friendly. The integer value of your constant is meaningless to your user.

You can improve this by making the Pill type implement the fmt.Stringer interface:

```go
type Stringer interface {
 String() string
}
```

The String() method defines the “native” format for a value.

Update your example to define a String() method on Pill:

```go
package main

import "fmt"

type Pill int

func (p Pill) String() string {
 switch p {
 case Placebo:
  return "Placebo"
 case Ibuprofen:
  return "Ibuprofen"
 default:
  panic(fmt.Errorf("unknown Pill value %v", p))
 }
}

const (
 Placebo Pill = iota
 Ibuprofen
)

func main() {
 fmt.Printf("For headaches, take %v\n", Ibuprofen)
}
```

**[Iota](https://www.gopherguides.com/articles/how-to-use-iota-in-golang)** is a useful concept for creating incrementing constants in Go. However, there are several areas where iota may not be appropriate to use. This article will cover several different ways in which you can use iota, and tips on where to be cautious with it's use.

Run the program to see the new output:

$ go run .
For headaches, take Ibuprofen

That’s better. But as you can see there is a lot of repetition in your String() method. Adding more constants will mean more manual, robotic effort… not to mention being error prone. Can we do better? Enter stringer.

stringer is a tool to automate the creation of methods that satisfy the fmt.Stringer interface. Given the name of an (signed or unsigned) integer type T that has constants defined, stringer will create a new self-contained Go source file implementing:

func (t T) String() string
This sounds much better than maintaining a definition by hand, so let’s add stringer as a dependency.

But before you do, remove the hand-written String() method:

```go
package main

import "fmt"

type Pill int

const (
 Placebo Pill = iota
 Ibuprofen
)

func main() {
 fmt.Printf("For headaches, take %v\n", Ibuprofen)
}
```

## Adding tool dependencies

Go modules establishes a convention for tool dependencies. You simply import the command as you would any other package, but do so in a special file that is ignored by any of the go build commands. Again, by convention, these imports are declared in a file called tools.go at the root of your module:

```go
// +build tools

package tools

import (
 _ "golang.org/x/tools/cmd/stringer"
)
```

In this code you:

- Declare a build constraint on the first line of tools.go. This tells the go command to only consider this file when the tools build tag is provided. By convention, tools is used as the constraint name.
- Declare that tools.go belongs to the tools package. Because this file is going to be ignored by go build commands, it actually doesn’t matter what package it belongs to. But again, by convention, it is generally considered good practice to use tools as the package name.
- Import golang.org/x/tools/cmd/stringer, which declares a dependency relation between your main package and stringer. But hang on a minute: isn’t stringer a command, and therefore a main package itself? How does this work? Again, because this file is going to be ignore by go build commands the fact that you are importing a main package doesn’t actually matter. You are only importing golang.org/x/tools/cmd/stringer to declare the dependency on that package. And because you don’t use the imported golang.org/x/tools/cmd/stringer package, the blank identifier _ is used to signal the import exists solely for its side effects, in this case the declaration of the dependency.

<https://go.googlesource.com/proposal/+/master/design/draft-gobuild.md>

With the package dependency declared, you can now add a dependency on the module that contains golang.org/x/tools/cmd/stringer. Use go get to add a dependency:

$ go get golang.org/x/tools/cmd/stringer@v0.1.13-0.20220917004541-4d18923f060e
go: downloading golang.org/x/tools v0.1.13-0.20220917004541-4d18923f060e
go: downloading golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f
go: downloading golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4
go: added golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4
go: added golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f
go: added golang.org/x/tools v0.1.13-0.20220917004541-4d18923f060e

You can see your new dependency in the project’s go.mod file:

```bash
$ cat go.mod
module painkiller

go 1.19

require (
 golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4 // indirect
 golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f // indirect
 golang.org/x/tools v0.1.13-0.20220917004541-4d18923f060e // indirect
)
```

This guide uses a specific version of stringer so as to remain reproducible. In a real-world project you would almost certainly omit the version to get the latest version, or explicitly use the special version @latest. Alternatively, you could simply run go mod tidy instead of go get:

$ go mod tidy

Run stringer to see how it should be invoked:

```bash
$ go run golang.org/x/tools/cmd/stringer -help
Usage of stringer:
 stringer [flags] -type T [directory]
 stringer [flags] -type T files... # Must be a single package
For more information, see:
 <https://pkg.go.dev/golang.org/x/tools/cmd/stringer>
Flags:
  -linecomment
     use line comment text as printed text when present
  -output string
     output file name; default srcdir/<type>_string.go
  -tags string
     comma-separated list of build tags to apply
  -trimprefix prefix
     trim the prefix from the generated constant names
  -type string
     comma-separated list of type names; must be set
```

As you can see, Pill must be passed as an argument to the -type flag:

$ go run golang.org/x/tools/cmd/stringer -type Pill
Listing the directory contents reveals what stringer has generated for us:

$ ls
go.mod go.sum painkiller.go  pill_string.go  tools.go

Examine the contents of the stringer-generated file:

```bash
$ cat pill_string.go
// Code generated by "stringer -type Pill"; DO NOT EDIT.

package main

import "strconv"

func _() {
 // An "invalid array index" compiler error signifies that the constant values have changed.
 // Re-run the stringer command to generate them again.
 var x [1]struct{}
 _ = x[Placebo-0]
 _ = x[Ibuprofen-1]
}

const _Pill_name = "PlaceboIbuprofen"

var _Pill_index = [...]uint8{0, 7, 16}

func (i Pill) String() string {
 if i < 0 || i >= Pill(len(_Pill_index)-1) {
  return "Pill(" + strconv.FormatInt(int64(i), 10) + ")"
 }
 return _Pill_name[_Pill_index[i]:_Pill_index[i+1]]
}
```

Notice the first line of this generated file is a comment warning you against editing it by hand: this “header” is a standard convention of generated files.

Run your program to verify it behaves as expected:

$ go run .
For headaches, take Ibuprofen
Success!

Using stringer via a go:generate directive
It is not fair or realistic to expect your fellow developers to remember the command for re-running stringer. A more scalable approach is to declare a go:generate directive for each code generation step needed for your project:

```go
package main

import "fmt"

//go:generate go run golang.org/x/tools/cmd/stringer -type=Pill

type Pill int

const (
 Placebo Pill = iota
 Ibuprofen
)

func main() {
 fmt.Printf("For headaches, take %v\n", Ibuprofen)
}
```

Now you can re-run all code generation steps (there is currently only one, but still) for current package by running:

$ go generate .

Try this out by extending your program to give another piece of advice:

```go
package main

import "fmt"

//go:generate go run golang.org/x/tools/cmd/stringer -type=Pill

type Pill int

const (
 Placebo Pill = iota
 Ibuprofen
 Paracetamol
)

func main() {
 fmt.Printf("For headaches, take %v\n", Ibuprofen)
 fmt.Printf("For a fever, take %v\n", Paracetamol)
}

```

Re-run your code generation steps:

$ go generate .

Finally, check your program’s output:

$ go run .
For headaches, take Ibuprofen
For a fever, take Paracetamol
Conclusion
That’s it! This guide has shown you how to add tool dependencies to a module, with a focus on the stringer code generation tool and its use via go generate.
