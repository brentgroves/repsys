# **[HTTPS termination](https://docs.nginx.com/nginx-gateway-fabric/how-to/traffic-management/https-termination/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## HTTPS termination

Learn how to terminate HTTPS traffic using NGINX Gateway Fabric.

## Overview

In this guide, we will show how to configure HTTPS termination for your application, using an HTTPRoute redirect filter, secret, and ReferenceGrant.

## Before you begin

**[Install](../../../k8s/nginx_gateway_fabric_install.md)** NGINX Gateway Fabric.

Save the public IP address and port of NGINX Gateway Fabric into shell variables:
