# Architecture

## Report Requestor

## Report Runner

## Webhooks

- The Report Requestor Web App subscribes to a user channel through a websocket.
- The Report Runner calls the Report Requestor's webhook with the report result as a payload.
- The Report Requestor API publishes the report result to the the appropriate user channel thereby notifying the customer to the results of there report request.

Here's a diagram representing the restaurant analogy for queuing with channels in Golang:

![queue](https://res.cloudinary.com/practicaldev/image/fetch/s--JVAjUJYJ--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_800/https://cdn.hashnode.com/res/hashnode/image/upload/v1692046719251/ec0c2f67-2e07-4974-8e57-d1327c33d6ee.png)

In this queue system the metric system could post to the Report Runner's webhook adding or subtracting goroutines as report requests change.
