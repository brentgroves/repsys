# Building a Robust Webhook Service with Golang: A Comprehensive Guide

## references

<https://dev.to/koladev/building-a-robust-webhook-server-with-golang-a-comprehensive-guide-4oa0>

<https://github.com/adnanh/webhook>

## What is **[webhook](https://github.com/adnanh/webhook)**

webhook is a lightweight configurable tool written in Go, that allows you to easily create HTTP endpoints (hooks) on your server, which you can use to execute configured commands. You can also pass data from the HTTP request (such as headers, payload or query variables) to your commands. webhook also allows you to specify rules which have to be satisfied in order for the hook to be triggered.

## Introduction

In software engineering, certain concepts like webhooks require careful architectural decisions before implementation. Webhooks, whether you want them or not, add another layer of complexity to your system, and you must handle them with care to ensure their reliability and value. That's why many businesses prefer using external services to handle webhook deliveries to their customers.

If you're a software engineer, understanding how webhooks work under the hood and building some of them can be a valuable exercise. In this article, we will explore how to build a webhook service using Golang for an imaginary payment gateway with an API as support.

When someone makes a request on the payment gateway to request a payment, we send a response, but we also contact the webhook service written in Golang to send a webhook request. We will use the Redis channel for communication between the Golang service and the API built with Flask. This channel will send data and instruct the Golang service to send a request (webhook) on the URL passed in the payload.

In this comprehensive guide, we will delve into technical concepts such as queuing, webhook, goroutines, and exponential backoff, providing examples and insights into building a robust Golang webhook server.

## How to build a webhook service?

Before coding, we need to discuss our approach to build a webhook service. Let's start by understanding what are webhooks and how they work.

## What are webhooks?

Webhooks are automated messages sent from one system to another triggered by specific events. They are used to notify other systems in real time when something happens, without the need for continuous polling. In a payment gateway situation, when you make a payment request, you can poll onto an endpoint with the id or the reference of the transaction to get the updated status. This method has its own drawbacks because you can be limited to the number of requests you can make (throttle), and there can be server timeout for example.

The diagram below illustrates the action of polling and scenarios that can happen such as throttle and server timeout:

