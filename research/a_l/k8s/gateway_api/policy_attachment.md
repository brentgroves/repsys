# **[Policy Attachment](https://gateway-api.sigs.k8s.io/reference/policy-attachment/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Metaresources and Policy Attachment

Gateway API defines a Kubernetes object that augments the behavior of an object in a standard way as a Metaresource. ReferenceGrant is an example of this general type of metaresource, but it is far from the only one.

Gateway API also defines a pattern called Policy Attachment, which augments the behavior of an object to add additional settings that can't be described within the spec of that object.

A "Policy Attachment" is a specific type of metaresource that can affect specific settings across either one object (this is "Direct Policy Attachment"), or objects in a hierarchy (this is "Inherited Policy Attachment").

This pattern is EXPERIMENTAL, and is described in **[GEP-713](https://gateway-api.sigs.k8s.io/geps/gep-713/)**. Please see that document for technical details.
