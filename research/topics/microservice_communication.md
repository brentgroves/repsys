# How should our Micro Services communicate with each other

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research List](../../research/research_list.md)**\
**[Back Main](../../README.md)**

In the Tool Tracker we used a message broker to make east-west requests of our micro services. Unfortunately, the message broker approach to request services is difficult to secure in a standard and uncomplicated way. Fortunately, we can use the Envoy proxy features of our Istio gateway to secure our micro services by enabling the automatic sidecar creation feature of Istio.  By doing this we will have a TLS secured request channel between our micro services without having to write any additional code using a well accepted design pattern.
