# **[Building Scalable Microservices: Creating a GRPC Service with Go and Consuming it in a React App via Envoy](../../../volumes/go/tutorials/grpc/go-grpc-react-example/go_grpc_server_with_envoy.md)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

In today’s blog post, we’ll explore the process of creating a GRPC service using Go and consuming it in a React app with the help of Envoy proxy. GRPC is a high-performance, language-agnostic remote procedure call (RPC) framework, and when combined with Go and Envoy, it becomes a powerful tool for building distributed systems. We’ll walk through each step of the process, from setting up the GRPC service in Go to creating a React app that communicates with it via Envoy.

![goenvoy](https://miro.medium.com/v2/resize:fit:720/format:webp/1*xV7ITojvENF-CMgXE-MJ4w.png)

## Prerequisites

Before we dive into the implementation, make sure you have the following prerequisites installed on your system:

- Go: Install Go from the official website (<https://golang.org/>).
- Node.js and npm: Download and install Node.js from (<https://nodejs.org/>).
- Docker: Install Docker to run the Envoy proxy container (<https://www.docker.com/>).

## Step 1: Creating the GRPC Service in Go

We’ll start by building the GRPC service in Go. Create a new directory for your project and set up the Go environment:
