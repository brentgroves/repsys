# **[Project Structure](https://blog.golang.org/using-go-modules)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[package import](https://stackoverflow.com/questions/17539407/how-to-import-local-packages-without-gopath)**

## **[import local and external packages](https://stackoverflow.com/questions/17539407/how-to-import-local-packages-without-gopath)**

Since the introduction of go.mod , I think both local and external package management becomes easier. Using go.mod, it is possible to have go project outside the GOPATH as well.

## Import local package

Create a folder demoproject and run following command to generate go.mod file

```bash
go mod init demoproject
```

I have a project structure like below inside the demoproject directory.

├── go.mod
└── src
    ├── main.go
    └── model
        └── model.go

For the demo purpose, insert the following code in the model.go file.

```go
package model

type Employee struct {
    Id          int32
    FirstName   string
    LastName    string
    BadgeNumber int32
}
```

In main.go, I imported Employee model by referencing to "demoproject/src/model"

```go
package main

import (
    "demoproject/src/model"
    "fmt"
)

func main() {
    fmt.Printf("Main Function")

    var employee = model.Employee{
        Id:          1,
        FirstName:   "First name",
        LastName:    "Last Name",
        BadgeNumber: 1000,
    }
    fmt.Printf(employee.FirstName)
}
```
