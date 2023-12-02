# Building a Robust Webhook Service with Golang: A Comprehensive Guide

## references

https://dev.to/koladev/building-a-robust-webhook-server-with-golang-a-comprehensive-guide-4oa0

https://github.com/adnanh/webhook

## What is **[webhook](https://github.com/adnanh/webhook)**

webhook is a lightweight configurable tool written in Go, that allows you to easily create HTTP endpoints (hooks) on your server, which you can use to execute configured commands. You can also pass data from the HTTP request (such as headers, payload or query variables) to your commands. webhook also allows you to specify rules which have to be satisfied in order for the hook to be triggered.


## Introduction

In software engineering, certain concepts like webhooks require careful architectural decisions before implementation. Webhooks, whether you want them or not, add another layer of complexity to your system, and you must handle them with care to ensure their reliability and value. That's why many businesses prefer using external services to handle webhook deliveries to their customers.

If you're a software engineer, understanding how webhooks work under the hood and building some of them can be a valuable exercise. In this article, we will explore how to build a webhook service using Golang for an imaginary payment gateway with an API as support.



