# **[The SOAP header](https://www.ibm.com/docs/en/integration-bus/10.0?topic=message-soap-header#ac55790_)**

- **[Current Status](../../../../development/status/weekly/current_status.md)**\
- **[Research List](../../../../research/research_list.md)**\
- **[Back Main](../../../../README.md)**

The SOAP header (the <Header> element) is an optional sub-element of the SOAP envelope, and is used to pass application-related information that is processed by SOAP nodes along the message flow.

The immediate child elements of the header are called header blocks. A header block is an application-defined XML element, and represents a logical grouping of data which can be targeted at SOAP nodes that might be encountered in the path of a message from a sender to an ultimate receiver.

SOAP header blocks can be processed by SOAP intermediary nodes, and by the ultimate SOAP receiver node. However, in a real application, not every node processes every header block. Each node is typically designed to process particular header blocks, and each header block is processed by particular nodes.

The SOAP header enables you to add features to a SOAP message in a decentralized manner without prior agreement between the communicating parties. SOAP defines some attributes that can be used to indicate what can deal with a feature and whether it is optional or mandatory. Such control information includes, for example, passing directives or contextual information related to the processing of the message. This control information enables a SOAP message to be extended in an application-specific manner.

Although the header blocks are application-defined, SOAP-defined attributes on the header blocks indicate how the header blocks must be processed by the SOAP nodes. SOAP-defined attributes include:

## encodingStyle

Indicates the rules used to encode the parts of a SOAP message. SOAP defines a narrower set of rules for encoding data than the flexible encoding that XML enables.

## actor (SOAP 1.1) or role (SOAP 1.2)

In SOAP 1.2, the role attribute specifies whether a particular node will operate on a message. If the role specified for the node matches the role attribute of the header block, the node processes the header. If the roles do not match, the node does not process the header block. In SOAP 1.1, the actor attribute performs the same function.

Roles can be defined by the application, and are designated by a URI. For example, <http://example.com/Log> might designate the role of a node which performs logging. Header blocks that are processed by this node specify env:role="<http://example.com/Log>" (where the namespace prefix env is associated with the SOAP namespace name of <http://www.w3.org/2003/05/soap-envelope>).

The SOAP 1.2 specification defines three standard roles in addition to those which are defined by the application:

- <http://www.w3.org/2003/05/soap-envelope/none>
None of the SOAP nodes on the message path should process the header block directly. Header blocks with this role can be used to carry data that is required for processing of other SOAP header blocks.
- <http://www.w3.org/2003/05/soap-envelope/next>
All SOAP nodes on the message path are expected to examine the header block (provided that the header has not been removed by a node earlier in the message path).
- <http://www.w3.org/2003/05/soap-envelope/ultimateReceiver>
Only the ultimate receiver node is expected to examine the header block.

## mustUnderstand

This attribute is used to ensure that SOAP nodes do not ignore header blocks which are important to the overall purpose of the application. If a SOAP node determines, by using the role or actor attribute, that it should process a header block, the action taken depends on the value of the mustUnderstand attribute.
1 (SOAP 1.1) or true (SOAP 1.2): The node must either process the header block in a manner consistent with its specification, or not at all (and throw a fault).
0 (SOAP 1.1) or false (SOAP 1.2): The node is not obliged to process the header block.
In effect, the mustUnderstand attribute indicates whether processing of the header block is mandatory or optional.

## relay (SOAP 1.2 only)

When a SOAP intermediary node processes a header block, the SOAP intermediary node removes the header block from the SOAP message. By default, the SOAP intermediary node also removes all header blocks that it ignored (because the mustUnderstand attribute had a value of false). However, when the relay attribute is specified with a value of true, the SOAP intermediary node retains the unprocessed header block in the message.
