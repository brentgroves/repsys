# Go workspaces

## references

<https://go.dev/doc/tutorial/workspaces>

## Create the workspace

In this step, we’ll create a go.work file to specify a workspace with the module.

Initialize the workspace
In the workspace directory, run:

```bash
go work init ./hello
```

The go work init command tells go to create a go.work file for a workspace containing the modules in the ./hello directory.

The go command produces a go.work file that looks like this:

```go
go 1.18

use ./hello
```

The go.work file has similar syntax to go.mod.

The go directive tells Go which version of Go the file should be interpreted with. It’s similar to the go directive in the go.mod file.

The use directive tells Go that the module in the hello directory should be main modules when doing a build.

So in any subdirectory of workspace the module will be active.

Run the program in the workspace directory
In the workspace directory, run:

Add the module to the workspace

The Git repo was just checked out into ./example. The source code for the golang.org/x/example/hello module is in ./example/hello. Add it to the workspace:

```go
// must create a go.mod file before adding dir to go.work 
go mod init fileserver 
go work use ./example/hello
```

The go work use command adds a new module to the go.work file. It will now look like this:

```go
go 1.18

use (
    ./hello
    ./example/hello
)
```
