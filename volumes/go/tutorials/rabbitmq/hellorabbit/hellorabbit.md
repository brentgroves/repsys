# **[Hellorabbit](https://www.rabbitmq.com/tutorials/tutorial-one-go)**

**[Back to Go Tutorial List](../../tutorial_list.md)**\
**[Back to Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../../README.md)**

## references

## Creating the sender

```bash
pushd .
mkdir -p ~/src/repsys/volumes/go/tutorials/rabbitmq/hellorabbit/sender
cd ~/src/repsys/volumes/go/tutorials/rabbitmq/hellorabbit/sender
go mod init sender
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/rabbitmq/hellorabbit/sender
dirs -v
pushd +X # where X is 0 based number from the bottom of dirs -v entries

```

## RabbitMQ tutorial - "Hello World!"

Prerequisites
This tutorial assumes RabbitMQ is installed and running on localhost on the standard port (5672). In case you use a different host, port or credentials, connections settings would require adjusting.

Where to get help
If you're having trouble going through this tutorial you can contact us through GitHub Discussions or RabbitMQ community Discord.

RabbitMQ is a message broker: it accepts and forwards messages. You can think about it as a post office: when you put the mail that you want posting in a post box, you can be sure that the letter carrier will eventually deliver the mail to your recipient. In this analogy, RabbitMQ is a post box, a post office, and a letter carrier.

The major difference between RabbitMQ and the post office is that it doesn't deal with paper, instead it accepts, stores, and forwards binary blobs of data ‒ messages.

RabbitMQ, and messaging in general, uses some jargon.

- Producing means nothing more than sending. A program that sends messages is a producer :
- A queue is the name for the post box in RabbitMQ. Although messages flow through RabbitMQ and your applications, they can only be stored inside a queue. A queue is only bound by the host's memory & disk limits, it's essentially a large message buffer.

Many producers can send messages that go to one queue, and many consumers can try to receive data from one queue.

This is how we represent a queue: queue_name

Consuming has a similar meaning to receiving. A consumer is a program that mostly waits to receive messages:

Note that the producer, consumer, and broker do not have to reside on the same host; indeed in most applications they don't. An application can be both a producer and consumer, too.

"Hello World"

(using the Go RabbitMQ client)
In this part of the tutorial we'll write two small programs in Go; a producer that sends a single message, and a consumer that receives messages and prints them out. We'll gloss over some of the detail in the Go RabbitMQ API, concentrating on this very simple thing just to get started. It's the "Hello World" of messaging.

In the diagram below, "P" is our producer and "C" is our consumer. The box in the middle is a queue - a message buffer that RabbitMQ keeps on behalf of the consumer.

P -> hello -> C

The Go RabbitMQ client library
RabbitMQ speaks multiple protocols. This tutorial uses AMQP 0-9-1, which is an open, general-purpose protocol for messaging. There are a number of clients for RabbitMQ in many different languages. We'll use the Go amqp client in this tutorial.

First, install amqp using go get:

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/rabbitmq/hellorabbit/sender
go get github.com/rabbitmq/amqp091-go
```

Now we have amqp installed, we can write some code.

Sending
P -> hello

We'll call our message publisher (sender) send.go and our message consumer receive.go. The publisher will connect to RabbitMQ, send a single message, then exit.

In send.go, we need to import the library first:

```go
package main

import (
  "context"
  "log"
  "time"

  amqp "github.com/rabbitmq/amqp091-go"
)
```

We also need a helper function to check the return value for each amqp call:

```go
func failOnError(err error, msg string) {
  if err != nil {
    log.Panicf("%s: %s", msg, err)
  }
}
```

Get k8s credentials

```bash
# aks
username="$(kubectl get secret resource-limits-default-user -o jsonpath='{.data.username}' | base64 --decode)"
password="$(kubectl get secret resource-limits-default-user -o jsonpath='{.data.password}' | base64 --decode)"

# on-prem
username="$(kubectl get secret rabbitmqcluster-sample-default-user -o jsonpath='{.data.username}' | base64 --decode)"
password="$(kubectl get secret rabbitmqcluster-sample-default-user -o jsonpath='{.data.password}' | base64 --decode)"
```

then create the main function and connect to RabbitMQ server

```go
func main() {
  conn, err := amqp.Dial("amqp://guest:guest@localhost:5672/")
  failOnError(err, "Failed to connect to RabbitMQ")
  defer conn.Close()
}
```

The connection abstracts the socket connection, and takes care of protocol version negotiation and authentication and so on for us. Next we create a channel, which is where most of the API for getting things done resides:

```go
ch, err := conn.Channel()
failOnError(err, "Failed to open a channel")
defer ch.Close()
```

To send, we must declare a queue for us to send to; then we can publish a message to the queue:

```go
q, err := ch.QueueDeclare(
  "hello", // name
  false,   // durable
  false,   // delete when unused
  false,   // exclusive
  false,   // no-wait
  nil,     // arguments
)
failOnError(err, "Failed to declare a queue")

ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
defer cancel()

