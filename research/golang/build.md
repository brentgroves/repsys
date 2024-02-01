# Go build

## references

<https://pkg.go.dev/go/build>
<https://pkg.go.dev/cmd/go#hdr-Build_constraints>

## Go env

```bash
go env
GO111MODULE=""
GOARCH="amd64"
GOBIN=""
GOCACHE="/home/brent/.cache/go-build"
GOENV="/home/brent/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/home/brent/go/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/home/brent/go"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/home/brent/sdk/go1.20"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/home/brent/sdk/go1.20/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/home/brent/src/hackernews/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1283635725=/tmp/go-build -gno-record-gcc-switches"

```

## Package build gathers information about Go packages

### Go Path

go env GOPATH
GOPATH="/home/brent/go"

The Go path is a list of directory trees containing Go source code. It is consulted to resolve imports that cannot be found in the standard Go tree. The default path is the value of the GOPATH environment variable, interpreted as a path list appropriate to the operating system (on Unix, the variable is a colon-separated string; on Windows, a semicolon-separated string; on Plan 9, a list).

Each directory listed in the Go path must have a prescribed structure:

The src/ directory holds source code. The path below 'src' determines the import path or executable name.

The pkg/ directory holds installed package objects. As in the Go tree, each target operating system and architecture pair has its own subdirectory of pkg (pkg/GOOS_GOARCH).

If DIR is a directory listed in the Go path, a package with source in DIR/src/foo/bar can be imported as "foo/bar" and has its compiled form installed to "DIR/pkg/GOOS_GOARCH/foo/bar.a" (or, for gccgo, "DIR/pkg/gccgo/foo/libbar.a").

The bin/ directory holds compiled commands. Each command is named for its source directory, but only using the final element, not the entire path. That is, the command with source in DIR/src/foo/quux is installed into DIR/bin/quux, not DIR/bin/foo/quux. The foo/ is stripped so that you can add DIR/bin to your PATH to get at the installed commands.

Here's an example directory layout:

GOPATH=/home/user/gocode

/home/user/gocode/
    src/
        foo/
            bar/               (go code in package bar)
                x.go
            quux/              (go code in package main)
                y.go
    bin/
        quux                   (installed command)
    pkg/
        linux_amd64/
            foo/
                bar.a          (installed package object)

## **[Build Constraints](https://pkg.go.dev/cmd/go#hdr-Build_constraints)**

A build constraint, also known as a build tag, is a condition under which a file should be included in the package. Build constraints are given by a line comment that begins

//go:build
Build constraints may also be part of a file's name (for example, source_windows.go will only be included if the target operating system is windows).

See 'go help buildconstraint' (<https://golang.org/cmd/go/#hdr-Build_constraints>) for details.

Constraints may appear in any kind of source file (not just Go), but they must appear near the top of the file, preceded only by blank lines and other line comments. These rules mean that in Go files a build constraint must appear before the package clause.

To distinguish build constraints from package documentation, a build constraint should be followed by a blank line.

A build constraint comment is evaluated as an expression containing build tags combined by ||, &&, and ! operators and parentheses. Operators have the same meaning as in Go.

For example, the following build constraint constrains a file to build when the "linux" and "386" constraints are satisfied, or when "darwin" is satisfied and "cgo" is not:

//go:build (linux && 386) || (darwin && !cgo)

It is an error for a file to have more than one //go:build line.

During a particular build, the following build tags are satisfied:

- the target operating system, as spelled by runtime.GOOS, set with the GOOS environment variable.
- the target architecture, as spelled by runtime.GOARCH, set with the GOARCH environment variable.
any architecture features, in the form GOARCH.feature (for example, "amd64.v2"), as detailed below.
"unix", if GOOS is a Unix or Unix-like system.
- the compiler being used, either "gc" or "gccgo"
"cgo", if the cgo command is supported (see CGO_ENABLED in 'go help environment').
- a term for each Go major release, through the current version: "go1.1" from Go version 1.1 onward, "go1.12" from Go 1.12, and so on.
- any additional tags given by the -tags flag (see 'go help build').

There are no separate build tags for beta or minor releases.

If a file's name, after stripping the extension and a possible _test suffix, matches any of the following patterns:

*_GOOS
*_GOARCH
*_GOOS_GOARCH
(example: source_windows_amd64.go) where GOOS and GOARCH represent any known operating system and architecture values respectively, then the file is considered to have an implicit build constraint requiring those terms (in addition to any explicit constraints in the file).

Using GOOS=android matches build tags and files as for GOOS=linux in addition to android tags and files.

Using GOOS=illumos matches build tags and files as for GOOS=solaris in addition to illumos tags and files.

Using GOOS=ios matches build tags and files as for GOOS=darwin in addition to ios tags and files.

The defined architecture feature build tags are:

For GOARCH=386, GO386=387 and GO386=sse2 set the 386.387 and 386.sse2 build tags, respectively.
For GOARCH=amd64, GOAMD64=v1, v2, and v3 correspond to the amd64.v1, amd64.v2, and amd64.v3 feature build tags.
For GOARCH=arm, GOARM=5, 6, and 7 correspond to the arm.5, arm.6, and arm.7 feature build tags.
For GOARCH=mips or mipsle, GOMIPS=hardfloat and softfloat correspond to the mips.hardfloat and mips.softfloat (or mipsle.hardfloat and mipsle.softfloat) feature build tags.
For GOARCH=mips64 or mips64le, GOMIPS64=hardfloat and softfloat correspond to the mips64.hardfloat and mips64.softfloat (or mips64le.hardfloat and mips64le.softfloat) feature build tags.
For GOARCH=ppc64 or ppc64le, GOPPC64=power8, power9, and power10 correspond to the ppc64.power8, ppc64.power9, and ppc64.power10 (or ppc64le.power8, ppc64le.power9, and ppc64le.power10) feature build tags.
For GOARCH=wasm, GOWASM=satconv and signext correspond to the wasm.satconv and wasm.signext feature build tags.
For GOARCH=amd64, arm, ppc64, and ppc64le, a particular feature level sets the feature build tags for all previous levels as well. For example, GOAMD64=v2 sets the amd64.v1 and amd64.v2 feature flags. This ensures that code making use of v2 features continues to compile when, say, GOAMD64=v4 is introduced. Code handling the absence of a particular feature level should use a negation:

//go:build !amd64.v2
To keep a file from being considered for any build:

//go:build ignore

(Any other unsatisfied word will work as well, but "ignore" is conventional.)

To build a file only when using cgo, and only on Linux and OS X:

//go:build cgo && (linux || darwin)
Such a file is usually paired with another file implementing the default functionality for other systems, which in this case would carry the constraint:

//go:build !(cgo && (linux || darwin))
Naming a file dns_windows.go will cause it to be included only when building the package for Windows; similarly, math_386.s will be included only when building the package for 32-bit x86.

Go versions 1.16 and earlier used a different syntax for build constraints, with a "// +build" prefix. The gofmt command will add an equivalent //go:build constraint when encountering the older syntax.