![throttle](https://res.cloudinary.com/practicaldev/image/fetch/s--GghB1Ocy--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_800/https://cdn.hashnode.com/res/hashnode/image/upload/v1692046743110/a5885f8f-339e-4445-af51-5477fae354ca.png)

Here is a description of the diagram above :

1. Client Requests Payment Status: The client repeatedly requests the payment status from the payment gateway server.
2. Server Responds with Payment Status: The server responds with the current payment status.
3. Throttle Limit Reached: After a certain number of requests, the server may throttle the client, limiting further requests.
4. Server Timeout: If the server is unable to respond within a certain time frame, it may result in a timeout error. Following the issues of throttling and server timeouts, businesses to be more reliable and fast combines allows their client to poll but also to receive webhooks. What happens is that, if a webhook is not received after a certain amount of time, the client can start polling to retrieve the status. This gives the client many ways to get updates on a payment but also helps the business stay more reliable, robust, and developer friendly.

Here's a diagram that illustrates the process of using webhooks first, and then falling back to polling if the webhooks are not delivered:
![wh_first](https://res.cloudinary.com/practicaldev/image/fetch/s--0FQyl_hK--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_800/https://cdn.hashnode.com/res/hashnode/image/upload/v1692046767883/67eb6e83-bb54-42e4-9813-2a962f653301.png)

Here is a description of the diagram above :

1. Client Requests Payment: The client initiates a payment request to the server.

2. Server Initiates Payment: The server acknowledges the payment initiation and begins processing.

3. Server Sends Webhook: The server attempts to send a webhook to the client with the payment status.

4. Webhook Not Received: If the webhook is not delivered to the client after a certain time, a note is made of this failure.

5. Client Starts Polling: The client, noticing the absence of the webhook, starts polling the server for the payment status.

6. Server Responds with Payment Status: The server responds to the polling request with the payment status.

7. Fallback to Polling: The entire process demonstrates a fallback mechanism where the client can resort to polling if the webhook is not received.

This approach ensures that the client has multiple ways to get updates on a payment, making the system more reliable, robust, and developer-friendly.

Most of the time, webhooks are HTTP POST requests made on a callback URL provided by the client. When a specified event occurs in System A, it triggers an HTTP POST request to a specific URL in System B. The request usually contains a payload with information about the event. System B's server then processes the request and takes appropriate action.

Now that we understand more about webhooks, let's discuss the challenges that come with designing a webhook service.

## Difficulties of designing a Webhook service

Designing a webhook service is a complex task that requires careful consideration of various factors to ensure scalability, reliability, and security. Here's an in-depth look at some of the key challenges:

- Scalability: Handling a large volume of requests is a common challenge in webhook services. The system must be designed to scale horizontally to accommodate the load, ensuring that it can process a high number of webhooks simultaneously without degradation in performance. Implementing concurrency is essential for managing multiple webhooks at the same time. This requires a robust concurrency model that can efficiently handle simultaneous requests.

- Reliability: Managing a queue of webhook payloads is crucial to ensure that no data is lost and that each webhook is processed in a timely manner. Implementing a reliable queuing system helps in maintaining the order and integrity of the webhooks. However, webhooks can not be delivered sometimes. It happens. A robust retry mechanism must be in place to handle failed webhook deliveries. This often involves implementing exponential backoff strategies to ensure that the receiving system is not overwhelmed with repeated attempts in quick succession.

- <b>Security:</b> Validating the payloads ensures that they meet the expected format and contain no malicious content. Implementing strict validation rules helps in preventing potential security risks. Encrypting the data transmitted through webhooks adds an extra layer of security, ensuring that sensitive information is protected during transmission.

- <b>Maintainability:</b> Comprehensive logging is vital for tracking the behavior of the webhook service, aiding in debugging, and providing insights into the system's performance. Implementing detailed logging strategies helps in monitoring the system and can be invaluable in identifying and resolving issues. For the simplicity of this article, we will focus on the scalability part and reliability of the application. Security is vast and this can be discussed in another article. However, you can check this article on how to add security to your webhooks.

Coming back to the application to develop, we will use Golang. But why? Let's discuss the pros and cons in our case and why it is a robust choice of technology here.

## Why use Golang?

In the context of building a webhook service, Golang's strengths in concurrency, scalability, performance, and strong typing make it a robust choice. The most interesting feature of Golang that will help us are goroutines and queueing. Let's dive deeper into these features.

Goroutines: Golang concurrency on steroids
Goroutines can be likened to supercharged threads but much lighter. They allow functions to run concurrently with others, enabling efficient multitasking.

To better understand Golang, here is a simple analogy.

Imagine a large restaurant during peak dining hours. In a traditional threading model, you might have a few waiters (threads) responsible for taking orders, serving food, and handling payments. If the restaurant is packed, these waiters might become overwhelmed, leading to slow service and unhappy customers. Now, consider the goroutine model in this restaurant scenario.

Instead of having a few waiters, you have a large team of nimble assistants (goroutines) who can quickly and concurrently handle multiple tasks. Each assistant is like a mini-waiter that can take an order, serve a dish, or process a payment. They can work simultaneously, efficiently utilizing the available space and resources in the restaurant.

These assistants are not only numerous but also lightweight, meaning they can quickly switch between tasks without much overhead. If one assistant is momentarily stuck or waiting for the chef, another can take over, ensuring that the service continues smoothly.

The restaurant manager (Golang's runtime scheduler) oversees these assistants, ensuring that they are distributed effectively across the available tables (CPU cores) and that they collaborate without getting in each other's way. In this analogy, the restaurant represents the computer's resources, the dining tasks represent the functions to be executed, the traditional waiters represent threads, and the nimble assistants represent goroutines. The ability to have many of these "assistants" working concurrently allows for highly efficient and scalable service, making goroutines a powerful feature in Golang's concurrency model.

Here's why goroutines are advantageous:

- Lightweight: Goroutines are far lighter than traditional threads, consuming only a few kilobytes of stack space. This allows you to spawn thousands or even millions of them simultaneously without exhausting system resources.

- Simple Syntax: Starting a goroutine is as simple as adding the go keyword before a function call. For example, go myFunction() will run myFunction as a goroutine.

- Efficient Scheduling: Golang's runtime takes care of scheduling goroutines on the available CPU cores, ensuring optimal utilization. A machine with 4 cores can run thousands of goroutines concurrently, thanks to the efficient scheduling algorithm. Here is a simple usage of goroutines in Golang

```golang
func main() {
    for i := 0; i < 10000; i++ {
        go printNumber(i)
    }
}

func printNumber(number int) {
    fmt.Println(number)
}
```

This code will spawn 10,000 goroutines to print numbers concurrently.

## Queuing in Golang

Queuing is essential in managing the flow of data, especially in a webhook service that must handle a large volume of requests. Golang offers two primary ways of queuing:

1. Using Slices: You can implement a simple queue using slices, but this approach lacks concurrency control and can lead to race conditions.

2. Using Channels: Channels provide a way to communicate between goroutines and can act as a queue. They offer built-in synchronization, ensuring that data is safely passed between goroutines. To better understand channels, here is another restaurant analogy.

Imagine the restaurant's kitchen, where orders are prepared. In a traditional system without queuing, waiters might hand orders directly to the chefs, leading to chaos during busy times. If too many orders come in at once, chefs can become overwhelmed, leading to delays and mistakes.

Now, let's introduce a queuing system using channels, akin to Golang's approach. In this model, the restaurant has a well-organized order queue, represented by a conveyor belt (channel). When waiters take orders from customers, they place them on the conveyor belt, which moves the orders to the chefs in a systematic and orderly fashion.

The conveyor belt ensures that orders are processed in the order they were received (FIFO - First In, First Out). Chefs can take one order at a time from the conveyor belt, prepare the dish, and then take the next order. If the kitchen is busy, new orders simply line up on the conveyor belt, waiting for their turn. This queuing system allows the restaurant to handle a large volume of orders without overwhelming the chefs.

It also provides flexibility. If the restaurant gets exceptionally busy, they can add more chefs (goroutines) to work on the orders from the conveyor belt. If it's a slow night, they can have fewer chefs, and the conveyor belt will still ensure that orders are handled in an orderly manner.

In Golang, channels act like this conveyor belt, providing a way to send and receive values between goroutines in a safe and organized manner. They allow you to create a pipeline where data (orders) can be processed concurrently (by multiple chefs) without conflicts or confusion.

Here's a diagram representing the restaurant analogy for queuing with channels in Golang:

![queue](https://res.cloudinary.com/practicaldev/image/fetch/s--JVAjUJYJ--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_800/https://cdn.hashnode.com/res/hashnode/image/upload/v1692046719251/ec0c2f67-2e07-4974-8e57-d1327c33d6ee.png)

In this article, we will go with channels as we need goroutines to communicate. Now that we understand better webhooks and the architecture behind the solution developed in this article, let's build our webhook service.

## Project setup

To make things easier and simple we will use Docker for this project. We will have three services:

- Redis: that will run the Redis image used to share data between the Flask API service and the Webhook Golang service.

- api: This is the name of the service written in Flask. We will just expose a GET endpoint that will generate a random payload, send the payload to the Webhook service through Redis, and also return the generated payload. No need to implement a complex endpoint as the focus of this article is on the Go service.

- webhook: the name of the service written in Golang. We will build an application that listens to data coming from a Redis channel and then process the payload and send it to the URL passed in the payload. As we are dealing with HTTP requests and we understand that other services can be unavailable, we will implement a retry mechanism (exponential backoff) and make it robust using Golang queues. The setup will take some time so I will advise just to clone the base of the project using this command :

```bash
git clone --branch base https://github.com/koladev32/golang-wehook.git
```

This will clone the base branch of the project that already comes with a working Flask project and docker-compose.yaml file.

Let's quickly explore the code of the Flask service written in Python:

```python
from datetime import datetime  
import json  
import os  
import random  
import uuid  
from flask import Flask  
import redis  


def get_payment():  
    return {  
        'url': os.getenv("WEBHOOK_ADDRESS", ""),  
        'webhookId': uuid.uuid4().hex,  
        'data': {  
            'id': uuid.uuid4().hex,  
            'payment': f"PY-{''.join((random.choice('abcdxyzpqr').capitalize() for i in range(5)))}",  
            'event': random.choice(["accepted", "completed", "canceled"]),  
            'created': datetime.now().strftime("%d/%m/%Y, %H:%M:%S"),  
        }  
    }  


redis_address = os.getenv("REDIS_ADDRESS", "")  
host, port = redis_address.split(":")  
port = int(port)  
# Create a connection to the Redis server  
redis_connection = redis.StrictRedis(host=host, port=port)  

app = Flask(__name__)  


@app.route('/payment')  
def payment():  
    webhook_payload_json = json.dumps(get_payment())  

    # Publish the JSON string to the "payments" channel in Redis  
    redis_connection.publish('payments', webhook_payload_json)  

    return webhook_payload_json  


if __name__ == '__main__':  
    app.run(host='0.0.0.0', port=8000)
```

First, we are creating a function that will generate a random payload called get_payment. This function will return a random payload with the following structure:

```json
{
    "url": "http://example.com/webhook",
    "webhookId": "52d2fc2c7f25454c8d6f471a22bdfea9",
    "data": {
        "id": "97caab9b6f924f13a94b23a960b2fff2",
        "payment": "PY-QZPCQ",
        "event": "accepted",
        "date": "13/08/2023, 00:03:46"
    }
}
```

After that, we initialize the connection to the Redis using the REDIS_ADDRESS environment variable.

```python
...

redis_address = os.getenv("REDIS_ADDRESS", "")  
host, port = redis_address.split(":")  
port = int(port)  
# Create a connection to the Redis server  
redis_connection = redis.StrictRedis(host=host, port=port)  

...
```

The redis_address is split because the REDIS_ADDRESS will normally look like this localhost:6379 or redis:6379 (if we are using Redis containers). After that, we have the route handler function payment that sends a random payload webhook_payload_json formatted with the json.dumps method, through the Redis channel called payments, and then return the random payload.

This is a simple implementation of a Payment API gateway or just to put it simply a Mock. Now that we understand the base of the project, let's quickly discuss the architecture of the solution, and the implementation of some concepts to make it robust. We will discuss their drawbacks at the end of the article.

## The architecture of the solution

The architecture of the solution is quite simple:

- We have an API that acts as a Payment Gateway. A request on the endpoint of this API will return a payload but this payload is also sent through a Redis channel called payments. Thus all services listening to this channel will receive the data sent.
- We then have the webhook service written in Golang. This service listens to the payments Redis channel. If data is received, the payload is formatted to be sent to the URL indicated on the payload. If the request fails due to timeout or any other errors, there is a retry mechanism using Golang channel queuing and exponential backoff to retry the request.

## Writing the Golang service

We will write the logic of the webhook service using Golang in the webhook directory. Here is the structure we will attain at the end of this section.

```tree
webhook
├── Dockerfile          # Defines the Docker container for the project
├── go.mod              # Module dependencies file for the Go project
├── go.sum              # Contains the expected cryptographic checksums of the content of specific module versions
├── main.go             # Main entry point for the application
├── queue
│   └── worker.go       # Contains the logic for queuing and processing tasks
├── redis
│   └── redis.go        # Handles the connection and interaction with Redis
├── sender
    └── webhook.go      # Responsible for sending the webhook reque
```

Let's start by creating the Go project.

```bash
go mod init .
```

To create a go project, you can use the go mod init name-of-the-project. In our case, adding the dot . at the end of the command tells Go to use the name of the directory as the name of the module.

Once the module is created, let's install the required dependencies such as redis.

```bash
go get github.com/go-redis/redis/v8
```

## Adding webhook sending logic

Starting a bit unconventionally, we'll first write the webhook sending logic. Since we're using Golang queuing, and to streamline the development process, we'll begin by adding the system's first dependency: the function to send the webhook.

```bash
mkdir sender && cd sender
touch webhook.go
```

Inside the newly created file, let's add the required naming and imports and structs.

```go
package sender  

import (  
   "bytes"  
   "encoding/json"  
   "errors"  
   "io"  
   "log"  
   "net/http"  
)  

// Payload represents the structure of the data expected to be sent as a webhook  
type Payload struct {  
   Event   string  
   Date    string  
   Id      string  
   Payment string  
}
```

Next, let's create a function SendWebhook that will send a JSON POST request to an URL.

```go
// SendWebhook sends a JSON POST request to the specified URL and updates the event status in the database  
func SendWebhook(data interface{}, url string, webhookId string) error {  
   // Marshal the data into JSON  
   jsonBytes, err := json.Marshal(data)  
   if err != nil {  
      return err  
   }  

   // Prepare the webhook request  
   req, err := http.NewRequest("POST", url, bytes.NewBuffer(jsonBytes))  
   if err != nil {  
      return err  
   }  
   req.Header.Set("Content-Type", "application/json")  

   // Send the webhook request  
   client := &http.Client{}  
   resp, err := client.Do(req)  
   if err != nil {  
      return err  
   }  
   defer func(Body io.ReadCloser) {  
      if err := Body.Close(); err != nil {  
         log.Println("Error closing response body:", err)  
      }  
   }(resp.Body)  

   // Determine the status based on the response code  
   status := "failed"  
   if resp.StatusCode == http.StatusOK {  
      status = "delivered"  
   }  

   log.Println(status)  

   if status == "failed" {  
      return errors.New(status)  
   }  

   return nil  
}
```

## Start here

<https://stackoverflow.com/questions/45751608/why-is-http-client-prefixed-with>
