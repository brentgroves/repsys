# Flow of the Report System

- The Report Requestor Web App subscribes to a user channel through a websocket to the Report Requestor API.
- The Report Requestor API publishes the report request to the Redis TB channel.
- The Report Runner, which subscribes to the Redis TB channel, recieves the TB request and runs them in order using one of the TB GoRoutine threads.
- The Report Runner calls the Report Requestor's webhook with the report result as a payload.
- The Report Requestor API publishes the report result to the the appropriate websocket user channel thereby notifying the customer through the Report Requestor Web App to the results of thier report request.
- Alert system to post to the Report Runner's webhook adding or subtracting goroutines as report request traffic changes.
