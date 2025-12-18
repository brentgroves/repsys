# **[csi-driver-spiffe](https://cert-manager.io/docs/usage/csi-driver-spiffe/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

csi-driver-spiffe is a Container Storage Interface (CSI) driver plugin for Kubernetes, designed to work alongside cert-manager.

It transparently delivers **[SPIFFE SVIDs](https://spiffe.io/docs/latest/spiffe-about/spiffe-concepts/#spiffe-verifiable-identity-document-svid)** (in the form of X.509 certificate key pairs) to mounting Kubernetes Pods.

The end result is that any and all Pods running in Kubernetes can securely request a SPIFFE identity document from a Trust Domain with minimal configuration.

These documents in turn have the following properties:

automatically renewed ✔️
private key never leaves the node's virtual memory ✔️
each Pod's document is unique ✔️
the document shares the same life cycle as the Pod and is destroyed on Pod termination ✔️
enable mTLS within a trust domain ✔️

```yaml
...
          volumeMounts:
          - mountPath: "/var/run/secrets/spiffe.io"
            name: spiffe
      volumes:
        - name: spiffe
          csi:
            driver: spiffe.csi.cert-manager.io
            readOnly: true
```

## Components

The project is split into two components: the driver and the approver.

## CSI Driver

The CSI driver runs as DaemonSet on the cluster and is responsible for generating, requesting, and mounting a certificate and private key to Pods on the node it manages. The CSI driver creates and manages a tmpfs directory.

When a Pod is created with the CSI volume configured, the driver will locally generate a private key, and create a cert-manager CertificateRequest in the same Namespace as the Pod.

The driver uses CSI Token Requests. This means that the token of the pod being created is passed to the driver.

This token's details are used for creating the SPIFFE ID which represents the pod's identity, and the token is used for creating the actual CertificateRequest for the SVID.

Once the certificate is signed by the configured cert-manager issuer, the driver mounts the private key and certificate into the Pod's Volume, and watches the certificate to renew it and the private key based on the certificate's expiry date.

## Approver

A distinct **[cert-manager approver](https://cert-manager.io/docs/usage/certificaterequest/#approval)** Deployment is responsible for managing approval and denial of csi-driver-spiffe CertificateRequests.

The approver ensures that requests have:

1. acceptable key usages (Key Encipherment, Digital Signature, Client Auth, Server Auth);
2. a requested duration which matches the enforced duration (default 1 hour);
3. no SANs or other identifiable attributes except a single URI SAN;
4. a URI SAN which is the SPIFFE identity of the ServiceAccount which created the CertificateRequest;
5. a SPIFFE ID Trust Domain matching the one that was configured at startup.

The approver only considers CertificateRequests which have the spiffe.csi.cert-manager.io/identity annotation, which is added by csi-driver-spiffe to all requests it creates.

A Uniform Resource Identifier (URI), formerly Universal Resource Identifier, is a unique sequence of characters that identifies an abstract or physical resource,[1] such as resources on a webpage, mail address, phone number,[2] books, real-world objects such as people and places, concepts.[3] URIs are used to identify anything described using the **[Resource Description Framework (RDF)](https://en.wikipedia.org/wiki/Resource_Description_Framework)**, for example, concepts that are part of an ontology defined using the **[Web Ontology Language (OWL)](https://en.wikipedia.org/wiki/Web_Ontology_Language)**, and people who are described using the Friend of a Friend vocabulary would each have an individual URI.

URIs which provide a means of locating and retrieving information resources on a network (either on the Internet or on another private network, such as a computer filesystem or an Intranet) are Uniform Resource Locators (URLs). Therefore, URLs are a subset of URIs, ie. every URL is a URI (and not necessarily the other way around).[2] Other URIs provide only a unique name, without a means of locating or retrieving the resource or information about it; these are Uniform Resource Names (URNs). The web technologies that use URIs are not limited to web browsers.

The W3C Web Ontology Language (OWL) is a Semantic Web language designed to represent rich and complex knowledge about things, groups of things

The Resource Description Framework (RDF) is a World Wide Web Consortium (W3C) standard originally designed as a data model for metadata. It has come to be used as a general method for description and exchange of graph data. RDF provides a variety of syntax notations and data serialization formats, with Turtle (Terse RDF Triple Language) currently being the most widely used notation.

RDF is a directed graph composed of triple statements. An RDF graph statement is represented by: 1) a node for the subject, 2) an arc that goes from a subject to an object for the predicate, and 3) a node for the object. Each of the three parts of the statement can be identified by a Uniform Resource Identifier (URI). An object can also be a literal value. This simple, flexible data model has a lot of expressive power to represent complex situations, relationships, and other things of interest, while also being appropriately abstract.

![](data:image/png;base64,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)

## SPIFFE Verifiable Identity Document (SVID)

An SVID is the document with which a workload proves its identity to a resource or caller. An SVID is considered valid if it has been signed by an authority within the SPIFFE ID’s trust domain.

An SVID contains a single SPIFFE ID, which represents the identity of the service presenting it. It encodes the SPIFFE ID in a cryptographically-verifiable document, in one of two currently supported formats: an X.509 certificate or a JWT token.

As tokens are susceptible to replay attacks, in which an attacker that obtains the token in transit can use it to impersonate a workload, it is advised to use X.509-SVIDs whenever possible. However, there may be some situations in which the only option is the JWT token format, for example, when your architecture has an L7 proxy or load balancer between two workloads.

For detailed information on the SVID, see the SVID specification.
