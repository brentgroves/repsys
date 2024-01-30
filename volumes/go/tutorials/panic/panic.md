# panic

## references

<https://levelup.gitconnected.com/golang-understanding-panic-with-examples-34add963bb41>

## Golang: Understanding Panic with examples

InGolang, panic is a built-in function that can be used to halt the normal execution of a program when an unexpected error occurs. It works like an exception, where a panic can be triggered at any point during program execution, causing the program to stop immediately and unwind the stack. When a panic is triggered, any functions that were in the middle of execution are terminated, and their deferred functions are executed before the program stops.

## Consider the following example

```go
func divide(a, b int) int {
    if b == 0 {
        panic("Divide by zero")
    }
    return a / b
}

func main() {
    fmt.Println(divide(10, 0))
    fmt.Println("This line will never execute")
}
```

In this example, we have defined a divide function that takes two integers as arguments and returns their quotient. However, the function panics if the second argument is zero. In the main function, we call divide with the arguments 10 and 0, which triggers a panic. The program stops immediately, and the line “This line will never execute” is never executed.

## Why Use Panic?

Panic is a powerful tool that should be used sparingly and only in exceptional circumstances. Panicking is generally used when there is an unrecoverable error, such as:

- a missing file within program
- network connection failure
- or a critical security flaw.

In these situations, the program cannot continue safely, so it’s better to panic and terminate the program than to continue executing with a vulnerability.

Consider the following example:

```golang
func loadConfig() {
    if _, err := os.Stat("config.toml"); os.IsNotExist(err) {
        panic("Config file not found")
    }
    // Load config here
}

func main() {
    loadConfig()
    // Continue executing program
}
```

os.Stat
Returns a FileInfo structure describing a file or directory.

<https://www.includehelp.com/golang/os-isnotexist-function-with-examples.aspx>

os.IsNotExist()
In the Go language, the os package provides a platform-independent interface to operating system (Unix-like) functionality. The IsNotExist() function is an inbuilt function of the os package, it is used to check whether the given error is known to report that a file or directory does not exist. The IsNotExist() function is satisfied by ErrExist as well as some syscall errors. This function predates errors.Is.

It accepts one parameter (err error) and returns a boolean indicating whether the error is known to report that a file or directory does not exist.

In this example, we have defined a loadConfig function that checks whether a configuration file exists. If the file does not exist, the function panics with the message “Config file not found”. In the main function, we call loadConfig, which triggers a panic if the file is not found. This ensures that the program cannot continue executing without a valid configuration file.

## How to Use Panic?

In Golang, you can trigger a panic by calling the panic function. The panic function takes an argument of any type, which is used as the panic value. Here is an example:

func main() {
    panic("Something went wrong")
}

In this example, the program will panic and stop immediately with the message “Something went wrong”.

## Recovering from Panic

When a panic is triggered, the Golang runtime starts unwinding the stack and executing deferred functions. However, if a deferred function calls the built-in recover function, the panic is stopped, and the program continues executing normally. The recover function returns the panic value that was passed to the panic function.

Consider the following example:

```go
func connect() error {
    // Attempt to connect to server
    if err != nil {
        panic(err)
    }
    return nil
}

func main() {
    defer func() {
        if r := recover(); r != nil {
            fmt.Println("Recovered from panic:", r)
        }
    }()
    err := connect()
    if err != nil {
        fmt.Println("Error connecting to server:", err)
    }
    // Continue executing program
}
```

In this example, we have defined a connect function that attempts to connect to a server. If the connection fails, the function panics with the error message. In the main function, we use a deferred function to recover from the panic. The deferred function calls the recover function, which stops the panic and returns the error value that was passed to the panic function. If the connect function panics, the deferred function will print a message indicating that the program recovered from the panic.

## Return and handle an error

<https://go.dev/doc/tutorial/handle-errors>

Handling errors is an essential feature of solid code. In this section, you'll add a bit of code to return an error from the greetings module, then handle it in the caller.

In greetings/greetings.go, add the code highlighted below.
There's no sense sending a greeting back if you don't know who to greet. Return an error to the caller if the name is empty. Copy the following code into greetings.go and save the file.

```go
package greetings

import (
    "errors"
    "fmt"
)

// Hello returns a greeting for the named person.
func Hello(name string) (string, error) {
    // If no name was given, return an error with a message.
    if name == "" {
        return "", errors.New("empty name")
    }

    // If a name was received, return a value that embeds the name
    // in a greeting message.
    message := fmt.Sprintf("Hi, %v. Welcome!", name)
    return message, nil
}
```
