# Building a Robust Webhook Service with Golang: A Comprehensive Guide

## references

<https://dev.to/koladev/building-a-robust-webhook-server-with-golang-a-comprehensive-guide-4oa0>

<https://github.com/adnanh/webhook>

## What is **[webhook](https://github.com/adnanh/webhook)**

webhook is a lightweight configurable tool written in Go, that allows you to easily create HTTP endpoints (hooks) on your server, which you can use to execute configured commands. You can also pass data from the HTTP request (such as headers, payload or query variables) to your commands. webhook also allows you to specify rules which have to be satisfied in order for the hook to be triggered.

## Introduction

In software engineering, certain concepts like webhooks require careful architectural decisions before implementation. Webhooks, whether you want them or not, add another layer of complexity to your system, and you must handle them with care to ensure their reliability and value. That's why many businesses prefer using external services to handle webhook deliveries to their customers.

If you're a software engineer, understanding how webhooks work under the hood and building some of them can be a valuable exercise. In this article, we will explore how to build a webhook service using Golang for an imaginary payment gateway with an API as support.

When someone makes a request on the payment gateway to request a payment, we send a response, but we also contact the webhook service written in Golang to send a webhook request. We will use the Redis channel for communication between the Golang service and the API built with Flask. This channel will send data and instruct the Golang service to send a request (webhook) on the URL passed in the payload.

In this comprehensive guide, we will delve into technical concepts such as queuing, webhook, goroutines, and exponential backoff, providing examples and insights into building a robust Golang webhook server.

## How to build a webhook service?

Before coding, we need to discuss our approach to build a webhook service. Let's start by understanding what are webhooks and how they work.

## What are webhooks?

Webhooks are automated messages sent from one system to another triggered by specific events. They are used to notify other systems in real time when something happens, without the need for continuous polling. In a payment gateway situation, when you make a payment request, you can poll onto an endpoint with the id or the reference of the transaction to get the updated status. This method has its own drawbacks because you can be limited to the number of requests you can make (throttle), and there can be server timeout for example.
