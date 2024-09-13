# **[Queues](https://www.rabbitmq.com/docs/queues)**

**[Back to Research List](../../../research//research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## What is a Queue?

A queue in RabbitMQ is an ordered collection of messages. Messages are enqueued and dequeued (delivered to consumers) in a (FIFO ("first in, first out") manner.

To define a queue in generic terms, it is a sequential data structure with two primary operations: an item can be enqueued (added) at the tail and dequeued (consumed) from the head.

Queues play a major role in the messaging technology space. Many messaging protocols and tools assume that publishers and consumers communicate using a queue-like storage mechanism.

Many features in a messaging system are related to queues. Some RabbitMQ queue features such as priorities and requeueing by consumers can affect the ordering as observed by consumers.

The information in this topic includes an overview of queues in RabbitMQ and also links out to other topics so you can learn more about using queues in RabbitMQ.

This information primarily covers queues in the context of the AMQP 0-9-1 protocol, however, much of the content is applicable to other supported protocols.
