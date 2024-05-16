# **[Testing in Go](https://go.dev/doc/tutorial/add-a-test)**

## Add a test

Now that you've gotten your code to a stable place (nicely done, by the way), add a test. Testing your code during development can expose bugs that find their way in as you make changes. In this topic, you add a test for the Hello function.

Note: This topic is part of a multi-part tutorial that begins with **[Create a Go module](https://go.dev/doc/tutorial/create-module.html)**.

Go's built-in support for unit testing makes it easier to test as you go. Specifically, using naming conventions, Go's testing package, and the go test command, you can quickly write and execute tests.

1. In the greetings directory, create a file called greetings_test.go.
Ending a file's name with_test.go tells the go test command that this file contains test functions.
2. In greetings_test.go, paste the following code and save the file.

```go
package greetings

import (
    "testing"
    "regexp"
)

// TestHelloName calls greetings.Hello with a name, checking
// for a valid return value.
func TestHelloName(t *testing.T) {
    name := "Gladys"
    want := regexp.MustCompile(`\b`+name+`\b`)
    msg, err := Hello("Gladys")
    if !want.MatchString(msg) || err != nil {
        t.Fatalf(`Hello("Gladys") = %q, %v, want match for %#q, nil`, msg, err, want)
    }
}

// TestHelloEmpty calls greetings.Hello with an empty string,
// checking for an error.
func TestHelloEmpty(t *testing.T) {
    msg, err := Hello("")
    if msg != "" || err == nil {
        t.Fatalf(`Hello("") = %q, %v, want "", error`, msg, err)
    }
}
```

In this code, you:

- Implement test functions in the same package as the code you're testing.
- Create two test functions to test the greetings.Hello function. Test function names have the form TestName, where Name says something about the specific test. Also, test functions take a pointer to the testing package's testing.T type as a parameter. You use this parameter's methods for reporting and logging from your test.

- Implement two tests:
  - TestHelloName calls the Hello function, passing a name value with which the function should be able to return a valid response message. If the call returns an error or an unexpected response message (one that doesn't include the name you passed in), you use the t parameter's Fatalf method to print a message to the console and end execution.
  - TestHelloEmpty calls the Hello function with an empty string. This test is designed to confirm that your error handling works. If the call returns a non-empty string or no error, you use the t parameter's Fatalf method to print a message to the console and end execution.

At the command line in the greetings directory, run the go test command to execute the test.
The go test command executes test functions (whose names begin with Test) in test files (whose names end with _test.go). You can add the -v flag to get verbose output that lists all of the tests and their results.

The tests should pass.

```bash
$ go test
PASS
ok      example.com/greetings   0.364s

$ go test -v
=== RUN   TestHelloName
--- PASS: TestHelloName (0.00s)
=== RUN   TestHelloEmpty
--- PASS: TestHelloEmpty (0.00s)
PASS
ok      example.com/greetings   0.372s
```

## **[Type parameters](https://go.dev/tour/generics/1)**

Go functions can be written to work on multiple types using type parameters. The type parameters of a function appear between brackets, before the function's arguments.

```go
func Index[T comparable](s []T, x T) int
```

This declaration means that s is a slice of any type T that fulfills the built-in constraint comparable. x is also a value of the same type

**[comparable](https://go.dev/blog/comparable)**

**[comparable types](https://go.dev/ref/spec#Comparison_operators)**

**[go maps](https://gobyexample.com/maps)**

Maps are Go’s built-in associative data type (sometimes called hashes or dicts in other languages).\
To create an empty map, use the builtin make: make(map[key-type]val-type).

```go
package main

import (
    "fmt"
    "maps"
)

func main() {

    m := make(map[string]int)

    m["k1"] = 7
    m["k2"] = 13

    fmt.Println("map:", m)

    v1 := m["k1"]
    fmt.Println("v1:", v1)

    v3 := m["k3"]
    fmt.Println("v3:", v3)

    fmt.Println("len:", len(m))

    delete(m, "k2")
    fmt.Println("map:", m)

    clear(m)
    fmt.Println("map:", m)

    _, prs := m["k2"]
    fmt.Println("prs:", prs)

    n := map[string]int{"foo": 1, "bar": 2}
    fmt.Println("map:", n)

    n2 := map[string]int{"foo": 1, "bar": 2}
    if maps.Equal(n, n2) {
        fmt.Println("n == n2")
    }
}
```

```bash
$ go run maps.go 
map: map[k1:7 k2:13]
v1: 7
v3: 0
len: 2
map: map[k1:7]
map: map[]
prs: false
map: map[bar:2 foo:1]
n == n2
```
