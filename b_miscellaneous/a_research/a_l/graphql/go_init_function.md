# Go init

## references

<https://tutorialedge.net/golang/the-go-init-function/>

## Go init function

There are times, when creating applications in Go, that you need to be able to set up some form of state on the initial startup of your program. This could involve creating connections to databases, or loading in configuration from locally stored configuration files.

In this tutorial, we’ll be looking at how you can use this init() function to achieve this goal and we’ll also be taking a look at why this might not necessarily be the best approach to instantiating your components.

## Alternative Approaches

Now, the typical use-case for using the init function might go along the lines of “I want to instantiate a connection to the database”. However, this might actually be a side-effect of poor design within you Go applications.

A better approach to instantiating things like database connections might instead be to use a New function that returns a pointer to a struct containing your database connection object.

```go
func New() (*Database, error) {
    conn, err := sql.Open("postgres", "connectionURI")
    if err != nil {
        return &Database{}, err
    }
    return &Database{
        Connection: conn,
    }, nil
}
```

With this approach, you would then be able to pass in your database to any other components in your system that may need to call the database.

It also gives you more control over how you handle failures during startup as opposed to simply terminating your application.

Overall, I would try and generally avoid using the init function where possible and use the approach outlined above to build your Go applications.

## The init Function

In Go, the init() function can be incredibly powerful and compared to some other languages, is a lot easier to use within your Go programs. These init() functions can be used within a package block and regardless of how many times that package is imported, the init() function will only be called once.

Now, the fact that it is only called once is something you should pay close attention to. This effectively allows us to set up database connections, or register with various service registries, or perform any number of other tasks that you typically only want to do once.

```go
package main

func init() {
  fmt.Println("This will get called on main initialization")
}

func main() {
  fmt.Println("My Wonderful Go Program")
}

```

Notice in this above example, we’ve not explicitly called the init() function anywhere within our program. Go handles the execution for us implicitly and thus the above program should provide output that looks like this:

```bash
$ go run test.go
This will get called on main initialization
My Wonderful Go Program
```

so with this working, we can start to do cool things such as variable initialization.

```go
package main

import "fmt"

var name string

func init() {
    fmt.Println("This will get called on main initialization")
    name = "Elliot"
}

func main() {
    fmt.Println("My Wonderful Go Program")
    fmt.Printf("Name: %s\n", name)
}
```

In this example, we can start to see why using the init() function would be preferential when compared to having to explicitly call your own setup functions.

When we run the above program, you should see that our name variable has been properly set and whilst it’s not the most useful variable on the planet, we can certainly still use it throughout our Go program.

```bash
$ go run test.go
This will get called on main initialization
My Wonderful Go Program
Name: Elliot
```

## Multiple Packages

Let’s have a look at a more complex scenario that is closer to what you’d expect in a production Go system. Imagine we had 4 distinct Go packages within our application, main, broker, and database.

In each of these we could specify an init() function which would perform the task of setting up the connection pool to the various 3rd party services such as Kafka or MySQL.

Whenever we then call a function in our database package, it would then use the connection pool that we set up in our init() function.

Note - It’s incredibly important to note that you cannot rely upon the order of execution of your init() functions. It’s instead better to focus on writing your systems in such a way that the order does not matter.

## Order of Initialization

For more complex systems, you may have more than one file making up any given package. Each of these files may indeed have their own init() functions present within them. So how does Go order the initialization of these packages?

When it comes to the order of the initialization, a few things are taken into consideration. Things in Go are typically initialized in the order in declaration order but explicitly after any variables they may depend on. This means that, should you have 2 files a.go and b.go in the same package, if the initialization of anything in a.go depends on things in b.go they will be initialized first.

Note - A more in-depth overview of the order of initialization in Go can be found in the official docs: Package Initialization

The key point to note from this is this order of declaration can lead to scenarios such as this:

```go
// source: https://stackoverflow.com/questions/24790175/when-is-the-init-function-run
var WhatIsThe = AnswerToLife()

func AnswerToLife() int {
    return 42
}

func init() {
    WhatIsThe = 0
}

func main() {
    if WhatIsThe == 0 {
        fmt.Println("It's all a lie.")
    }
}
```

In this scenario, you’ll see that AnswerToLife() will run before our init() function as our WhatIsThe variable is declared before our init() function is called.

## Multiple Init Functions in the Same File

What happens if we have multiple init() functions within the same Go file? At first I didn’t think this was possible, but Go does indeed support having 2 separate init() functions within the one file.

These init() functions are again called in their respective order of declaration within the file:

```go
package main

import "fmt"

// this variable is initialized first due to
// order of declaration
var initCounter int

func init() {
    fmt.Println("Called First in Order of Declaration")
    initCounter++
}

func init() {
    fmt.Println("Called second in order of declaration")
    initCounter++
}

func main() {
    fmt.Println("Does nothing of any significance")
    fmt.Printf("Init Counter: %d\n", initCounter)
}

```

Now, when you run the above program, you should see the output look like so:

```bash
$ go run test.go
Called First in Order of Declaration
Called second in order of declaration
Does nothing of any significance
Init Counter: 2
```

Pretty cool, huh? But what is this for? Why do we allow this? Well, for more complex systems, it allows us to break up complex initialization procedures into multiple, easier-to-digest init() functions. It essentially allows us to avoid having one monolithic code block in a single init() function which is always a good thing. The one caveat of this style is that you will have to take care when ensuring declaration order.

While other answers described it completely, for "Show me The Code" people, this basically means: create package-level variables and execute the init function of that package.

And (if any) the hierarchy of package-level variables & init functions of packages that, this package has imported.

The only side effect that a package can make, without being actually called, is by creating package-level variables (public or private) and inside it's init function.

Note: There is a trick to run a function before even init function. We can use package-level variables for this by initializing them using that function.

```go
func theVeryFirstFunction() int {
    log.Println("theVeryFirstFunction")
    return 6
}

var (
    Num = theVeryFirstFunction()
)

func init() { log.Println("init", Num) }
```

Conclusion
So this concludes the basic introduction to the world of init() functions. Once you’ve mastered the use of the package initialization, you may find it useful to master the art of structuring your Go based projects.

If you have any further questions or feedback, then please feel free to let me know in the comments section below!
