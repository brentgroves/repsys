# **[GoRoutines: Concurrency in Golang](https://www.geeksforgeeks.org/goroutines-concurrency-in-golang/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

Go language provides a special feature known as a Goroutines. A Goroutine is a function or method that executes independently and simultaneously in connection with any other Goroutines in your program. In other words, every concurrently executing activity in the Go language is known as a Goroutines. You can consider a Goroutine like a lightweight thread. The cost of creating Goroutines is minimal as compared to the thread. Every program contains at least a single Goroutine and that Goroutine is known as the main Goroutine. All the Goroutines are working under the main Goroutines if the main Goroutine is terminated, then all the Goroutines in the program are also terminated. Goroutine always works in the background.

## How to create a Goroutine?
You can create your own Goroutine simply by using the go keyword as a prefix to the function or method call as shown in the below syntax:

Syntax:
```go
func name(){
// statements
}

// using go keyword as the 
// prefix of your function call
go name()
```

## Example

```go
// Go program to illustrate
// the concept of Goroutine
package main

import "fmt"

func display(str string) {
    for w := 0; w < 6; w++ {
        fmt.Println(str)
    }
}

func main() {

    // Calling Goroutine
    go display("Welcome")

    // Calling normal function
    display("GeeksforGeeks")
}
```

## Output

```bash
GeeksforGeeks
GeeksforGeeks
GeeksforGeeks
GeeksforGeeks
GeeksforGeeks
GeeksforGeeks
```

In the above example, we simply create a display() function and then call this function in two different ways first one is a Goroutine, i.e. go display(“Welcome”) and another one is a normal function, i.e. display(“GeeksforGeeks”).

But there is a problem, it only displays the result of the normal function that does not display the result of Goroutine because when a new Goroutine executed, the Goroutine call return immediately. The control does not wait for Goroutine to complete their execution just like normal function they always move forward to the next line after the Goroutine call and ignores the value returned by the Goroutine. So, to execute a Goroutine properly, we made some changes in our program as shown in the below code:

## Modified Example:

```go
// Go program to illustrate the concept of Goroutine
package main

import (
    "fmt"
    "time"
)

func display(str string) {
    for w := 0; w < 6; w++ {
        time.Sleep(1 * time.Second)
        fmt.Println(str)
    }
}

func main() {

    // Calling Goroutine
    go display("Welcome")

    // Calling normal function
    display("GeeksforGeeks")
}
```

## Example Output:

```bash
Welcome
GeeksforGeeks
GeeksforGeeks
Welcome
Welcome
GeeksforGeeks
GeeksforGeeks
Welcome
Welcome
GeeksforGeeks
GeeksforGeeks
```

We added the Sleep() method in our program which makes the main Goroutine sleeps for 1 second in between 1-second the new Goroutine executes, displays “welcome“ on the screen, and then terminate after 1-second main Goroutine re-schedule and perform its operation. This process continues until the value of the z<6 after that the main Goroutine terminates. Here, both Goroutine and the normal function work concurrently.

## Advantages of Goroutines

- Goroutines are cheaper than threads.
- Goroutine are stored in the stack and the size of the stack can grow and shrink according to the requirement of the program. But in threads, the size of the stack is fixed.
-Goroutines can communicate using the channel and these channels are specially designed to prevent race conditions when accessing shared memory using Goroutines.
- Suppose a program has one thread, and that thread has many Goroutines associated with it. If any of Goroutine blocks the thread due to resource requirement then all the remaining - Goroutines will assign to a newly created OS thread. All these details are hidden from the programmers.
