# **[docker port mappings](https://www.baeldung.com/ops/assign-port-docker-container)**

## Overview

If we want to communicate with a Docker container from our host machine, we need to have a port mapping. Sometimes, we may start a container without mapping a port that we’ll need later on.

In this tutorial, we’ll discuss the importance of port mapping in Docker. We’ll also explore different ways of adding a new port mapping once a Docker container is launched.

## Why We Use Port Mapping

Port mapping is used to access the services running inside a Docker container. We open a host port to give us access to a corresponding open port inside the Docker container. Then all the requests that are made to the host port can be redirected into the Docker container.

Port mapping makes the processes inside the container available from the outside.

While running a new Docker container, we can assign the port mapping in the docker run command using the -p option:

$ docker run -d -p 81:80 --name httpd-container httpd
Copy
The above command launches an httpd container, and maps the host’s port 81 to port 80 inside that container.

By default, the httpd server listens on port 80.

So we can now access the application using port 81 on the host machine:

$ curl <http://localhost:81>
<html><body><h1>It works!</h1></body></html>
Copy
It’s not mandatory to perform port mapping for all Docker containers. Often, we’ll avoid opening host ports in order to keep the services of the container private, or only visible to sibling containers in the same Docker network.

## Ways to Assign a New Port Mapping to a Running Container

Let’s consider a situation where we forgot to do the port mapping when starting the Docker container. There would be no way to access the service from a TCP/IP connection on the host.

There are three ways to deal with this:

start over by stopping the existing container, and relaunching a new one with the same original Docker image
commit the existing container, and relaunch a new container from the committed Docker image, keeping the state of the container we’re trying to access
add a new port mapping by manipulating the Docker configuration files
Let’s dive deeper into each of these solutions.
