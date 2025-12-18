# **[Protocol Engineering](https://en.wikipedia.org/wiki/Protocol_engineering)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Protocol engineering

Protocol engineering is the application of systematic methods to the development of communication protocols. It uses many of the principles of software engineering, but it is specific to the development of distributed systems.

## History

When the first experimental and commercial computer networks were developed in the 1970s, the concept of protocols was not yet well developed. These were the first distributed systems. In the context of the newly adopted layered protocol architecture (see OSI model), the definition of the protocol of a specific layer should be such that any entity implementing that specification in one computer would be compatible with any other computer containing an entity implementing the same specification, and their interactions should be such that the desired communication service would be obtained. On the other hand, the protocol specification should be abstract enough to allow different choices for the implementation on different computers.

It was recognized that a precise specification of the expected service provided by the given layer was important.[1] It is important for the verification of the protocol, which should demonstrate that the communication service is provided if both protocol entities implement the protocol specification correctly. This principle was later followed during the standardization of the OSI protocol stack, in particular for the transport layer.

It was also recognized that some kind of formalized protocol specification would be useful for the verification of the protocol and for developing implementations, as well as test cases for checking the conformance of an implementation against the specification.[2] While initially mainly finite-state machine were used as (simplified) models of a protocol entity,[3] in the 1980s three formal specification languages were standardized, two by ISO [4] and one by ITU.[5] The latter, called SDL, was later used in industry and has been merged with UML state machines.
