# **[What is protobuf](https://protobuf.dev/overview/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

## Overview

Protocol Buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data.

It’s like JSON, except it’s smaller and faster, and it generates native language bindings. You define how you want your data to be structured once, then you can use special generated source code to easily write and read your structured data to and from a variety of data streams and using a variety of languages.

Protocol buffers are a combination of the definition language (created in .proto files), the code that the proto compiler generates to interface with data, language-specific runtime libraries, the serialization format for data that is written to a file (or sent across a network connection), and the serialized data.

## What Problems do Protocol Buffers Solve?

Protocol buffers provide a serialization format for packets of typed, structured data that are up to a few megabytes in size. The format is suitable for both ephemeral network traffic and long-term data storage. Protocol buffers can be extended with new information without invalidating existing data or requiring code to be updated.

Protocol buffers are the most commonly-used data format at Google. They are used extensively in inter-server communications as well as for archival storage of data on disk. Protocol buffer messages and services are described by engineer-authored .proto files. The following shows an example message:

```proto
message Person {
  optional string name = 1;
  optional int32 id = 2;
  optional string email = 3;
}
```

The proto compiler is invoked at build time on .proto files to generate code in various programming languages (covered in **[Cross-language Compatibility](https://protobuf.dev/overview/#cross-lang)** later in this topic) to manipulate the corresponding protocol buffer. Each generated class contains simple accessors for each field and methods to serialize and parse the whole structure to and from raw bytes. The following shows you an example that uses those generated methods:

```proto
Person john = Person.newBuilder()
    .setId(1234)
    .setName("John Doe")
    .setEmail("jdoe@example.com")
    .build();
output = new FileOutputStream(args[0]);
john.writeTo(output);
```
