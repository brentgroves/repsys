# Structures K8s Cluster and Mach2 MES System PKI Certificate Management Support

Hi Team,

This is the K8s PKI certificate management service update for the week of May 2nd.

Thank you.

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Task

The task is to access all of the Mach2 servers and clients and the K8s microservice clients, which use the Structures PKI certificate management system.

## Reason

To programmatically check server certificate expiration dates and verify that client,  intermediate, and root certificates have been installed in all client trust stores.

## First Attempts

We could not access the Albion Mach2 server from the Avilla Structures Kubernetes Cluster.  This was probably due to the K8s Cluster not being on the core switch configured to serve the Albion and Avilla subnets.

## Linux Port Forwarding

After the network configuration was complete, we were able to access the Albion Mach2 server from an Albion Ubuntu desktop.  We then used the built-in Linux network packet system and standard iptables rules to forward a TCP socket connection to and from the Albion Mach2 server.

## SystemD

Once we could connect from the Avilla Structures K8s Cluster to the Albion Mach2 server through the Albion Ubuntu desktop, we needed a way to ensure iptables rules survived a reboot.  For this, we used a SystemD service oneshot unit file. We also researched SystemD's socket activation feature, which listens for client socket connections and starts a service handler as needed.  This will help run services from the Ubuntu desktop, which is not intended to be a server.

## Purpose

Ongoing certificate management for each Mach2 MES system and the Structures Avilla Kubernetes Cluster and their clients.

## Team

Christian. Trujillo, IT Structures Manager
Brent Hall, System Administrator Senior
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor
Sam Jackson, Information Systems Developer
Matt Irey, Desktop and System Support Technician
David Maitner,  Desktop and System Support Technician
Carl Stangland, Desktop and System Support Technician
