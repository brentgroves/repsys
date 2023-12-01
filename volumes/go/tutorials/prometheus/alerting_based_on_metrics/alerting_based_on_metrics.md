# alerting_based_on_metrics

## references

<https://prometheus.io/docs/tutorials/alerting_based_on_metrics/>

## ALERTING BASED ON METRICS

In this tutorial we will create alerts on the ping_request_count metric that we instrumented earlier in the Instrumenting HTTP server written in Go tutorial.

For the sake of this tutorial we will alert when the ping_request_count metric is greater than 5, Checkout real world best practices to learn more about alerting principles.

Download the latest release of Alertmanager for your operating system from here

Alertmanager supports various receivers like email, webhook, pagerduty, slack etc through which it can notify when an alert is firing. You can find the list of receivers and how to configure them here. We will use webhook as a receiver for this tutorial, head over to webhook.site and copy the webhook URL which we will use later to configure the Alertmanager.

First let's setup Alertmanager with webhook receiver.
