# The NIST Cloud Federation Reference Architecture

The **[National Institute of Standards and Technology](https://www.nist.gov/)** is an agency of the United States Department of Commerce whose mission is to promote American innovation and industrial competitiveness.

This document presents the NIST Federated Cloud Reference Architecture model. This actor/role- based model used the guiding principles of the NIST Cloud Computing Reference Architecture to develop an eleven component model. This document describes these components individually and how they function as an ensemble. There are many possible deployments and governance options which lend themselves to create a suite of federation options from simple to complex. The basics of cloud federation can be described through the interactions of the actors in a layered three planes representation of trust, security, and resource sharing and usage. A discussion on possible future standards and use cases are also described in great detail.

## references

<https://www.nist.gov/publications/nist-cloud-federation-reference-architecture>


## 1.1 Background

NIST defines a Community Cloud as supporting organizations that have a common set of
interests (e.g. mission, security, policy [1]). When that community cloud cannot be implemented
in one public or private cloud, "there is a need to clearly define and implement mechanisms to
support the governance and processes which enable federation and interoperability between
different cloud service provider environments to form a general or mission-specific federated
Community Cloud." This is the core of Requirement 5: Frameworks to Support Federated
Community Clouds in the NIST US Government Cloud Computing Technology Roadmap, Volume I [2].

## What is federation?

In the simplest terms, federation is a means to enable interaction or
collaboration of some sort. Federation is an overloaded term with different meanings to different
stakeholders. What does it entail in this context and with regard to the cloud computing model?
What is the scope of capabilities it can or must support? Of course, federation can have multiple
definitions in different use cases, in different application domains, and at different levels in the
system stack. In some situations, federation is used to mean identity federation. This means
being able to ingest identity credentials from external identity providers. This can be used to
provide single sign-on (SSO) – a very useful capability. SSO allows a single authentication
method to access different systems within external identity providers based on mutual trust. We
will demonstrate that identity federation (also referred to as Federated Identity Management) is a
necessary component in enabling the federation of clouds.
In this document, we shall refer to “federation” as synonymous with cloud federation, i.e. getting
two or more cloud providers to interact or collaborate [3]. The term multi-cloud has been used
when cloud provider capabilities are "integrated" by defining a separate interface layer for each
“back-end” provider whereby a single, common interface can be presented to the user [4]. This
approach achieves cloud interoperability by using the rich feature set of the cloud capabilities,
but integrates them very shallowly, if at all. Another approach is to use a "lowest common
denominator" approach. Here, some minimal feature set across all providers is used, e.g. VMs,
and the "integrated" infrastructure system is built on top using, for example, Docker, Kubernetes,
OpenStack, or various DevOps solutions. This approach provides portability across cloud
providers by avoiding use of any of their differentiating capabilities.
Along these lines, the ISO/IEC Cloud Computing Reference Architecture [5] defines the concept
of an inter-cloud with inter-cloud providers. Here, different cloud service providers peer to one
another to offer cloud services to a larger set of cloud service consumers. This peering is done
through federation, intermediation, aggregation, and arbitrage of existing cloud provider
services. While these are important concepts, this ISO/IEC document does not go into any
further detail about what federation or these other activities entail and require. We investigate
those issues here.
In the case of a Community Cloud deployed by a single Cloud Provider, the cloud PaaS layer can
be used by developers to create applications. If developers establish common technical policies
and credentials within that Community Cloud, they can use tools and management systems from
different vendors and connect applications to others using common PaaS facilities. However, in a
federated multi-cloud environment with diverse cloud implementations and policies, the modules
