# **[Protocol Buffer Basics: Go](https://protobuf.dev/programming-guides/encoding/#packed)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[go tutorial)](https://protobuf.dev/getting-started/gotutorial/)**

Explains how Protocol Buffers encodes data to files or to the wire.
This document describes the protocol buffer wire format, which defines the details of how your message is sent on the wire and how much space it consumes on disk. You probably don’t need to understand this to use protocol buffers in your application, but it’s useful information for doing optimizations.

If you already know the concepts but want a reference, skip to the **[Condensed reference card](https://protobuf.dev/programming-guides/encoding/#cheat-sheet)** section.

Protoscope is a very simple language for describing snippets of the low-level wire format, which we’ll use to provide a visual reference for the encoding of various messages. Protoscope’s syntax consists of a sequence of tokens that each encode down to a specific byte sequence.

For example, backticks denote a raw hex literal, like `70726f746f6275660a`. This encodes into the exact bytes denoted as hex in the literal. Quotes denote UTF-8 strings, like "Hello, Protobuf!". This literal is synonymous with `48656c6c6f2c2050726f746f62756621` (which, if you observe closely, is composed of ASCII bytes). We’ll introduce more of the Protoscope language as we discuss aspects of the wire format.

The Protoscope tool can also dump encoded protocol buffers as text. See <https://github.com/protocolbuffers/protoscope/tree/main/testdata> for examples.
