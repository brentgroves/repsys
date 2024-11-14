# **[XML WSDL](https://www.w3schools.com/xml/xml_wsdl.asp)**

- **[Current Status](../../../../development/status/weekly/current_status.md)**\
- **[Research List](../../../../research/research_list.md)**\
- **[Back Main](../../../../README.md)**

## references

- **[w3 wsdl](https://www.w3.org/TR/wsdl.html#_notational)**

## What does tns mean

As per w3, tns means "this namespace", referring to the current document. Source: <https://www.w3.org/TR/wsdl.html#_notational>.

## Web Services Description Language

- WSDL stands for Web Services Description Language
- WSDL is used to describe web services
- WSDL is written in XML
- WSDL is a W3C recommendation from 26. June 2007

## WSDL Documents

An WSDL document describes a web service. It specifies the location of the service, and the methods of the service, using these major elements:

| Element    | Description                                                               |
|------------|---------------------------------------------------------------------------|
| types      | Defines the (XML Schema) data types used by the web service               |
| message    | Defines the data elements for each operation                              |
| portType   | Describes the operations that can be performed and the messages involved. |
| binding    | Defines the protocol and data format for each port type                   |

The main structure of a WSDL document looks like this:

```xml
<definitions>

<types>
  data type definitions........
</types>

<message>
  definition of the data being communicated....
</message>

<portType>
  set of operations......
</portType>

<binding>
  protocol and data format specification....
</binding>

</definitions>
```

## WSDL Example

This is a simplified fraction of a WSDL document:

```xml
<message name="getTermRequest">
  <part name="term" type="xs:string"/>
</message>

<message name="getTermResponse">
  <part name="value" type="xs:string"/>
</message>

<portType name="glossaryTerms">
  <operation name="getTerm">
    <input message="getTermRequest"/>
    <output message="getTermResponse"/>
  </operation>
</portType>
```

As per w3, tns means "this namespace", referring to the current document. Source: <https://www.w3.org/TR/wsdl.html#_notational>.

The XML representation of schema components uses a vocabulary identified by the namespace name <http://www.w3.org/2001/XMLSchema>. For brevity, the text and examples in this specification use the prefix xs: to stand for this namespace; in practice, any prefix can be used. in the end xs or xsd are only prefixes.

In this example the <portType> element defines "glossaryTerms" as the name of a port, and "getTerm" as the name of an operation.

The "getTerm" operation has an input message called "getTermRequest" and an output message called "getTermResponse".

The <message> elements define the parts of each message and the associated data types.

## **[portType](https://www.tutorialspoint.com/wsdl/wsdl_port_type.htm)**

The <portType> element combines multiple message elements to form a complete one-way or round-trip operation.

For example, a <portType> can combine one request and one response message into a single request/response operation. This is most commonly used in SOAP services. A portType can define multiple operations.

Let us take a piece of code from the WSDL Example chapter −

```xml
<portType name = "Hello_PortType">
   <operation name = "sayHello">
      <input message = "tns:SayHelloRequest"/>
      <output message = "tns:SayHelloResponse"/>
   </operation>
</portType>
```

The portType element defines a single operation, called sayHello.

The operation consists of a single input message SayHelloRequest and an

output message SayHelloResponse.
