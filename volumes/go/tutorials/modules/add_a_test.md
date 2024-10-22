# **[Add a test](https://go.dev/doc/tutorial/add-a-test)**

Now that you've gotten your code to a stable place (nicely done, by the way), add a test. Testing your code during development can expose bugs that find their way in as you make changes. In this topic, you add a test for the Hello function.

Note: This topic is part of a multi-part tutorial that begins with Create a Go module.
Go's built-in support for unit testing makes it easier to test as you go. Specifically, using naming conventions, Go's testing package, and the go test command, you can quickly write and execute tests.

## 1. In the greetings3 directory, create a file called greetings_test.go

Ending a file's name with _test.go tells the go test command that this file contains test functions.

## 2. In greetings_test.go, paste the following code and save the file

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
