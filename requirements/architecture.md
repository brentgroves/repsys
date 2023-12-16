# The architecture of the solution

The architecture of the solution is quite simple:

- A customer authenticates to AD using our report gateway.  The report gateway is composed of a React.js front-end which is linked to a Node.js API.  The Node.js API framework is Feather.js which features a great client library which makes programming on the client side almost identical to the coding on the server.  This library also smoothly handles authentication and renewal of JWT tokens ensuring secure access to our report gateway.  This library also makes using websockets almost transparent to the programmer.

- Once the customer has authenticated the React.js app subscribes to the users own websocket channel.  This enables Feathers.js framework to notify the customer of events involving all of their report request.s

- We have an API that acts as a report gateway. A request on the endpoint of this API will return a payload but this payload is also sent through a Redis channel called reports.

- We then have the webhook service written in Golang. This service listens to the reports Redis channel. If data is received, the payload is parsed and inserted into the appropriate report channel.  

- The goroutine assigned to that report's queue, channel, sees the request and processes it.  Once the report has been completed the report gateway is notified via a URL passed in the payload. If the request fails due to timeout or any other errors, there is an exponential retry mechanism to ensure the report gateway is notified.

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


- 
