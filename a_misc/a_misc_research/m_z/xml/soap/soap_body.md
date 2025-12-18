# **[The SOAP body](https://www.ibm.com/docs/en/integration-bus/10.0?topic=message-soap-body)**

- **[Current Status](../../../../development/status/weekly/current_status.md)**\
- **[Research List](../../../../research/research_list.md)**\
- **[Back Main](../../../../README.md)**

The SOAP body (the <Body> element) is a mandatory sub-element of the SOAP envelope, which contains information intended for the ultimate recipient of the message.

The body element and its associated child elements are used to exchange information between the initial SOAP sender and the ultimate SOAP receiver. SOAP defines one child element for the body: the <Fault> element, which is used for reporting errors. Other elements in the body are defined by the web service that uses them.
