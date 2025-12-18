<https://www.sohamkamani.com/golang/context/#when-do-we-use-context>

The main use of a context instance is to pass common scoped data within our application. For example:

Request IDs for function calls and goroutines that are part of the same HTTP request
Errors encountered when fetching data from a database
Cancellation signals created when performing async operations using goroutines

**![Contexts](https://www.sohamkamani.com/golang/context/context-in-practice.svg)**

Using the Context type is the idiomatic way to pass information across these kind of operations, such as:

Cancellation and deadline signals to terminate the operation
Miscellaneous data required at every function call invoked by the operation

## Creating a New Context

We can create a new context using the context.Background() function:

ctx := context.Background()
This function returns a new context instance that is empty and has no values associated with it.

In many cases, we won’t be creating a new context instance, but rather using an existing one.

For example, when we’re handling an HTTP request, we can use the http.Request.Context() function to get the request’s context:

// Create an HTTP server that listens on port 8000
http.ListenAndServe(":8010",
  http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
    // Get the request's context
    ctx := r.Context()
    // ...
}))

## Creating a Derived Context

When you receive a context from an external source, you can add your own values and cancellation signals to it by creating a derived context.

We can do this by using a decorator function like context.WithValue, context.WithCancel, or context.WithDeadline:

**![derived context](https://www.sohamkamani.com/golang/context/derived-context.drawio.svg)**

## Context Cancellation Signals

One of the most common use cases of the context package is to propagate cancellation signals across function calls.

Why Do We Need Cancellation?
In short, we need cancellation to prevent our system from doing unnecessary work.

Consider the common situation of an HTTP server making a call to a database, and returning the queried data to the client:

**![client diagram](https://www.sohamkamani.com/golang/context/client-diagram.svg)**

The timing diagram, if everything worked perfectly, would look like this:

**![timing diagram](https://www.sohamkamani.com/golang/context/timing-ideal.svg)**

But, what would happen if the client cancelled the request in the middle? This could happen if, for example, the client closed their browser mid-request.

Without cancellation, the application server and database would continue to do their work, even though the result of that work would be wasted:

Ideally, we would want all downstream components of a process to halt, if we know that the process (in this example, the HTTP request) halted:

**![user request cancelled](https://www.sohamkamani.com/golang/context/timing-with-cancel.svg)**

Now that we know why we need cancellation, let’s get into how you can implement it in Go.

Because “cancellation” is highly contextual to the operation being performed, the best way to implement it is through context.

There are two sides to context cancellation:

Listening for the cancellation signal
Emitting the cancellation signal

Listening For Cancellation Signals
The Context type provides a Done() method. This returns a channel that receives an empty struct{} type every time the context receives a cancellation signal.

So, to listen for a cancellation signal, we need to wait on <- ctx.Done().

For example, lets consider an HTTP server that takes two seconds to process an event. If the request gets cancelled before that, we want to return immediately:

func main() {
 // Create an HTTP server that listens on port 8000
 http.ListenAndServe(":8000", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
  ctx := r.Context()
  // This prints to STDOUT to show that processing has started
  fmt.Fprint(os.Stdout, "processing request\n")
  // We use `select` to execute a piece of code depending on which
  // channel receives a message first
  select {
  case <-time.After(2* time.Second):
   // If we receive a message after 2 seconds
   // that means the request has been processed
   // We then write this as the response
   w.Write([]byte("request processed"))
  case <-ctx.Done():
   // If the request gets cancelled, log it
   // to STDERR
   fmt.Fprint(os.Stderr, "request cancelled\n")
  }
 }))
}

You can view the source code for all the examples on Github
<https://github.com/sohamkamani/golang-examples/tree/main/context>

You can test this by running the server and opening localhost:8000 on your browser. If you close your browser before 2 seconds, you should see “request cancelled” printed on the terminal window.

## Emitting a Cancellation Signal

If you have an operation that could be cancelled, you will have to emit a cancellation signal through the context.

This can be done using the WithCancel function in the context package, which returns a context object, and a function.

ctx, fn := context.WithCancel(ctx)
This function takes no arguments, and does not return anything, and is called when you want to cancel the context.

Consider the case of 2 dependent operations. Here, “dependent” means if one fails, it doesn’t make sense for the other to complete. If we get to know early on that one of the operations failed, we would like to cancel all dependent operations.

## Cancellation Signals with Causes

In the previous example, calling the cancel() function did not provide any information about why the context was cancelled. There are some cases where you might want to know the reason for cancellation.

For example, consider that you have a long running operation that is dependent on a database call. If the database call fails, you want know that the operation was cancelled because of the database failure, and not because of some other reason.

In these cases, we can use the context.WithCancelCause instead. This function returns a context object, and a function that takes an error as an argument.

Let’s see the same example as before, but with the WithCancelCause function:

```go
func operation1(ctx context.Context) error {
 time.Sleep(100 * time.Millisecond)
 return errors.New("failed")
}

func operation2(ctx context.Context) {
 select {
 case <-time.After(500 * time.Millisecond):
  fmt.Println("done")
 case <-ctx.Done():
    // We can get the error from the context
    err := context.Cause(ctx)
  fmt.Println("halted operation2 due to error: ", err)
 }
}

func main() {
 ctx := context.Background()
 ctx, cancel := context.WithCancelCause(ctx)

 go func() {
  err := operation1(ctx)
  if err != nil {
      // this time, we pass in the error as an argument
   cancel(err)
  }
 }()

 // Run operation2 with the same context we use for operation1
 operation2(ctx)
}
```

halted operation2 due to error:  failed
Let’s summarize the error propagation pattern in this example:

The context.WithCancelCause gives us the cancel function, which we can call with an error.
Once we encounter and error, we call the cancel function with the error as an argument.
Now that the context is cancelled, the ctx.Done() channel will receive a message.
We can get the error from the context using the context.Cause function.

## Context Deadlines

If we want to set a deadline for a process to complete, we should use time based cancellation.

The functions are almost the same as the previous example, with a few additions:

// The context will be cancelled after 3 seconds
// If it needs to be cancelled earlier, the `cancel` function can
// be used, like before
ctx, cancel := context.WithTimeout(ctx, 3*time.Second)

// Setting a context deadline is similar to setting a timeout, except
// you specify a time when you want the context to cancel, rather than a duration.
// Here, the context will be cancelled on 2009-11-10 23:00:00
ctx, cancel := context.WithDeadline(ctx, time.Date(2009, time.November, 10, 23, 0, 0, 0, time.UTC))

For example, consider making an HTTP API call to an external service. If the service takes too long, it’s better to fail early and cancel the request:

```go
func main() {
 // Create a new context
 // With a deadline of 100 milliseconds
 ctx := context.Background()
 ctx, _ = context.WithTimeout(ctx, 100*time.Millisecond)

 // Make a request, that will call the google homepage
 req, _ := http.NewRequest(http.MethodGet, "<http://google.com>", nil)
 // Associate the cancellable context we just created to the request
 req = req.WithContext(ctx)

 // Create a new HTTP client and execute the request
 client := &http.Client{}
 res, err := client.Do(req)
 // If the request failed, log to STDOUT
 if err != nil {
  fmt.Println("Request failed:", err)
  return
 }
 // Print the status code if the request succeeds
 fmt.Println("Response received, status code:", res.StatusCode)
}
```

## Canceling database operations after a timeout

<https://go.dev/doc/database/cancel-operations>
You can use a Context to set a timeout or deadline after which an operation will be canceled. To derive a Context with a timeout or deadline, call context.WithTimeout or context.WithDeadline.

Code in the following timeout example derives a Context and passes it into the sql.DB QueryContext method.

```go
func QueryWithTimeout(ctx context.Context) {
    // Create a Context with a timeout.
    queryCtx, cancel := context.WithTimeout(ctx, 5*time.Second)
    defer cancel()

    // Pass the timeout Context with a query.
    rows, err := db.QueryContext(queryCtx, "SELECT * FROM album")
    if err != nil {
        log.Fatal(err)
    }
    defer rows.Close()

    // Handle returned rows.
}

```

When one context is derived from an outer context, as queryCtx is derived from ctx in this example, if the outer context is canceled, then the derived context is automatically canceled as well. For example, in HTTP servers, the http.Request.Context method returns a context associated with the request. That context is canceled if the HTTP client disconnects or cancels the HTTP request (possible in HTTP/2). Passing an HTTP request’s context to QueryWithTimeout above would cause the database query to stop early either if the overall HTTP request was canceled or if the query took more than five seconds.

Note: Always defer a call to the cancel function that’s returned when you create a new Context with a timeout or deadline. This releases resources held by the new Context when the containing function exits. It also cancels queryCtx, but by the time the function returns, nothing should be using queryCtx anymore.

<https://www.sohamkamani.com/golang/context/#google_vignette>

<https://go.dev/doc/tutorial/database-access>
