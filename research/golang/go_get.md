# go **[get](https://pkg.go.dev/cmd/go)**

## references

<https://go.dev/ref/mod#go-get>

## Add dependencies to current module and install them

Add dependencies to current module and install them
Usage:

```bash
go get [-d] [-t] [-u] [build flags] [packages]
Examples:

# Upgrade a specific module.
$ go get golang.org/x/net

# Upgrade modules that provide packages imported by packages in the main module.
$ go get -u ./...

# Upgrade or downgrade to a specific version of a module.
$ go get golang.org/x/text@v0.3.2

# Update to the commit on the module's master branch.
$ go get golang.org/x/text@master

# Remove a dependency on a module and downgrade modules that require it
# to versions that don't require it.
$ go get golang.org/x/text@none

# Upgrade the minimum required Go version for the main module.
$ go get go

# Upgrade the suggested Go toolchain, leaving the minimum Go version alone.
$ go get toolchain

# Upgrade to the latest patch release of the suggested Go toolchain.
$ go get toolchain@patch
```

The go get command updates module dependencies in the go.mod file for the main module, then builds and installs packages listed on the command line.

The first step is to determine which modules to update. go get accepts a list of packages, package patterns, and module paths as arguments. If a package argument is specified, go get updates the module that provides the package. If a package pattern is specified (for example, all or a path with a ... wildcard), go get expands the pattern to a set of packages, then updates the modules that provide the packages. If an argument names a module but not a package (for example, the module golang.org/x/net has no package in its root directory), go get will update the module but will not build a package. If no arguments are specified, go get acts as if . were specified (the package in the current directory); this may be used together with the -u flag to update modules that provide imported packages.

Each argument may include a version query suffix indicating the desired version, as in go get golang.org/x/text@v0.3.0. A version query suffix consists of an @ symbol followed by a version query, which may indicate a specific version (v0.3.0), a version prefix (v0.3), a branch or tag name (master), a revision (1234abcd), or one of the special queries latest, upgrade, patch, or none. If no version is given, go get uses the @upgrade query.

Once go get has resolved its arguments to specific modules and versions, go get will add, change, or remove require directives in the main module’s go.mod file to ensure the modules remain at the desired versions in the future. Note that required versions in go.mod files are minimum versions and may be increased automatically as new dependencies are added. See Minimal version selection (MVS) for details on how versions are selected and conflicts are resolved by module-aware commands.

Other modules may be upgraded when a module named on the command line is added, upgraded, or downgraded if the new version of the named module requires other modules at higher versions. For example, suppose module example.com/a is upgraded to version v1.5.0, and that version requires module example.com/b at version v1.2.0. If module example.com/b is currently required at version v1.1.0, go get example.com/a@v1.5.0 will also upgrade example.com/b to v1.2.0.

![](https://go.dev/doc/mvs/get-upgrade.svg)

Other modules may be downgraded when a module named on the command line is downgraded or removed. To continue the above example, suppose module example.com/b is downgraded to v1.1.0. Module example.com/a would also be downgraded to a version that requires example.com/b at version v1.1.0 or lower.

![](https://go.dev/doc/mvs/get-downgrade.svg)

A module requirement may be removed using the version suffix @none. This is a special kind of downgrade. Modules that depend on the removed module will be downgraded or removed as needed. A module requirement may be removed even if one or more of its packages are imported by packages in the main module. In this case, the next build command may add a new module requirement.

If a module is needed at two different versions (specified explicitly in command line arguments or to satisfy upgrades and downgrades), go get will report an error.

After go get has selected a new set of versions, it checks whether any newly selected module versions or any modules providing packages named on the command line are retracted or deprecated. go get prints a warning for each retracted version or deprecated module it finds. go list -m -u all may be used to check for retractions and deprecations in all dependencies.

After go get updates the go.mod file, it builds the packages named on the command line. Executables will be installed in the directory named by the GOBIN environment variable, which defaults to $GOPATH/bin or $HOME/go/bin if the GOPATH environment variable is not set.

```bash
# Vendoring
# When using modules, the go command typically satisfies dependencies by downloading modules from their sources into the module cache, then loading packages from those downloaded copies. Vendoring may be used to allow interoperation with older versions of Go, or to ensure that all files used for a build are stored in a single file tree.


# In the Go programming language, a module is a collection of related packages that can be versioned and shared with other developers. The modules' packages are organized in a directory hierarchy, and the module itself is defined by a file called go.mod in the module's root directory.

# go get supports the following flags:

# The -d flag tells go get not to build or install packages. When -d is used, go get will only manage dependencies in go.mod. Using go get without -d to build and install packages is deprecated (as of Go 1.17). In Go 1.18, -d will always be enabled.
# The -u flag tells go get to upgrade modules providing packages imported directly or indirectly by packages named on the command line. Each module selected by -u will be upgraded to its latest version unless it is already required at a higher version (a pre-release).
# The -u=patch flag (not -u patch) also tells go get to upgrade dependencies, but go get will upgrade each dependency to the latest patch version (similar to the @patch version query).
# The -t flag tells go get to consider modules needed to build tests of packages named on the command line. When -t and -u are used together, go get will update test dependencies as well.
# The -insecure flag should no longer be used. It permits go get to resolve custom import paths and fetch from repositories and module proxies using insecure schemes such as HTTP. The GOINSECURE environment variable provides more fine-grained control and should be used instead.

```
