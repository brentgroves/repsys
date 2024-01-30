# Build constraint

## references

<https://www.jetbrains.com/help/go/configuring-build-constraints-and-vendoring.html>

## Build constraints and vendoring

Build constraints and vendoring mode are tools that you can use for fine-tuning of your build process. With build constraints, you define rules under which files are included in the package. With the vendoring mode enabled, you build your application only with dependency packages that are stored inside your project. So, you can include only a specific set of files in your package and use the dependencies that you locally modified or patched.

## Build constraints

According to the Bug-resistant build constraints proposal, //+build will be replaced by //go:build. A transition period from //+build to //go:build syntax will last from Go version 1.16 through version 1.18. In the 1.16 version of Go, you can use either the old syntax or both syntaxes at the same time.

A build constraint or a build tag is a line comment that lists the conditions under which a file is included in the package. These tags can describe an operating system, architecture, a Go version, a compiler, cgo support, or any other requirements for a target system. In the following example, we declare that this file is for the target system that has the following requirements:

//+build darwin,cgo linux is the older syntax for build tags, still recognized in Go. It specifies two sets of conditions:

darwin,cgo: Include in the build when compiling for the darwin platform (macOS) and when cgo is enabled. cgo enables the inclusion of C code in Go programs.

linux: Include when compiling for the Linux platform.

The space acts as an OR operator, meaning the file should be included for macOS with cgo enabled or for Linux.

## newer syntax

//go:build (darwin && cgo) || linux is the newer syntax for build tags, introduced in Go 1.17, using a more explicit boolean expression format:

(darwin && cgo) || linux: The file should be included in the build for macOS with cgo enabled or for Linux, identical to the above condition.

Build constraints
GoLand can use these constraints to decide what files must be ignored during validation, resolving, and symbol suggestions. If the file does not satisfy the requirements of the target system, GoLand displays a notification. For example, the following conditions on the screenshot will conflict with settings from the Configure build constraints for your project procedure.
