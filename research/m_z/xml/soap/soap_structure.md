# **[The structure of a SOAP message](https://www.w3schools.com/xml/xml_soap.asp)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

A SOAP message is encoded as an XML document, consisting of an <Envelope> element, which contains an optional <Header> element, and a mandatory <Body> element. The <Fault> element, contained in <Body>, is used for reporting errors.

## The SOAP envelope

<Envelope> is the root element in every SOAP message, and contains two child elements, an optional <Header> element, and a mandatory <Body> element.

## The SOAP header

<Header> is an optional sub-element of the SOAP envelope, and is used to pass application-related information that is to be processed by SOAP nodes along the message path; see **[The SOAP header](https://www.ibm.com/docs/en/SSMKHH_10.0.0/com.ibm.etools.mft.doc/ac55790_.html#ac55790_)**.
The SOAP body
<Body> is a mandatory subelement of the SOAP envelope, which contains information intended for the ultimate recipient of the message; see The SOAP body.
The SOAP fault
<Fault> is a subelement of the SOAP body, which is used for reporting errors; see The SOAP fault.
XML elements in <Header> and <Body> are defined by the applications that make use of them, although the SOAP specification imposes some constraints on their structure. The following diagram shows the structure of a SOAP message.
