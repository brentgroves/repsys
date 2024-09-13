# **[RabbitMQ tutorial - Work Queues](https://www.rabbitmq.com/tutorials/tutorial-two-go)**

**[Back to Research List](../../../research//research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## Work Queues

(using the Go RabbitMQ client)

## Prerequisites

This tutorial assumes RabbitMQ is installed and running on localhost on the standard port (5672). In case you use a different host, port or credentials, connections settings would require adjusting.

## Where to get help

If you're having trouble going through this tutorial you can contact us through **[GitHub Discussions](https://github.com/rabbitmq/rabbitmq-server/discussions)** or **[RabbitMQ community Discord](https://www.rabbitmq.com/discord/)**.

## Background

In the first tutorial we wrote programs to send and receive messages from a named queue. In this one we'll create a Work Queue that will be used to distribute time-consuming tasks among multiple workers.

The main idea behind Work Queues (aka: Task Queues) is to avoid doing a resource-intensive task immediately and having to wait for it to complete. Instead we schedule the task to be done later. We encapsulate a task as a message and send it to a queue. A worker process running in the background will pop the tasks and eventually execute the job. When you run many workers the tasks will be shared between them.

This concept is especially useful in web applications where it's impossible to handle a complex task during a short HTTP request window.
