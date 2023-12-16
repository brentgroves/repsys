# The architecture of the solution

The architecture of the solution is quite simple:

- We have an API that acts as a report gateway. A request on the endpoint of this API will return a payload but this payload is also sent through a Redis channel called reports.

- We then have the webhook service written in Golang. This service listens to the reports Redis channel. If data is received, the payload is parsed and inserted into the appropriate report channel.  

- The goroutine assigned to that report's queue, channel, sees the request and processes it.  Once the report has been completed the report gateway is notified via a URL passed in the payload. If the request fails due to timeout or any other errors, there is an exponential retry mechanism to ensure the report gateway is notified.

- 
