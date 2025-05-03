# Structures K8s Cluster and Mach2 MES System PKI Certificate Management Support

Hi Team,

This is the K8s PKI certificate management service update for the week of May 2nd.

Thank you.

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

## Task

Access all of the Mach2 servers and clients as well as the K8s clients which use the Structures PKI certificate management system.

## Reason

To programmatically check server certificate expiration dates and verify client certificates and the Structures intermediate and root certificates have been installed in all client trust stores.

## First Attempts

We could not access the Albion Mach2 server from the Avilla Structures Kubernetes Cluster.  This was probably due to the K8s Cluster being on an edge and not a core switch which is configured for both the Albion and Avilla subnets.

## Linux Port Forwarding

After putting in a network config request we were able to gain access to the Albion Mach2 server from an Albion Ubuntu desktop.  We then used the builtin Linux network packet system and standard iptable rules to forward a TCP socket connection to and from the Albion Mach2 server.

## SystemD

Once we had the ability to connect from the Avilla Structures K8s Cluster to the Albion Mach2 server through the Albion Ubuntu desktop we needed a way to ensure iptable rules survived a reboot.  For this we used a SystemD service oneshot unit file. We also researched SystemD's socket activation feature which listens for client socket connections and starts a service handler dynamically.  This will help running services which are only needed occasionally from the Ubuntu desktop which has limited resources.

## Purpose

Ongoing certificate management for each Mach2 MES system and the Structures Avilla Kubernetes Cluster

## team

Christian. Trujillo, IT Structures Manager
Brent Hall, System Administrator Senior
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor
Sam Jackson, Information Systems Developer
Matt Irey, Desktop and System Support Technician
David Maitner,  Desktop and System Support Technician
Carl Stangland, Desktop and System Support Technician
