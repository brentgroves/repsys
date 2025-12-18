# **[Cross language](https://protobuf.dev/overview/#cross-lang)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## Cross-language Compatibility

The same messages can be read by code written in any supported programming language. You can have a Java program on one platform capture data from one software system, serialize it based on a .proto definition, and then extract specific values from that serialized data in a separate Python application running on another platform.

The following languages are supported directly in the protocol buffers compiler, protoc:

C++
C#
Java
Kotlin
Objective-C
PHP
Python
Ruby

The following languages are supported by Google, but the projects’ source code resides in GitHub repositories. The protoc compiler uses plugins for these languages:

Dart
Go

Additional languages are not directly supported by Google, but rather by other GitHub projects. These languages are covered in **[Third-Party Add-ons for Protocol Buffers](https://github.com/protocolbuffers/protobuf/blob/master/docs/third_party.md)**.

## Cross-project Support

You can use protocol buffers across projects by defining message types in .proto files that reside outside of a specific project’s code base. If you’re defining message types or enums that you anticipate will be widely used outside of your immediate team, you can put them in their own file with no dependencies.

A couple of examples of proto definitions widely-used within Google are **[timestamp.proto](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto)** and **[status.proto](https://github.com/googleapis/googleapis/blob/master/google/rpc/status.proto)**.

## Updating Proto Definitions Without Updating Code

It’s standard for software products to be backward compatible, but it is less common for them to be forward compatible. As long as you follow some **[simple practices](https://protobuf.dev/programming-guides/proto3/#updating)** when updating .proto definitions, old code will read new messages without issues, ignoring any newly added fields. To the old code, fields that were deleted will have their default value, and deleted repeated fields will be empty. For information on what “repeated” fields are, see **[Protocol Buffers Definition Syntax](https://protobuf.dev/overview/#syntax)** later in this topic.

New code will also transparently read old messages. New fields will not be present in old messages; in these cases protocol buffers provide a reasonable default value.

## When are Protocol Buffers not a Good Fit?

Protocol buffers do not fit all data. In particular:

- Protocol buffers tend to assume that entire messages can be loaded into memory at once and are not larger than an **[object graph](https://en.wikipedia.org/wiki/Object_graph)**. For data that exceeds a few megabytes, consider a different solution; when working with larger data, you may effectively end up with several copies of the data due to serialized copies, which can cause surprising spikes in memory usage.

- When protocol buffers are serialized, the same data can have many different binary serializations. You cannot compare two messages for equality without fully parsing them.
- Messages are not compressed. While messages can be zipped or gzipped like any other file, special-purpose compression algorithms like the ones used by JPEG and PNG will produce much smaller files for data of the appropriate type.
- Protocol buffer messages are less than maximally efficient in both size and speed for many scientific and engineering uses that involve large, multi-dimensional arrays of floating point numbers. For these applications, **[FITS](https://en.wikipedia.org/wiki/FITS)** and similar formats have less overhead.
Protocol buffers are not well supported in non-object-oriented languages popular in scientific computing, such as Fortran and IDL.
Protocol buffer messages don’t inherently self-describe their data, but they have a fully reflective schema that you can use to implement self-description. That is, you cannot fully interpret one without access to its corresponding .proto file.
Protocol buffers are not a formal standard of any organization. This makes them unsuitable for use in environments with legal or other requirements to build on top of standards.

## **[object graph](https://en.wikipedia.org/wiki/Object_graph)**

In computer science, in an object-oriented program, groups of objects form a network through their relationships with each other, either through a direct reference to another object or through a chain of intermediate references. These groups of objects are referred to as object graphs, after the mathematical objects called **[graphs](https://en.wikipedia.org/wiki/Graph_(discrete_mathematics))** studied in **[graph theory](https://en.wikipedia.org/wiki/Graph_theory)**.
