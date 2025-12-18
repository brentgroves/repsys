# What is graphql

## references

<https://www.techtarget.com/searchapparchitecture/definition/GraphQL>

What is GraphQL?
GraphQL is an open source query language that describes how a client should request information through an API. In a broad sense, GraphQL is a syntax developers can use to ask for specific data and return that data from multiple sources. Once the client defines the structure of the data needed, the server returns data using the identical structure

How does GraphQL work?
Developers can make real-time updates to data through GraphQL's open source capabilities for read processes, data mutation and monitoring. GraphQL servers have been developed for use with popular coding languages such as JavaScript, Python, Ruby, C#, Go and PHP. The goal of GraphQL is to provide developers with a comprehensive view of data stored within an API. This includes the ability to only receive data directly relevant to certain queries, and to establish an architecture that makes APIs easier to scale and adapt over time

To build APIs using GraphQL, a server must host the API and client that connects to an application endpoint. GraphQL APIs comprise three fundamental components:

Schema. The type system used to define the API for a server implementation, including all of its capabilities and functions.
Query. The request, or instruction, for an output. New queries are declared with a keyword and can support nested fields, arrays and arguments.
Resolver. A function that specifies how and where an API can access data within a given field. Without this, a GraphQL server wouldn't know how to handle queries.

## Benefits of GraphQL

Facebook originally developed GraphQL to simplify endpoint management for REST-based APIs. Instead of maintaining multiple endpoints with small amounts of disjointed data, GraphQL provides a single endpoint that inputs complex queries and outputs only as much information as is needed for the query.

GraphQL helps create flexible APIs and provides increased federation across distributed applications. When developers need to modify, add or remove individual application features, they can simply adjust and execute the fields that correspond to the query that feature is associated with.

Some of the other standout benefits of using GraphQL for API builds include:

reduced complexity through hierarchical organization of code and object relationships;
the availability of strongly typed fields that alert developers to errors before running a query;
increased predictability of data returned from complex queries; and
ability to reuse existing code and data sources to eliminate instances of redundant code.
