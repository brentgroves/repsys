# Platform Features

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

This is a list of features provide by all the OSS software running on our K8s cluster.  The idea behind platform engineering is to provide as many services as possible through production quality OSS.  This helps our developers focus on business logic instead of functionality already freely available.

In the node.js based CNC MES project we used an MQTT message broker for communication between the microservices and a websocket from single server to pass info back to the web app.  This was simple but not secure.  

Since http2/3 there is a secure way for web apps to receive unsolicited notifications called server push.  We also are seeing some OSS backed companies that sell notification services in the same way Auth0 provides IAM services.

## server push

HTTP/2 Server Push is an optional feature of the HTTP/2 and HTTP/3 network protocols that allows servers to send resources to a client before the client requests them. Server Push is a performance technique aimed at reducing latency by sending resources to a client preemptively before it knows they will be needed.


| Software | Feature             | Description                                                                                                                          | Research                                                                       | Status      |
|----------|---------------------|--------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|-------------|
| Novu     | Notification system | Push notifications are a powerful way to keep users engaged by delivering timely and relevant information directly to their devices. | **[Notification Platforms](../../research/topics/notification_platforms.md)**  | Researching |
| Istio    | K8s Gateway         | Ingress for K8s network                                                                                                              | **[Gateways](../../research/topics/k8s_gateways.md)**                          | On-Prem     |
| Auth0    | IAM                 | Authentication and Authorization                                                                                                     | **[Auth0 and Microsoft Entra](https://auth0.com/blog/why-auth0-by-okta/)**     | Free Tier   |
| Keycloak | IAM                 | Authentication and Authorization                                                                                                     | **[keycloak and Microsoft Entra](../../../research/a_l/keycloak/keycloak.md)** | Docker      |
