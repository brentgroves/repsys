# **[There is nothing Goish about log.Fatal](https://smyrman.medium.com/there-is-nothing-goish-about-log-fatal-4ab24ae5ba7)

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[log fatal](https://smyrman.medium.com/there-is-nothing-goish-about-log-fatal-4ab24ae5ba7)

If “Goish” describes something that’s characteristic for the Go language, log.Fatal is off the wall.

In this article I will use some time to describe what I think are characteristic concepts or features in Go, and I will use some time to motivate why log.Fatal does not belong. Finally I will present what I believe to be a better pattern and I will finish up with how this pattern could be made less verbose and more Goish in Go 2.

## What is “Goish”?

I believe there are a few concepts in Go that are so fundamental that they help define what Go is, or perhaps, what it means to write go.

For the purpose of this article, I will call this notion Goish. To determine what that really is, let’s start by talking around some of the most characteristic Go language keywords.

Let’s start with the most obvious one. The go keyword is designed to allow programmers to rely on easy-to-use **[concurrent execution](https://swtch.com/~rsc/thread/)**. We will not dive into tremendous depths on this one, but together with its underlying scheduler implementation, the go-routine concept and syntax is part of what makes Go good for **[high-throughput](./high_throughput.md)** applications. Put extremely short, we can say that this helps with Go’s simplicity and efficiency.

The **defer** keyword on the other hand, allows for a way to clean things up when a function returns or panics. The recover keyword, when used within a deferred function, helps define **[Go’s error handling paradigm](https://davidnix.io/post/error-handling-in-go/)**. In short, this paradigm separates between normal errors and critical panics. Generally speaking, it leads to explicit error handling on all function that might return an error. On the other side of the coin, it’s made pretty clear that there is no need for error handling for functions that don’t return an error type. Both of these points are in sharp contrast to the Exceptions pattern. All of these concepts are meant to help with Go program’s safety and stability.

Not all features in Go relates to specific keywords or libraries though. A completely different feature that helps define Go, is it’s language level memory safety. Go is garbage collected, which helps prevent memory leaks, and there are only a few ways where you may access **[unsafe memory](https://research.swtch.com/gorace)**. In addition, we got the **[Go Memory Model](https://golang.org/ref/mem)** to define memory synchronization guarantees in a concurrent environment. You could argue that the way these features are implemented, impose **[trade-offs](https://insanitybit.github.io/2016/12/28/golang-and-rustlang-memory-safety)** that helps balance Go’s simplicity and efficiency with reasonable safety and stability.

To sum it up, maybe part of what Goish means, is a feature or construct that helps develop stable and efficient programs easily.

## What is log.Fatal?

With the definitions done, let’s get onto the main subject of this article, and look at log.Fatal. According to the **[documentation](https://golang.org/pkg/log/#Fatal)**, it’s just a shortcut for log.Print(v); os.Exit(1). Remember that **[os.Exit](https://golang.org/pkg/os/#Exit)** exits the go program immediately, without running any defer statements.

This means that log.Fatal (and log.Fatalln) is essentially semantically equivalent to a non-recoverable panic, without a stack-trace, that prevents any deferred functions from running. This doesn’t sound very Goish to me.

## Using log.Fatal in an imported package

This is a nice way of screwing with anyone that might want to use your package, including yourself. As a package author, you must consider that the main package might at some point need to start or open something else that requires a defer function to be run, even if the log.Fatal is just part of some type’s initialization. It would generally be better to panic (and optionally recover), then to use log.Fatal.

PS! Depending on wether it’s a reusable package or not, you might want to consider if it should log anything at all, or how it should be done.

## But it’s OK to use it in the main function, right

Sometimes maybe, but most of the time it’s probably best not to. Consider this main function for instance:

```go
func main() {
    // parse command-line params through flags.Parse into a struct.
    cfg := parseConfig() 
    // Initialize some DB connection.
    session, err := mgo.Dial(cfg.DBURL)
    if err != nil {
        log.Fatal("could not connect to database:", err)
    }
    defer session.Close()
    // Initialize API handler, and serve /api.
    api := newAPIHandler(session.DB())
    http.Handle("/api/", http.StripPrefix("/api/", api))
    log.Fatal(http.ListenAndServe(cfg.SrvAddr, nil))
```

The first log.Fatal is OK, as there is no defer statements queued yet, but the second log.Fatal will prevent the database session from being closed if there is an error returned from ListenAndServe. Unfortunately, the latter line is actually taken from the official go documentation, making it more likely that programmers might do such mistakes in production. You probably shouldn’t useListenAndServe in production btw.

## Who cares about closing a database sessions?

Let’s play the devil’s advocate for a while, and come up with a contradicting statement:

A program might be killed for any reason, so we can’t rely on defer. Therefore, isn’t it acceptable that defers doesn’t always run on fatal errors?

However, consider this; if we didn’t care about it running, why did we care to write it as a deferred statement in the first place? It’s not really about guaranteeing safety, but about increasing it.

I will give a more motivating real-life example for where you really do want your deferred statements to run as often as possible. If you don’t care for this, feel free to jump to the next headline.
