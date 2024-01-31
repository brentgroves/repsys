# Go Tooling

## references

<https://www.jvt.me/posts/2022/06/15/go-tools-dependency-management/>

<https://www.alexedwards.net/blog/an-overview-of-go-tooling>

## Managing your Go tool versions with go.mod and a tools.go

<https://www.jvt.me/posts/2022/06/15/go-tools-dependency-management/>

![](https://media.jvt.me/b41202acf7.png)

Table of Contents

- Makefile
- go.mod
- Performance

When working with Go codebases, it's likely that you'll be delegating some functionality out to helper tools to make your life easier.

For instance, you may be generating code with mockgen or oapi-codegen, or linting your project with golangci-lint.

Something that's recommended on the **[Wiki](https://github.com/golang/go/wiki/Modules#how-can-i-track-tool-dependencies-for-a-module)** and that I've seen across a few projects is the idea of a tools.go.

As explained in more depth in **[Manage Go tools via Go modules](https://marcofranssen.nl/manage-go-tools-via-go-modules)**, this gives you a central place to look for + manage dependencies.

However, this, and the example in the wiki fall down on is that it doesn't work super well 😅

If we take the example project, we receive an error if we don't pre-install the stringer command.

```bash
$ go get
$ go generate
painkiller.go:5: running "stringer": exec: "stringer": executable file not found in $PATH
```

This isn't super helpful, as it requires we do some work up-front to get the commands prepared. This means new developers, as well as automated build environments, need to have done some work to get started, which may not even be consistent across repositories.

So what are our options for managing this better, and making it easier to get started?

Makefile
One approach is to have a Makefile task that allows you to parse the tools.go and install those dependencies, but it's a little awkward, and I tend to try and avoid parsing complex text with things like sed or awk.

This approach isn't ideal, and leads to another command needing to execute before we get started, as well as depending on an arguably brittle text parsing approach.

go.mod
Alternatively, because we've already got the dependencies and their versions pinned in our go.mod, through the declaration in the tools.go, we can actually get rid of the Makefile magic.

To do this explicitly, we'd create a tools.go with the following in it:

```go
//go:build tools
// +build tools

package main

import (
 _ "golang.org/x/tools/cmd/stringer"
)
```

Thanks to this **[comment on GitHub](https://github.com/golang/go/issues/25922#issuecomment-1065971260)**, we can replace our invocations of the command-line application with a go run invocation on the package, like so:

```go
-//go:generate stringer -type=Pill
+//go:generate go run golang.org/x/tools/cmd/stringer -type=Pill
```

This is true whether they're in a Makefile, a standalone script, or in our code.

This gives us the benefit of being purely managed through our go.mod, meaning we can get tools like Dependabot to manage our dependency updates for us, too!

Performance
Note that there is a slight performance hit here, as go run does not cache the built binary, at least as of Go 1.20. There is a proposal to track tool dependencies in go.mod, which additionally discusses allowing caching for go runs for the purpose of build tooling.

In my experience, the performance hit is negligible, but if you're not seeing the same, you can look at how to go install via the go.mod.

## An Overview of Go's Tooling

<https://www.alexedwards.net/blog/an-overview-of-go-tooling>

Published on: April 15th, 2019
Occasionally I get asked “why do you like using Go?” And one of the things I often mention is the thoughtful tooling that exists alongside the language as part of the go command. There are some tools that I use everyday — like go fmt and go build — and others like go tool pprof that I only use to help solve a specific issue. But in all cases I appreciate the fact that they make managing and maintaining my projects easier.

In this post I hope to provide a little background and context about the tools I find most useful, and importantly, explain how they can fit into the workflow of a typical project. I hope it'll give you a good start if you're new to Go.

Or if you've been working with Go for a while, and that stuff's not applicable to you, hopefully you'll still discover a command or flag that you didn't know existed before 😊

The information in this post is written for Go 1.12 and assumes that you're working on a project which has modules enabled.

## Viewing Environment Information

You can use the go env tool to display information about your current Go operating environment. This can be particularly useful if you're working on an unfamiliar machine.

To show documentation for all go env variables and values you can run:

```bash
go help environment
```

## Development

Running Code
During development the go run tool is a convenient way to try out your code. It's essentially a shortcut that compiles your code, creates an executable binary in your /tmp directory, and then runs this binary in one step.

```bash
$ go run .          # Run the package in the current directory
$ go run ./cmd/foo  # Run the package in the ./cmd/foo directory
Note: As of Go 1.11 you can pass the path of a package to go run, like we have above. This means that you no longer have to use workarounds like go run *.go wildcard expansion to run multiple files. I like this improvement a lot!

## Execute Go tools without the need to install them

go run github.com/99designs/gqlgen generate
```

## Fetching Dependencies

Assuming that you've got modules enabled, when you use go run (or go test or go build for that matter) any external dependencies will automatically (and recursively) be downloaded to fulfill the import statements in your code. By default the latest tagged release of the dependency will be downloaded, or if no tagged releases are available, then the dependency at the latest commit.

If you know in advance that you need a specific version of a dependency (instead of the one that Go would fetch by default) you can use go get with the relevant version number or commit hash. For example:

```bash
$ go get github.com/foo/bar@v1.2.3
$ go get github.com/foo/bar@8e1b8d3

# If the dependency being fetched has a go.mod file, then its dependencies won't be listed in your go.mod file. In contrast, if the dependency you're downloading doesn't have a go.mod file, then it's dependencies will be listed in your go.mod file with an // indirect comment next to them.

# So that means your go.mod file doesn't necessarily show all the dependencies for your project in one place. Instead, you can view them all using the go list tool like so:

$ go list -m all
```

## go generate

At the top of our resolver.go, between package and import, add the following line:

//go:generate go run github.com/99designs/gqlgen generate
This magic comment tells go generate what command to run when we want to regenerate our code. To run go generate recursively over your entire project, use this command:

go generate ./...
