# gglgen

## references

<https://github.com/99designs/gqlgen>

## What is gqlgen

gqlgen is a Go library for building GraphQL servers without any fuss.

gqlgen is based on a Schema first approach — You get to Define your API using the GraphQL Schema Definition Language.
gqlgen prioritizes Type safety — You should never see map[string]interface{} here.
gqlgen enables Codegen — We generate the boring bits, so you can focus on building your app quickly.

Still not convinced enough to use gqlgen? Compare gqlgen with other Go graphql **[implementations](https://gqlgen.com/feature-comparison/)**

## Quick start

1. Initialise a new go module

```bash
mkdir example
cd example
go mod init example
```

2.Add github.com/99designs/gqlgen to your project's tools.go

printf '// +build tools\npackage tools\nimport (_"github.com/99designs/gqlgen"\n_ "github.com/99designs/gqlgen/graphql/introspection")' | gofmt > tools.go

go mod tidy

```go
//go:build tools
// +build tools

package tools

import (
        _ "github.com/99designs/gqlgen"
        _ "github.com/99designs/gqlgen/graphql/introspection"
)

```

What does an underscore in front of an import statement mean?

It's for importing a package solely for its side-effects.
From the Go Specification:

To import a package solely for its side-effects (initialization), use the blank identifier as explicit package name:

import _ "lib/math"

In sqlite3
In the case of go-sqlite3, the underscore import is used for the side-effect of registering the sqlite3 driver as a database driver in the init() function, without importing any other functions:

sql.Register("sqlite3", &SQLiteDriver{})

Once it's registered in this way, sqlite3 can be used with the standard library's sql interface in your code like in the example:

db, err := sql.Open("sqlite3", "./foo.db")

3.Initialise gqlgen config and generate models

```bash
go run github.com/99designs/gqlgen init

go mod tidy
```
