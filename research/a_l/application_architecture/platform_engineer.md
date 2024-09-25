# **[What is platform engineering?](https://platformengineering.org/blog/what-is-platform-engineering)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

Platform engineering is the discipline of designing and building toolchains and workflows that enable self-service capabilities for software engineering organizations in the cloud-native era. Platform engineers provide an integrated product most often referred to as an “Internal Developer Platform” covering the operational necessities of the entire lifecycle of an application.

Platform engineering is the discipline of designing and building toolchains and workflows that enable self-service capabilities for software engineering organizations in the cloud-native era. Platform engineers provide an integrated product most often referred to as an “Internal Developer Platform” covering the operational necessities of the entire lifecycle of an application. An Internal Developer Platform (IDP) encompasses a variety of technologies and tools, integrated in a manner that reduces cognitive load on developers while retaining essential context and underlying technologies. It helps operations structure their setup and enable developer self-service. Platform engineering done right means providing golden paths and paved roads that match the preferred abstraction level of the individual developer, who interacts with the IDP.

In this article we are going to explore the origins of this discipline and discuss the main focus areas of platform engineers. We will also explain how this fits into the setup of a modern engineering organization and is actually a key component in most advanced development teams.

## From the ashes of DevOps: the rise of Internal Developer Platforms

Let’s turn the clock back a couple of decades. The late 90s and early 2000s, the time most setups had a single gatekeeper (and point of failure), the SysAdmin. If developers wanted to get anything done to run their applications, they had to go through them. In practice, this translated to the well-known “throw over the fence” workflow, which led to poor experiences on both sides of the fence. As an industry, we all agreed this was not the ideal we should aspire to.

At the same time that cloud started becoming a thing, with AWS launching in 2006, the concept of DevOps gained ground and established itself as the new golden standard for engineering teams. While cloud native drove huge improvements in areas like scalability, availability and operability, it also meant setups became a lot more complex. Gone were the days of running a single script to deploy a monolithic application consuming one relational database.

Suddenly, engineers had to master 10 different tools, Helm charts, Terraform modules, etc. just to deploy and test a simple code change to one of multiple environments in your multi-cluster microservice setup. The problem is that throughout this toolchain evolution, the industry seemingly decided that division of labor (Ops and Devs), which proved successful in virtually every other sector of the global economy, was not a good idea. Instead, the DevOps paradigm was championed as the way to achieve a high performing setup.

Developers should be able to deploy and run their apps and services end to end. “You build it, you run it”. True DevOps.

The issue with this approach is that for most companies, this is actually rather unrealistic. While the above works for very advanced organizations like Google, Amazon or Airbnb, it is very far from trivial to replicate true DevOps in practice for most other teams. The main reason being it is unlikely most companies have access to the same talent pool and the same level of resources they can invest into just optimizing their developer workflows and experience.

Instead, what tends to happen when a regular engineering organization tries to implement true DevOps, is that a series of **[antipatterns](http://antipatterns.com/)** emerge. This is well documented by the Team Topologies team (Matthew Skelton and Manuel Pais, speaker at one of our Platform Engineers meetups) in their analysis of DevOps anti-types, a highly recommended read for anyone who wants to better understand these dynamics. Below, an example of what emerges in many development teams when the organization decides to implement DevOps and remove a formal Ops role or team. Developers (usually the more senior ones) end up taking responsibility for managing environments, infrastructure, etc. This leads to a setup where “shadow operations” are performed by the same engineers whose input in terms of coding and product development is most valuable. Everyone loses. The senior engineer who now becomes responsible for the setup and needs to solve requests from more junior colleagues. The wider organization, which is now misusing some of its most expensive and talented resources and cannot ship features with the same speed and reliability.

An anti-pattern in software engineering, project management, and business processes is a common response to a recurring problem that is usually ineffective and risks being highly counterproductive.

## AntiPattern

![anti](https://cdn.prod.website-files.com/6489e23dd070ba71d41a33b2/649163cff008fbb11c51cb9f_6200ce7b574bad7eea1a5e1b_61bcb69ae99f82039b617b4d_image4.png)

This type of antipatterns has been shown by a number of studies, such as the State of DevOps by Puppet or, most recently, by Humanitec’s Benchmarking study. In the latter, top and low performing organizations were clustered, based on standard DevOps metrics (lead time, deployment frequency, MTTR, etc.). As shown below, a stunning 44% of low performing organizations experience the above antipattern, with some developers doing DevOps tasks on their own and helping less experienced colleagues. This is compared to top performers, where 100% of the organizations have successfully implemented a true “you build it, you run it” approach.
