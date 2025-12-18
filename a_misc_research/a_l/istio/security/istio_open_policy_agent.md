# **[Understanding Istio and Open Policy Agent (OPA)](https://tetrate.io/blog/understanding-istio-and-open-policy-agent-opa/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

One of the things we’re asked about by our customers adopting a service mesh practice is how **[Open Policy Agent (OPA)](https://www.openpolicyagent.org/)** and service mesh fit together and interact in their application infrastructure. In this article, we’d like to weigh in with some thoughts on where service mesh and OPA policy are best suited, respectively and how they complement each other.

A good way to frame the discussion is with NIST’s standards for Zero Trust Architecture, since they’re directly applicable to the interplay between service mesh and OPA. In the upcoming NIST standards document, Special Publication 800-207A: A Zero Trust Architecture (ZTA) Model for Access Control in Cloud Native Applications in Multi-Location Environments, identity-based segmentation is a primary concept. You can watch the presentation we gave at this year’s Cloud Native Security Con with Ramaswami Chandramouli from NIST for an in-depth discussion, but the draft spec proposes the following five policy checks as a minimum standard that should be applied on each request coming into the system and at every subsequent hop.

Five policy checks for realizing identity-based segmentation with a service mesh:

- Encryption in transit
- Service identity and authentication
- Service-to-service authorization
- End-user identity and authentication
- End-user-to-resource authorization

In short, service mesh is a dedicated infrastructure layer that’s purpose built to implement policy for the first four of these checks and has some role to play in the fifth. Where OPA shines is in number five: end-user-to-resource authorization.

Istio’s sidecar proxies act as a security kernel for microservices applications. The Envoy data plane is a universal Policy Enforcement Point (PEP) that intercepts all traffic and can apply policies at the application layer. In that capacity, it is a reference monitor (NIST SP 800-204B). With Envoy as a PEP, we can move security concerns out of the application and into the mesh.

## Policy checks 1-2

Encryption in transit and service identity & authentication. To satisfy the first two policy checks, encryption in transit and service identity and authentication, the mesh implements mTLS for all communication in the system.

## Policy check 3

Service-to-service authorization. Service mesh also provides for policy three, service-to-service authorization. OPA can start to play a role here, but since OPA is general purpose, it doesn’t have a DSL around service communication, so you’d have to create that yourself. On the other hand, we think policy tends to be more natural and easy to express in the language that’s built for it. Service mesh—and even more so, the application networking and security platform we built on top of Istio, **[Tetrate Service Bridge](https://tetrate.io/tetrate-service-bridge/)**—have nouns that make sense for writing service-to-service policy.

A domain-specific language (DSL) is a computer language specialized to a particular application domain.

## Policy check 4

End-user identity and authentication. For the fourth policy check, we need to authenticate end-user identity at every hop in the system. The service mesh provides the enforcement points to do the check, but the actual decision about user authentication is neither in the domain of service mesh nor OPA. Instead, we need to delegate out to a trusted identity provider to render verdicts here.

## Policy check 5

End-user-to-resource authorization. The fifth policy check for zero trust cloud native access control is where OPA can play a significant role. Service mesh doesn’t have a model for the relationship between end-users and resources and, as a result, is not well-suited to writing policy about it. The guidance from NIST is to integrate with existing systems via OIDC or leverage dedicated authorization infrastructure—e.g., NIST’s next-generation access control (NGAC) and Open Policy Agent.

For example, take the case of a media streaming service and its playlists. There may be millions to billions of playlists that we need to authorize an end-user against. In the same way that OPA is not particularly well-suited for service-to-service authorization, Istio authorization policy is not suited for end-user-to-resource authorization; but, OPA is.

OPA is also well-suited to a step beyond the NIST ZTA policy framework: applying business-specific policy to a request. After we do the five policy checks for zero trust, we can delegate to OPA as a rules engine to enforce business policy.

We’ll have more to say on this in the coming months, especially as SP 800-207A moves through the drafting process. But, in the meantime, the recordings of our talks at Cloud Native Security Con offer a deeper discussion of these issues:

- **[Identity Based Segmentation for a ZTA – Zack Butcher, Tetrate & Ramaswamy Chandramouli, NIST](https://www.youtube.com/watch?v=s2lIaFhkA8c)**
- **[Sponsored Keynote: From Google to NIST — The Future of Cloud Native Security – Zack Butcher, Tetrate](https://www.youtube.com/watch?v=s2lIaFhkA8c)

#
