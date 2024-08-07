# Go generate

## references

<https://go.dev/blog/generate>

## Generating code

Rob Pike
22 December 2014

A property of universal computation—Turing completeness—is that a computer program can write a computer program. This is a powerful idea that is not appreciated as often as it might be, even though it happens frequently. It’s a big part of the definition of a compiler, for instance. It’s also how the go test command works: it scans the packages to be tested, writes out a Go program containing a test harness customized for the package, and then compiles and runs it. Modern computers are so fast this expensive-sounding sequence can complete in a fraction of a second.

There are lots of other examples of programs that write programs. Yacc, for instance, reads in a description of a grammar and writes out a program to parse that grammar. The protocol buffer “compiler” reads an interface description and emits structure definitions, methods, and other support code. Configuration tools of all sorts work like this too, examining metadata or the environment and emitting scaffolding customized to the local state.

Programs that write programs are therefore important elements in software engineering, but programs like Yacc that produce source code need to be integrated into the build process so their output can be compiled. When an external build tool like Make is being used, this is usually easy to do. But in Go, whose go tool gets all necessary build information from the Go source, there is a problem. There is simply no mechanism to run Yacc from the go tool alone.

Until now, that is.

The latest Go release, 1.4, includes a new command that makes it easier to run such tools. It’s called go generate, and it works by scanning for special comments in Go source code that identify general commands to run. It’s important to understand that go generate is not part of go build. It contains no dependency analysis and must be run explicitly before running go build. It is intended to be used by the author of the Go package, not its clients.

The go generate command is easy to use. As a warmup, here’s how to use it to generate a Yacc grammar.

First, install Go’s Yacc tool:

go get golang.org/x/tools/cmd/goyacc

Say you have a Yacc input file called gopher.y that defines a grammar for your new language. To produce the Go source file implementing the grammar, you would normally invoke the command like this:

goyacc -o gopher.go -p parser gopher.y
The -o option names the output file while -p specifies the package name.

To have go generate drive the process, in any one of the regular (non-generated) .go files in the same directory, add this comment anywhere in the file:

//go:generate goyacc -o gopher.go -p parser gopher.y

This text is just the command above prefixed by a special comment recognized by go generate. The comment must start at the beginning of the line and have no spaces between the // and the go:generate. After that marker, the rest of the line specifies a command for go generate to run.

Now run it. Change to the source directory and run go generate, then go build and so on:

$ cd $GOPATH/myrepo/gopher
$ go generate
$ go build
$ go test
That’s it. Assuming there are no errors, the go generate command will invoke yacc to create gopher.go, at which point the directory holds the full set of Go source files, so we can build, test, and work normally. Every time gopher.y is modified, just rerun go generate to regenerate the parser.

For more details about how go generate works, including options, environment variables, and so on, see the design document.
