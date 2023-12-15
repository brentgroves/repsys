# The architecture of the solution

The architecture of the solution is quite simple:

- We have an API that acts as a Report Gateway. A request on the endpoint of this API will return a payload but this payload is also sent through a Redis channel called reports.

- We then have the service written in Golang. This service listens to the reports Redis channel. If data is received, the payload is parsed and inserted into the appropriate report channel.  

- The appropriate goroutine takes the request from the channel and processes it.  Once the report has been completed report requestor API is notified via a webhook passed in the payload. If the request fails due to timeout or any other errors, there is a retry mechanism using Golang channel queuing and exponential backoff to retry the request.
