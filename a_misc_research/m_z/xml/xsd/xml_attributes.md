# **[XSD Attributes](https://www.w3schools.com/xml/schema_simple_attributes.asp)**

- **[Current Status](../../../../development/status/weekly/current_status.md)**\
- **[Research List](../../../../research/research_list.md)**\
- **[Back Main](../../../../README.md)**

All attributes are declared as simple types.

## What is an Attribute

Simple elements cannot have attributes. If an element has attributes, it is considered to be of a complex type. But the attribute itself is always declared as a simple type.

## How to Define an Attribute

The syntax for defining an attribute is:

```xml
<xs:attribute name="xxx" type="yyy"/>
```

where xxx is the name of the attribute and yyy specifies the data type of the attribute.

## XML Schema has a lot of built-in data types. The most common types are

- xs:string
- xs:decimal
- xs:integer
- xs:boolean
- xs:date
- xs:time

## Example

Here is an XML element with an attribute:

```xml
<lastname lang="EN">Smith</lastname>
```

And here is the corresponding attribute definition:

```xml
<xs:attribute name="lang" type="xs:string"/>
```

## Default and Fixed Values for Attributes

Attributes may have a default value OR a fixed value specified.

A default value is automatically assigned to the attribute when no other value is specified.

In the following example the default value is "EN":

```xml
<xs:attribute name="lang" type="xs:string" default="EN"/>
```

A fixed value is also automatically assigned to the attribute, and you cannot specify another value.

In the following example the fixed value is "EN":

```xml
<xs:attribute name="lang" type="xs:string" fixed="EN"/>
```

## Optional and Required Attributes

Attributes are optional by default. To specify that the attribute is required, use the "use" attribute:

```xml
<xs:attribute name="lang" type="xs:string" use="required"/>
```

## Restrictions on Content

When an XML element or attribute has a data type defined, it puts restrictions on the element's or attribute's content.

If an XML element is of type "xs:date" and contains a string like "Hello World", the element will not validate.

With XML Schemas, you can also add your own restrictions to your XML elements and attributes. These restrictions are called facets. You can read more about facets in the next chapter.
