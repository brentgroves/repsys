# **[7 API Testing Tools That Support gRPC](https://nordicapis.com/7-api-testing-tools-that-support-grpc/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

gRPC is becoming increasingly popular, and for a good reason. It’s incredibly fast, for one thing, clocking in at up to 12x the speed of REST APIs. It’s also great for **[microservice environments](https://nordicapis.com/using-grpc-to-connect-a-microservices-ecosystem/)** and streaming data.

In case you’re not yet familiar with gRPC, it stands for Google Remote Procedure Call. Think of a remote procedure call (RPC) as a function that can be invoked on a separate system. The Google-developed approach to remote procedure calls is quite a robust solution with significant backing in the industry. That being said, gRPC is relatively newer compared to something like REST or SOAP, and as such, the development of tooling for gRPC testing is still ongoing.

With gRPC adoption on the rise, there’s an increasing need for gRPC testing to accompany the surge in interest. gRPC testing lets you ensure your gRPC APIs are performing as they should. It’s also an important component of a CI/CD pipeline as you need to monitor to ensure every component is working as it should.

With that in mind, we’ve evaluated seven API testing tools that now support gRPC. Some of these tools are more general, while others are more specific, but they all present an interesting potential for any developer wanting to implement more robust testing regiments upon their gRPC codebases.

## 1. Postman

Postman is one of the most popular and widely-used API management platforms. And as of Postman v9.7.1, gRPC is supported through an open beta implementation.

Using Postman for gRPC testing is ideal as it can be easily integrated into your existing API testing workflow. Postman’s popularity means you won’t have to learn a whole new tool to automate your gRPC testing, as an additional benefit. Given your API development team is likely already familiar with Postman, they won’t have to expend time looking for monitoring tools, output, or documentation.

Postman utilizes the Protobuf definition to parse the complete approach and implementation of the gRPC instance and unlock rapid testing and iteration. Notably, it also allows for saving the Protobuf definition to the Postman cloud, a collaborative cloud offering.

Postman notes the following features in its **[blog post announcing support](https://blog.postman.com/postman-now-supports-grpc/)**:

- Call unary, client-streaming, server-streaming, and bidirectional-streaming gRPC methods
- Enjoy autocomplete while composing messages (powered by the Protobuf definition being used)
- Client-side type-checking and type annotations (Pro tip: while composing your message, hover over a field name to see its Protobuf type)
- Load services using gRPC server reflection
- Automatically generate example messages with a single click
- Send metadata, and view incoming metadata
- Cancel a gRPC method at any time
- Variable interpolation using environments
- Advanced streaming features, such as searching and filtering streamed messages
- Import, author, share, and inspect Protobuf definitions with syntax highlighting and autocomplete
- Synchronize the proto files in your API with your repository on Github, Bitbucket, Gitlab, or Azure Repos

Utilizing Postman for gRPC testing is pretty simple. In the left-hand sidebar, select “New” and select “gRPC Request.” From here, you insert the address to the gRPC server, upload the Protobuf file, and then select the service and method. Once you click “Invoke,” your Protobuf is parsed and merged into your Postman testing view.

## 4. **[gRPC UI](https://github.com/fullstorydev/grpcui)**

gRPC UI can be run from the command line, making it an ideal choice if you want to do everything from the CLI. Once you run gRPC UI, its GUI is accessible via a web browser, serving as a graphical extension of grpcurl. This makes it an ideal choice for portable gRPC testing.

gRPC UI only supports gRPC, however, unlike the other API testing solutions we’ve looked at so far. If you’re looking for an all-in-one solution for all of your API testing, look elsewhere. If you’re just looking for a lightweight, portable, and efficient environment solely for gRPC, gRPC UI is worth a look.

- Benefits of gRPC UI for gRPC Testing:
- Lightweight, gRPC-specific testing
- Run from the command line
- Web-based GUI
- Portable

## 4.1 **[gRPCurl](https://github.com/fullstorydev/grpcurl)**
