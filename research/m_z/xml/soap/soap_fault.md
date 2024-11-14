# **[The SOAP fault](https://www.ibm.com/docs/en/integration-bus/10.0?topic=message-soap-fault)**

- **[Current Status](../../../../development/status/weekly/current_status.md)**\
- **[Research List](../../../../research/research_list.md)**\
- **[Back Main](../../../../README.md)**

The SOAP body (the <Body> element) is a mandatory sub-element of the SOAP envelope, which contains information intended for the ultimate recipient of the message.

The body element and its associated child elements are used to exchange information between the initial SOAP sender and the ultimate SOAP receiver. SOAP defines one child element for the body: the ```<Fault>``` element, which is used for reporting errors. Other elements in the body are defined by the web service that uses them.

## The SOAP fault (the ```<Fault>``` element) is a sub-element of the SOAP body, which is used for reporting errors

If present, the SOAP fault element must appear as a body entry and must not appear more than once in a body element. The sub-elements of the SOAP fault element are different in SOAP 1.1 and SOAP 1.2.

SOAP 1.1

In SOAP 1.1, the SOAP fault contains the following sub-elements:

- ```<faultcode>:``` The ```<faultcode>``` element is a mandatory element in the <Fault> element. It provides information about the fault in a form that can be processed by software. SOAP defines a small set of SOAP fault codes covering basic SOAP faults, and this set can be extended by applications.
- ```<faultstring>:```The ```<faultstring>``` element is a mandatory element in the ```<Fault>``` element. It provides information about the fault in a form intended for a human reader.
-```<faultactor>:```The ```<faultactor>``` element contains the URI of the SOAP node that generated the fault. A SOAP node that is not the ultimate SOAP receiver must include the ```<faultactor>``` element when it creates a fault; an ultimate SOAP receiver is not obliged to include this element, but might do so.
- ```<detail>:```The ```<detail>``` element carries application-specific error information related to the ```<Body>``` element. It must be present if the contents of the ```<Body>``` element were not successfully processed. The ```<detail>``` element must not be used to carry information about error information belonging to header entries. Detailed error information belonging to header entries must be carried in header entries.