body := "Hello World!"
err = ch.PublishWithContext(ctx,
  "",     // exchange
  q.Name, // routing key
  false,  // mandatory
  false,  // immediate
  amqp.Publishing {
    ContentType: "text/plain",
    Body:        []byte(body),
  })
failOnError(err, "Failed to publish a message")
log.Printf(" [x] Sent %s\n", body)
```

Declaring a queue is idempotent - it will only be created if it doesn't exist already. The message content is a byte array, so you can encode whatever you like there.

Here's the whole send.go script.

## Sending doesn't work

If this is your first time using RabbitMQ and you don't see the "Sent" message then you may be left scratching your head wondering what could be wrong. Maybe the broker was started without enough free disk space (by default it needs at least 50 MB free) and is therefore refusing to accept messages. Check the broker **[log](https://www.rabbitmq.com/docs/logging)** file to see if there is a **[resource alarm](https://www.rabbitmq.com/docs/alarms)** logged and reduce the free disk space threshold if necessary. The **[Configuration guide](https://www.rabbitmq.com/docs/configure#config-items)** will show you how to set disk_free_limit.

## Creating the receive project

Create a new directory for the consumer app, like `receiver/receive.go, to avoid a **[duplicate declaration](https://pkg.go.dev/golang.org/x/tools/internal/typesinternal#DuplicateDecl)**.

```bash
pushd .
mkdir -p ~/src/repsys/volumes/go/tutorials/rabbitmq/hellorabbit/receiver
cd ~/src/repsys/volumes/go/tutorials/rabbitmq/hellorabbit/receiver
go mod init receive
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/rabbitmq/hellorabbit/receiver
dirs -v
pushd +X # where X is 0 based number from the bottom of dirs -v entries

```

## Receiving

That's it for our publisher. Our consumer listens for messages from RabbitMQ, so unlike the publisher which publishes a single message, we'll keep the consumer running to listen for messages and print them out.

hello -> C

The code (in receive.go) has the same import and helper function as send:

```go
package main

import (
  "log"

  amqp "github.com/rabbitmq/amqp091-go"
)

func failOnError(err error, msg string) {
  if err != nil {
    log.Panicf("%s: %s", msg, err)
  }
}
```

Setting up is the same as the publisher; we open a connection and a channel, and declare the queue from which we're going to consume. Note this matches up with the queue that send publishes to.

```go
conn, err := amqp.Dial("amqp://guest:guest@localhost:5672/")
failOnError(err, "Failed to connect to RabbitMQ")
defer conn.Close()

ch, err := conn.Channel()
failOnError(err, "Failed to open a channel")
defer ch.Close()

q, err := ch.QueueDeclare(
  "hello", // name
  false,   // durable
  false,   // delete when unused
  false,   // exclusive
  false,   // no-wait
  nil,     // arguments
)
failOnError(err, "Failed to declare a queue")
```

Note that we declare the queue here, as well. Because we might start the consumer before the publisher, we want to make sure the queue exists before we try to consume messages from it.

We're about to tell the server to deliver us the messages from the queue. Since it will push us messages asynchronously, we will read the messages from a channel (returned by amqp::Consume) in a goroutine.

```go
msgs, err := ch.Consume(
  q.Name, // queue
  "",     // consumer
  true,   // auto-ack
  false,  // exclusive
  false,  // no-local
  false,  // no-wait
  nil,    // args
)
failOnError(err, "Failed to register a consumer")

var forever chan struct{}

go func() {
  for d := range msgs {
    log.Printf("Received a message: %s", d.Body)
  }
}()

log.Printf(" [*] Waiting for messages. To exit press CTRL+C")
<-forever
```

Putting it all together
Now we can run both scripts. In a terminal, run the publisher:

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/rabbitmq/hellorabbit/sender
go run send.go
```

then, run the consumer:

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/rabbitmq/hellorabbit/receiver
go run receive.go
```

The consumer will print the message it gets from the publisher via RabbitMQ. The consumer will keep running, waiting for messages (Use Ctrl-C to stop it), so try running the publisher from another terminal.

If you want to check on the queue, try using rabbitmqctl list_queues.

Time to move on to part 2 and build a simple work queue.
