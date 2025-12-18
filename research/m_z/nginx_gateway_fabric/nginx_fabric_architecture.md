# **[Gateway architecture](https://docs.nginx.com/nginx-gateway-fabric/overview/gateway-architecture/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[Gateway architecture](https://docs.nginx.com/nginx-gateway-fabric/overview/gateway-architecture/)**

## Gateway architecture

Learn about the architecture and design principles of NGINX Gateway Fabric.

The intended audience for this information is primarily the two following groups:

- Cluster Operators who would like to know how the software works and understand how it can fail.
- Developers who would like to contribute to the project.

The reader needs to be familiar with core Kubernetes concepts, such as pods, deployments, services, and endpoints. For an understanding of how NGINX itself works, you can read the **[Inside NGINX: How We Designed for Performance & Scale](https://www.nginx.com/blog/inside-nginx-how-we-designed-for-performance-scale/)** blog post.

## Overview

NGINX Gateway Fabric is an open source project that provides an implementation of the **[Gateway API](../../a_l/k8s/gateway_api/k8s_gateway_api.md)** using NGINX as the data plane. The goal of this project is to implement the core Gateway APIs – Gateway, GatewayClass, HTTPRoute, GRPCRoute, TCPRoute, TLSRoute, and UDPRoute – to configure an HTTP or TCP/UDP load balancer, reverse proxy, or API gateway for applications running on Kubernetes. NGINX Gateway Fabric supports a subset of the Gateway API.

For a list of supported Gateway API resources and features, see the Gateway API Compatibility documentation.

We have more information regarding our design principles in the project’s GitHub repository.
