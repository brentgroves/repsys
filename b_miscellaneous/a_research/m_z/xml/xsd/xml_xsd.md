# **[XML Schema Tutorial](https://www.w3schools.com/xml/xml_wsdl.asp)**

- **[Current Status](../../../../development/status/weekly/current_status.md)**\
- **[Research List](../../../../research/research_list.md)**\
- **[Back Main](../../../../README.md)**

- WSDL stands for Web Services Description Language
- WSDL is used to describe web services
- WSDL is written in XML
- WSDL is a W3C recommendation from 26. June 2007

## What is an XML Schema

An XML Schema describes the structure of an XML document.

The XML Schema language is also referred to as XML Schema Definition (XSD).

An XML Schema describes the structure of an XML document, just like a DTD.

An XML document with correct syntax is called "Well Formed".

An XML document validated against an XML Schema is both "Well Formed" and "Valid".

## XML XSD

The base XML schema:

```<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:hfp="http://www.w3.org/2001/XMLSchema-hasFacetAndProperty" targetNamespace="http://www.w3.org/2001/XMLSchema" blockDefault="#all" elementFormDefault="qualified" version="1.0" xml:lang="EN">```

## **[What is the difference between targetNamespace and xmlns:target](https://stackoverflow.com/questions/7190572/targetnamespace-and-xmlns-without-prefix-what-is-the-difference)**

```xml
<schema xmlns="http://www.w3.org/2001/SchemaXML"
        targetNamespace="http://www.example.com/name"
        xmlns:target="http://www.example.com/name">
```

Answered quite well over here: targetNamespace and xmlns without prefix, what is the difference?

To restate:

- targetNamespace="" - As the current XML document is a schema this attribute defines the namespace that this schema is intended to target, or validate.

xmlns="" - Defines the default namespace within the current document for all non-prefixed elements (i.e no yada: in <yada:elementName>)

xmlns:target="" - here you are just defining your own namespace with the prefix target:, this is unrelated to the previous two special cases.

The prefix "target" in xmlns:target="<http://www.example.com/name>" is nothing special. How would a schema processor know that you wanted that to be the target namespace for your schema? targetNamespace does just that - it declares the namespace that components of your schema belong to.

## Simple Type

```xml
<xs:simpleType name="string" id="string">
<xs:annotation>
<xs:appinfo>
<hfp:hasFacet name="length"/>
<hfp:hasFacet name="minLength"/>
<hfp:hasFacet name="maxLength"/>
<hfp:hasFacet name="pattern"/>
<hfp:hasFacet name="enumeration"/>
<hfp:hasFacet name="whiteSpace"/>
<hfp:hasProperty name="ordered" value="false"/>
<hfp:hasProperty name="bounded" value="false"/>
<hfp:hasProperty name="cardinality" value="countably infinite"/>
<hfp:hasProperty name="numeric" value="false"/>
</xs:appinfo>
<xs:documentation source="http://www.w3.org/TR/xmlschema-2/#string"/>
</xs:annotation>
<xs:restriction base="xs:anySimpleType">
<xs:whiteSpace value="preserve" id="string.preserve"/>
</xs:restriction>
</xs:simpleType>
```

## Complex Type

```xml
<?xml version="1.0"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">

<xs:element name="note">
  <xs:complexType>
    <xs:sequence>
      <xs:element name="to" type="xs:string"/>
      <xs:element name="from" type="xs:string"/>
      <xs:element name="heading" type="xs:string"/>
      <xs:element name="body" type="xs:string"/>
    </xs:sequence>
  </xs:complexType>
</xs:element>

</xs:schema>
```

The purpose of an XML Schema is to define the legal building blocks of an XML document:

- the elements and attributes that can appear in a document
- the number of (and order of) child elements
- data types for elements and attributes
- default and fixed values for elements and attributes

## Why Learn XML Schema

In the XML world, hundreds of standardized XML formats are in daily use.

Many of these XML standards are defined by XML Schemas.

XML Schema is an XML-based (and more powerful) alternative to DTD.

## XML Schemas Support Data Types

One of the greatest strength of XML Schemas is the support for data types.

- It is easier to describe allowable document content
- It is easier to validate the correctness of data
- It is easier to define data facets (restrictions on data)
- It is easier to define data patterns (data formats)
- It is easier to convert data between different data types

## XML Schemas use XML Syntax

Another great strength about XML Schemas is that they are written in XML.

- You don't have to learn a new language
- You can use your XML editor to edit your Schema files
- You can use your XML parser to parse your Schema files
- You can manipulate your Schema with the XML DOM
- You can transform your Schema with XSLT

## XML Schema

An XML Schema describes the structure of an XML document, just like a DTD.

An XML document with correct syntax is called "Well Formed".

An XML document validated against an XML Schema is both "Well Formed" and "Valid".

XML Schema is an XML-based alternative to DTD:

```xml
<xs:element name="note">

<xs:complexType>
  <xs:sequence>
    <xs:element name="to" type="xs:string"/>
    <xs:element name="from" type="xs:string"/>
    <xs:element name="heading" type="xs:string"/>
    <xs:element name="body" type="xs:string"/>
  </xs:sequence>
</xs:complexType>

</xs:element>
```

The Schema above is interpreted like this:

- <xs:element name="note"> defines the element called "note"
- <xs:complexType> the "note" element is a complex type
- <xs:sequence> the complex type is a sequence of elements
- <xs:element name="to" type="xs:string"> the element "to" is of type string (text)
- <xs:element name="from" type="xs:string"> the element "from" is of type string
- <xs:element name="heading" type="xs:string"> the element "heading" is of type string
- <xs:element name="body" type="xs:string"> the element "body" is of type string

## XML Schemas are More Powerful than DTD

- XML Schemas are written in XML
- XML Schemas are extensible to additions
- XML Schemas support data types
- XML Schemas support namespaces

## Why Use an XML Schema

With XML Schema, your XML files can carry a description of its own format.

With XML Schema, independent groups of people can agree on a standard for interchanging data.

With XML Schema, you can verify data.

If you want to study XML Schema, please read our **[XML Schema Tutorial](https://www.w3schools.com/xml/schema_intro.asp)**.
