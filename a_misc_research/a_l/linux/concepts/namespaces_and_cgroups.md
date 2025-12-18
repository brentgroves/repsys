# **[What Are Namespaces and cgroups, and How Do They Work?](https://blog.nginx.org/blog/what-are-namespaces-cgroups-how-do-they-work)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## What Are Namespaces?

Namespaces have been part of the Linux kernel since about 2002, and over time more tooling and namespace types have been added. Real container support was added to the Linux kernel only in 2013, however. This is what made namespaces really useful and brought them to the masses.

But what are namespaces exactly? Here’s a wordy definition from **[Wikipedia](https://en.wikipedia.org/wiki/Linux_namespaces)**:

    “Namespaces are a feature of the Linux kernel that partitions kernel resources such that one set of processes sees one set of resources while another set of processes sees a different set of resources.”

In other words, the key feature of namespaces is that they isolate processes from each other. On a server where you are running many different services, isolating each service and its associated processes from other services means that there is a smaller blast radius for changes, as well as a smaller footprint for security‑related concerns. Mostly though, isolating services meets the architectural style of microservices as described by Martin Fowler.

Using containers during the development process gives the developer an isolated environment that looks and feels like a complete VM. It’s not a VM, though – it’s a process running on a server somewhere. If the developer starts two containers, there are two processes running on a single server somewhere – but they are isolated from each other.
