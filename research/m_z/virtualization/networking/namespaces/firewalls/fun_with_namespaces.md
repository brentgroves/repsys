# **[Fun with network namespaces](https://www.gilesthomas.com/2021/03/fun-with-network-namespaces)**

**[Research List](../../../../../research_list.md)**\
**[Detailed Status](../../../../../../a_status/detailed_status.md)**\
**[Curent Tasks](../../../../../../a_status/current_tasks.md)**\

**[Main](../../../../../../README.md)**

Linux has some amazing kernel features to enable containerization. Tools like Docker are built on top of them, and at PythonAnywhere we have built our own virtualization system using them.

One part of these systems that I've not spent much time poking into is network namespaces. Namespaces are a general abstraction that allows you to separate out system resources; for example, if a process is in a mount namespace, then it has its own set of mounted disks that is separate from those seen by the other processes on a machine -- or if it's in a process namespace, then it has its own cordoned-off set of processes visible to it (so, say, ps auxwf will just show the ones in its namespace).

As you might expect from that, if you put a process into a network namespace, it will have its own restricted view of what the networking environment looks like -- it won't see the machine's main network interface,

This provides certain advantages when it comes to security, but one that I thought was interesting is that because two processes inside different namespaces would have different networking environments, they could both bind to the same port -- and then could be accessed from outside via port forwarding.

To put that in more concrete terms: my goal was to be able to start up two Flask servers on the same machine, both bound to port 8080 inside their own namespace. I wanted to be able to access one of them from outside by hitting port 6000 on the machine, and the other by hitting port 6001.

Here is a run through how I got that working; it's a lightly-edited set of my "lab notes".
