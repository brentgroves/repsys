
# Father's direction

I love you and will make in you a loving heart!  I will give you courage and help you to bear each trial and endure every hardship my son.  Do not forget that you are part of a community and I want you to learn to love each person, creature, and even the land where you live.

Good morning dear ones,
I hope you are enjoying the sunshine this week like we are here in Albion, and you and your loved ones are doing well! As always please feel free to ask for anything at home or work.  May your week be pleasant and fruitful friends :-)

Sincerely yours,
Brent
260-564-4868

## Highlights

- Adding an API gateway to our k8s cluster.
- Working on a graph API for our reporting server.
- work on the guage report

## Ingress to Kubernetes cluster

Kubernetes lives in a virtual network. To access k8s services from outside of the cluster:

- static IPs apart from any of the host IPs are used.
- K8s network interface uses the drivers of host NICs.
- Network packets sent to K8s IP/MAC addresses are forwarded to the Kubernetes API gateway for to be processed.

### Resolving MAC Address from IP Address in Linux

If you just want to find out the MAC address of a given IP address you can use the command arp to look it up, once you've pinged the system 1 time.

```bash
# Find mac address of reports1 load-balancer ip
# ping from reports-alb
ping -c1 10.1.0.8 
PING 10.1.0.8 (10.1.0.8) 56(84) bytes of data.
From 10.1.0.112 icmp_seq=1 Destination Host Unreachable

--- 10.1.0.8 ping statistics ---
1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms
```

Now look up in the ARP table:

```bash
# Find mac address of reports1 load-balancer 
$ arp -a
reports13 (10.1.0.112) at 98:90:96:c3:f4:83 [ether] on enp0s25
reports1.busche-cnc.com (10.1.0.8) at 98:90:96:c3:f4:83 [ether] on enp0s25
```

## The Kubernetes network model

The Kubernetes network model specifies:

- Every pod gets its own IP address
- Containers within a pod share the pod IP address and can communicate freely with each other
- Pods can communicate with all other pods in the cluster using pod IP addresses (without NAT)
- Isolation (restricting what each pod can communicate with) is defined using network policies

```bash
# From reports1 k8s cluster
ip netns list
cni-3415112c-7188-57b8-a2b5-33e00e73e5c0 (id: 6)
cni-5c22117f-dfc1-3cd4-cf74-46cd4d473a10 (id: 5)
cni-00b4ddf8-b38a-7c21-ad79-2220af009c1d (id: 4)
cni-43c4f73a-eabf-7a07-7bef-4b47c49732c4 (id: 3)
cni-d7fa7a8c-f3dd-60a2-0761-b19736e9af04 (id: 2)
```

## Graph API / Schema-Driven Development

In GraphQL your API starts with a schema that defines all your types, queries and mutations, It helps others to understand your API. So it’s like a contract between server and the client. Whenever you need to add a new capability to a GraphQL API you must redefine schema file and then implement that part in your code. GraphQL has its Schema Definition Language for this purpose. gqlgen is a Go library for building GraphQL servers and has a nice feature that generates code based on your schema definition.

## Execute **[Stored Procedure with GraphQL](https://stackoverflow.com/questions/73944424/execute-stored-procedure-with-graphql)**

We have database with a lot of stored procedures. I need to implement GraphQL, but I can't find information about is it possible to Execute stored procedures with GraphQL.

GraphQL has nothing to do with stored procedures. It is only a wrapper over your http requests.

In your GraphQL resolvers, you can execute any code that needs to talk to your database.

```graphql
const resolvers = {
  Query: {
    executeInsertReportRequest() {  
      return db.execute('select insert_report_request();');
    }
  }
}
```

## **[How to Perform Database Migrations using Go Migrate](https://www.freecodecamp.org/news/database-migration-golang-migrate/)**

### What is a Database Migration?

A database migration, also known as a schema migration, is a set of changes to be made to a structure of objects within a relational database.

It is a way to manage and implement incremental changes to the structure of data in a controlled, programmatic manner. These changes are often reversible, meaning they can be undone or rolled back if required.

The process of migration helps to change the database schema from its current state to a new desired state, whether it involves adding tables and columns, removing elements, splitting fields, or changing types and constraints.

By managing these changes in a programmatic way, it becomes easier to maintain consistency and accuracy in the database, as well as keep track of the history of modifications made to it.

## Why **[OpenStack](https://microstack.run/)**

We have K8s clusters spanning 3 dell Optiplexes in both Avilla and Albion. So, if one machine breaks the cluster continues to run the report system on the other two.  We also have K8s clusters on various virtual machines on Nutanix and WMware vSphere hypervisors. If one of those virtual machines go down K8s maybe able to run the software on the other nodes but we have not tested this.  If we create an OpenStack cluster on three or more bare Dell R620s we can ensure the report system stays running even if one or more nodes goes down.

How OpenStack differs from other hypervisors is its API.  It is made to be automated and controlled by clients through it's API.
