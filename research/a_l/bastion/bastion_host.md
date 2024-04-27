# Bastion Host

## references

<https://www.strongdm.com/what-is/bastion-host#:~:text=A%20bastion%20host%20is%20a,to%20reduce%20their%20attack%20surface>.

<https://www.strongdm.com/blog/bastion-hosts-with-audit-logging-part-one>

## What is a Bastion Host?

A bastion host is a server used to manage access to an internal or private network from an external network - sometimes called a jump box or jump server. Because bastion hosts often sit on the Internet, they typically run a minimum amount of services in order to reduce their attack surface. They are also commonly used to proxy and log communications, such as SSH sessions.

## How to Create a Bastion Host | Part 1 of a Step-by-step Tutorial

![](https://discover.strongdm.com/hs-fs/hubfs/Imported_Blog_Media/605d2e18679dad4a2e0b7df4_StrongDM-1-AWS-bastion-host-user-flow-3.jpg?width=780&height=438&name=605d2e18679dad4a2e0b7df4_StrongDM-1-AWS-bastion-host-user-flow-3.jpg)

Want to secure remote access to a private network? In this series of technical posts, we will share step-by-step instructions to create a Linux bastion host and create an audit trail by logging SSH commands.

The full tutorial is split into three parts:

Part 1: Creating your bastion hosts
This post shows you how to create Linux virtual machines in Amazon Web Services, setup virtual networking, and create initial firewall rules to access the hosts.  

Part 2: Managing SSH keys
We will show you how to create an SSH key for your bastion host and look at ways you can streamline the bastion host login process without compromising the security of the key.

Part 3: Configuring hosts for logging
How to configure our bastion hosts to gather verbose logging data and send it off site to a cloud service.

## Part 1: Creating your bastion hosts

What is a bastion host?
A bastion host is a server used to manage access to an internal or private network from an external network - sometimes called a jump box or jump server. Because bastion hosts often sit on the Internet, they typically run a minimum amount of services in order to reduce their attack surface. They are also commonly used to proxy and log communications, such as SSH sessions.
