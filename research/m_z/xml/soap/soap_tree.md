# **[The SOAP tree](https://www.ibm.com/docs/en/integration-bus/10.0?topic=soap-tree-overview)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

The SOAP nodes act as points in the flow where web service processing is configured and applied. Properties on the SOAP nodes control the processing carried out and can be configured by supplying a WSDL definition, or by manually configuring properties, or both.

This tree format allows you to access the key parts of the SOAP message in a convenient way.

This is a diagrammatic representation of the SOAP domain tree:

![st](https://www.ibm.com/docs/en/SSMKHH_10.0.0/com.ibm.etools.mft.doc/ac64020.gif)

The SOAP tree contains the following elements:

- SOAP.Header
Contains the SOAP header blocks (children of Envelope.Header)
- SOAP.Body
Contains the SOAP payload (children of Envelope.Body )
The content of the Body subtree depends on the WSDL style.
- SOAP.Attachment
Contains attachments for an SwA message in their non encoded format.
Note that attachments for an MTOM message are represented inline as part of the SOAP content in a base 64 representation.
- SOAP.Context
Contains the following information:
- Input; populated by the SOAPInput node:
  - operation - the WSDL operation name. In Gateway mode, the operation is assumed to be the name of the element that is the first child of the SOAP Body element, if present, otherwise it is the constant name 'ComIbmBrokerGenericGatewayOperation'.
  - portType - the WSDL port type name. In Gateway mode, this item is empty.
  - port - the WSDL port name (if known). In Gateway mode, this item is empty.
  - service - the WSDL service name (if known). In Gateway mode, the service has the constant name 'ComIbmBrokerGenericGatewayService'.
  - fileName - the original WSDL file name. In Gateway mode, this item is empty.
  - operationType - one of 'REQUEST_RESPONSE', 'ONE_WAY', 'SOLICIT_RESPONSE', 'NOTIFICATION'. In Gateway mode, without WSDL, this field contains 'GATEWAY'. This means 'REQUEST_RESPONSE' or 'GATEWAY_ONE_WAY', which means that the node has detected the operation type to be one-way.
  - SOAP_Version - one of '1.1' or '1.2'.
  - Namespace - Contains nameValue child elements; the name is the Namespace prefix, and the value is the Namespace URI as it appears in the bit stream.
XmlDeclaration - represents the standard XML declaration.

- Output; the following fields can be placed in SOAP.Context to provide override information when SOAPRequest or SOAPAsyncRequest nodes serialize a SOAP message:
  - SOAP_Version - one of '1.1' or '1.2'
  - Namespace - Contains nameValue child elements that define the namespace prefix (the name) to be used for a specified namespace URI (the value).
An output message uses the namespace prefixes defined here to qualify any elements in the corresponding namespaces.

If the SOAP.Context was originally created at an input node, it might already contain all the namespace prefix definitions that you need.

If SOAP.Context does not exist, or the outgoing message uses additional namespaces, the SOAP parser generates any required namespace prefixes automatically.

Alternatively, you can specify your own namespace prefix; the specific name of a namespace prefix does not usually affect the meaning of a message, with one important exception. If the message content contains a qualified name, the message must contain a matching namespace prefix definition.

For example, if the output message is a SOAP Fault containing a ```<faultcode>``` element with the value soapenv:Server, a namespace prefix (which is case sensitive) for soapenv must be defined in the logical tree:

```bash
-- Build SOAP Fault message. Note that as well as defining the correct 
-- namespace for the Fault element, it is also necessary to bind the 
-- namespace prefix used in the faultcode element (this is set up under 
-- SOAP.Context.Namespace)

-- Send back a new user defined SOAP 1.2 fault message
DECLARE soapenv NAMESPACE 'http://www.w3.org/2003/05/soap-envelope';
DECLARE xml     NAMESPACE 'http://www.w3.org/XML/1998/namespace';
DECLARE myNS    NAMESPACE 'http://myNS';

SET OutputRoot.SOAP.Context.Namespace.(SOAP.NamespaceDecl)xmlns:soapenv = soapenv;
SET OutputRoot.SOAP.Context.Namespace.(SOAP.NamespaceDecl)xmlns:myNS = myNS;

SET OutputRoot.SOAP.Body.soapenv:Fault.soapenv:Code.soapenv:Value = 'soapenv:Receiver';
SET OutputRoot.SOAP.Body.soapenv:Fault.soapenv:Code.soapenv:Subcode.soapenv:Value = 'my:subcode value';
SET OutputRoot.SOAP.Body.soapenv:Fault.soapenv:Reason.soapenv:Text = 'my Reason string';
SET OutputRoot.SOAP.Body.soapenv:Fault.soapenv:Reason.soapenv:Text.(SOAP.Attribute)xml:lang = 'en';
SET OutputRoot.SOAP.Body.soapenv:Fault.soapenv:Node = 'my Node string';
SET OutputRoot.SOAP.Body.soapenv:Fault.soapenv:Role = 'my Role string';
SET OutputRoot.SOAP.Body.soapenv:Fault.soapenv:Detail.my:Text = 'my detail string';
```

```bash
-- Send back a new user defined SOAP 1.1 fault message
DECLARE soapenv NAMESPACE 'http://schemas.xmlsoap.org/soap/envelope/';
SET OutputRoot.SOAP.Context.Namespace.(SOAP.NamespaceDecl)xmlns:soapenv = soapenv;

SET OutputRoot.SOAP.Body.soapenv:Fault.faultcode = 'soapenv:Receiver';
SET OutputRoot.SOAP.Body.soapenv:Fault.faultstring = 'my fault string';
SET OutputRoot.SOAP.Body.soapenv:Fault.faultactor = 'my fault actor';
SET OutputRoot.SOAP.Body.soapenv:Fault.detail.Text = 'my detail string';
```
