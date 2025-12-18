# bridge

## references

<https://www.geeksforgeeks.org/how-to-use-docker-default-bridge-networking/>

## How to use Docker Default Bridge Networking?

Docker allows you to create dedicated channels between multiple Docker Containers to create a network of Containers that can share files and other resources. This is called Docker Networking. You can create Docker Networks with various kinds of Network Drivers which include Bridge drivers, McVLAN drivers, etc. By default, if you do not mention a driver while creating a network, it automatically chooses the default bridge driver. Bridge drivers are single-host networking drivers and hence their scope is limited to local.

In this article, we are going to discuss how to create, manage, and use Docker Bridge Networks. For this, you would need a Linux-based Host machine with access to Docker. Without any further ado, let’s dive deep into Docker Bridged Networking.

## Bridge Network Driver

The bridge is a default network where containers will be created by default if you are not mentioned any network while creating. The containers which are deployed in the same network can talk to each other the containers which are not in the same network can’t communicate with each other without proper mentions and permissions. While creating a docker network if you are not going to create or mention any network while creating a container. To list the networks in docker you can use the following command.

docker network ls
