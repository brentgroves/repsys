# **[Differences in SOAP versions](https://www.ibm.com/docs/en/was-nd/8.5.5?topic=soap-differences-in-versions)**

- **[Current Status](../../../../development/status/weekly/current_status.md)**\
- **[Research List](../../../../research/research_list.md)**\
- **[Back Main](../../../../README.md)**

## references

- **[Soap structure](https://www.ibm.com/docs/en/integration-bus/10.0?topic=soap-structure-message)**

- SOAP stands for Simple Object Access Protocol
- SOAP is an application communication protocol
- SOAP is a format for sending and receiving messages
- SOAP is platform independent
- SOAP is based on XML
- SOAP is a W3C recommendation

## Why SOAP?

It is important for web applications to be able to communicate over the Internet.

The best way to communicate between applications is over HTTP, because HTTP is supported by all Internet browsers and servers. SOAP was created to accomplish this.

SOAP provides a way to communicate between applications running on different operating systems, with different technologies and programming languages.

## SOAP Building Blocks

A SOAP message is an ordinary XML document containing the following elements:

- An Envelope element that identifies the XML document as a SOAP message
- A Header element that contains header information
- A Body element that contains call and response information
- A Fault element containing errors and status information

All the elements above are declared in the default namespace for the SOAP envelope:

<http://www.w3.org/2003/05/soap-envelope>

and the default namespace for SOAP encoding and data types is:

<http://www.w3.org/2003/05/soap-encoding>
