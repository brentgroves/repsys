# **[Language Guide (proto 3)](https://protobuf.dev/getting-started/gotutorial/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[go tutorial)](https://protobuf.dev/getting-started/gotutorial/)**

## Covers how to use the version 3 of Protocol Buffers in your project

This guide describes how to use the protocol buffer language to structure your protocol buffer data, including .proto file syntax and how to generate data access classes from your .proto files. It covers the proto3 version of the protocol buffers language: for information on the proto2 syntax, see the Proto2 Language Guide.

This is a reference guide – for a step by step example that uses many of the features described in this document, see the **[tutorial](https://protobuf.dev/getting-started)** for your chosen language.

## Defining A Message Type

First let’s look at a very simple example. Let’s say you want to define a search request message format, where each search request has a query string, the particular page of results you are interested in, and a number of results per page. Here’s the .proto file you use to define the message type.

```proto
syntax = "proto3";

message SearchRequest {
  string query = 1;
  int32 page_number = 2;
  int32 results_per_page = 3;
}
```

- The first line of the file specifies that you’re using proto3 syntax: if you don’t do this the protocol buffer compiler will assume you are using proto2. This must be the first non-empty, non-comment line of the file.
- The SearchRequest message definition specifies three fields (name/value pairs), one for each piece of data that you want to include in this type of message. Each field has a name and a type.

## Specifying Field Types

In the earlier example, all the fields are scalar types: two integers (page_number and results_per_page) and a string (query). You can also specify enumerations and composite types like other message types for your field.

## Assigning Field Numbers

You must give each field in your message definition a number between 1 and 536,870,911 with the following restrictions:

- The given number must be unique among all fields for that message.
- Field numbers 19,000 to 19,999 are reserved for the Protocol Buffers implementation. The protocol  buffer compiler will complain if you use one of these reserved field numbers in your message.
- You cannot use any previously reserved field numbers or any field numbers that have been allocated to extensions

This number cannot be changed once your message type is in use because it identifies the field in the message wire format. “Changing” a field number is equivalent to deleting that field and creating a new field with the same type but a new number. See Deleting Fields for how to do this properly.

Field numbers should never be reused. Never take a field number out of the reserved list for reuse with a new field definition. See Consequences of Reusing Field Numbers.

You should use the field numbers 1 through 15 for the most-frequently-set fields. Lower field number values take less space in the wire format. For example, field numbers in the range 1 through 15 take one byte to encode. Field numbers in the range 16 through 2047 take two bytes. You can find out more about this in Protocol Buffer Encoding.

## Consequences of Reusing Field Numbers

Reusing a field number makes decoding wire-format messages ambiguous.

The protobuf wire format is lean and doesn’t provide a way to detect fields encoded using one definition and decoded using another.

Encoding a field using one definition and then decoding that same field with a different definition can lead to:

- Developer time lost to debugging
- A parse/merge error (best case scenario)
- Leaked PII/SPII
- Data corruption

Common causes of field number reuse:

- renumbering fields (sometimes done to achieve a more aesthetically pleasing number order for fields). Renumbering effectively deletes and re-adds all the fields involved in the renumbering, resulting in incompatible wire-format changes.
- deleting a field and not reserving the number to prevent future reuse.

The max field is 29 bits instead of the more-typical 32 bits because three lower bits are used for the wire format. For more on this, see the Encoding topic.

## Specifying Field Labels

Message fields can be one of the following:

- optional: An optional field is in one of two possible states:

  - the field is set, and contains a value that was explicitly set or parsed from the wire. It will be serialized to the wire.
  - the field is unset, and will return the default value. It will not be serialized to the wire.
You can check to see if the value was explicitly set.

- **repeated:** this field type can be repeated zero or more times in a well-formed message. The order of the repeated values will be preserved.

- **map:** this is a paired key/value field type. See **[Maps](https://protobuf.dev/programming-guides/encoding#maps)** for more on this field type.

- If no explicit field label is applied, the default field label, called “implicit field presence,” is assumed. (You cannot explicitly set a field to this state.) A well-formed message can have zero or one of this field (but not more than one). You also cannot determine whether a field of this type was parsed from the wire. An implicit presence field will be serialized to the wire unless it is the default value. For more on this subject, see **[Field Presence](https://protobuf.dev/programming-guides/field_presence)**.

In proto3, repeated fields of scalar numeric types use packed encoding by default. You can find out more about packed encoding in **[Protocol Buffer Encoding](https://protobuf.dev/programming-guides/encoding#packed)**.

## Well-formed Messages

The term “well-formed,” when applied to protobuf messages, refers to the bytes serialized/deserialized. The protoc parser validates that a given proto definition file is parseable.

In the case of optional fields that have more than one value, the protoc parser will accept the input, but only uses the last field. So, the “bytes” may not be “well-formed” but the resulting message would have only one and would be “well-formed” (but would not roundtrip the same).

## Message Type Fields Have Field Presence

In proto3, message-type fields already have field presence. Because of this, adding the optional modifier doesn’t change the field presence for the field.

The definitions for Message2 and Message3 in the following code sample generate the same code for all languages, and there is no difference in representation in binary, JSON, and TextFormat:

```proto
syntax="proto3";

package foo.bar;

message Message1 {}

message Message2 {
  Message1 foo = 1;
}

message Message3 {
  optional Message1 bar = 1;
}
```
