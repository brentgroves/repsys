# Repsys Architecture Notes

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## **[Websockets in Microservice Architecture](../../research/a_l/application_architecture/websockets_in_microservice_architecture.md)**

There are many architural patterns when integrating websockets. We use the websocket broker.

### WebSocket Broker

- Develop WebSocket broker service that will be acting as a middle man between the clients and the backend services.
- WebSocket connections are provided by the broker, routing of messages between clients and microservices containing the messages occurs and guaranteeing message delivery.
- This pattern is helpful for applications with the need to perform message queuing, or subscribe and broadcast topics to multiple clients or services.

## Implementation Strategies for Websockets in Microservices Architecture

### Choose the Right Framework or Library

- Mosquitto for browser to service real time communication.
- RabbitMQ or Redis for advanced message queue providing mutual locks for communication between microservices.

- **[RabbitMQ tutorial - Work Queues](../../../research/m_z/rabbitmq/work_queues.md)**\
  The main idea behind Work Queues (aka: Task Queues) is to avoid doing a resource-intensive task immediately and having to wait for it to complete. Instead we schedule the task to be done later. We encapsulate a task as a message and send it to a queue. A worker process running in the background will pop the tasks and eventually execute the job. When you run many workers the tasks will be shared between them.

  This concept is especially useful in web applications where it's impossible to handle a complex task during a short HTTP request window.

    ![jobs](https://quarkus.io/assets/images/posts/redis-job-queue/pattern.png)

The dispatcher subscribes to the Mosquitto MQTT broker. The diagram shows two dispatchers but there will be only one per consumer which will be report  because MQTT has no mutual lock mechanism
