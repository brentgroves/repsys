# **[Threading Model](https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/intro/threading_model)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Threading model

Envoy uses a single process with multiple threads architecture.

A single primary thread controls various sporadic coordination tasks while some number of worker threads perform listening, filtering, and forwarding.

Once a connection is accepted by a listener, the connection spends the rest of its lifetime bound to a single worker thread. This allows the majority of Envoy to be largely single threaded (embarrassingly parallel) with a small amount of more complex code handling coordination between the worker threads.

Generally Envoy is written to be **100% non-blocking**.

For most workloads we recommend configuring the number of worker threads to be equal to the number of hardware threads on the machine.

## **[What are differences between thread types](https://stackoverflow.com/questions/5593328/software-threads-vs-hardware-threads)**

A "hardware thread" is a physical CPU or core. So, a 4 core CPU can genuinely support 4 hardware threads at once - the CPU really is doing 4 things at the same time.

One hardware thread can run many software threads. In modern operating systems, this is often done by time-slicing - each thread gets a few milliseconds to execute before the OS schedules another thread to run on that CPU. Since the OS switches back and forth between the threads quickly, it appears as if one CPU is doing more than one thing at once, but in reality, a core is still running only one hardware thread, which switches between many software threads.

## Listener connection balancing

By default, there is no coordination between worker threads. This means that all worker threads independently attempt to accept connections on each listener and rely on the kernel to perform adequate balancing between threads.

For most workloads, the kernel does a very good job of balancing incoming connections. However, for some workloads, particularly those that have a small number of very long lived connections (e.g., service mesh HTTP2/gRPC egress), it may be desirable to have Envoy forcibly balance connections between worker threads. To support this behavior, Envoy allows for different types of connection balancing to be configured on each listener.

**Note:**

On Windows the kernel is not able to balance the connections properly with the async IO model that Envoy is using.

Until this is fixed by the platform, Envoy will enforce listener connection balancing on Windows. This allows us to balance connections between different worker threads. This behavior comes with a performance penalty.

## Listeners

The Envoy configuration supports any number of listeners within a single process. Generally we recommend running a single Envoy per machine regardless of the number of configured listeners. This allows for easier operation and a single source of statistics.

Envoy supports both TCP and UDP listeners.

### TCP

Each listener is independently configured with filter_chains, where an individual filter_chain is selected based on its filter_chain_match criteria.

An individual filter_chain is composed of one or more network level (L3/L4) filters.

When a new connection is received on a listener, the appropriate filter_chain is selected, and the configured connection-local filter stack is instantiated and begins processing subsequent events.

The generic listener architecture is used to perform the vast majority of different proxy tasks that Envoy is used for (e.g., rate limiting, TLS client authentication, HTTP connection management, MongoDB sniffing, raw TCP proxy, etc.).

Listeners are optionally also configured with some number of listener filters. These filters are processed before the network level filters, and have the opportunity to manipulate the connection metadata, usually to influence how the connection is processed by later filters or clusters.

Listeners can also be fetched dynamically via the listener discovery service (LDS).

**Tip:**

See the Listener configuration, protobuf and components sections for reference documentation.
