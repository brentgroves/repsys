# Repsys Architecture Notes

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## **[Websockets in Microservice Architecture](../../research/a_l/application_architecture/websockets_in_microservice_architecture.md)**

## There are many architural patterns when integrating websockets we use the following

### **WebSocket Broker**

- Develop WebSocket broker service that will be acting as a middle man between the clients and the backend services.
- WebSocket connections are provided by the broker, routing of messages between clients and microservices containing the messages occurs and guaranteeing message delivery.
- This pattern is helpful for applications with the need to perform message queuing, or subscribe and broadcast topics to multiple clients or services.

## Implementation Strategies for Websockets in Microservices Architecture

### Choose the Right Framework or Library

- Mosquitto for browser to service real time communication.
- RabbitMQ or Redis for advanced message queue providing mutual locks for communication between microservices.
