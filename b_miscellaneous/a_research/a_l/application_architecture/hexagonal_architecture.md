# **[Hexagonal Architecture, there are always two sides to every story](https://medium.com/ssense-tech/hexagonal-architecture-there-are-always-two-sides-to-every-story-bc0780ed7d9c)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

The goal of traditional Layered Architectures is to segregate an application into different tiers, where each tier contains modules and classes that have shared or similar responsibilities, and work together to perform specific tasks.

There are different flavors of Layered Architectures and there’s no rule that determines how many layers should exist. The most common pattern is the 3 tier architecture, where the application is split into Presentation Layer, Logic Layer, and Data Layer.

In his book, Domain-Driven Design: Tackling Complexity in the Heart of Software, Eric Evans proposes a 4-tier architecture to allow isolation between the Domain Layer which holds the business logic, and the other 3 supporting layers: User Interface, Application, and Infrastructure.

Following a Layered Architecture is beneficial in many ways, one and the most important being a separation of concerns. However, there’s always a risk. As there is no natural mechanism to detect when logic leaks between layers, one might — and probably will — end up with sprinkles of business logic in the user interface, or Infrastructure concerns mixed within the business logic.

In 2005, Alistair Cockburn realized that there wasn’t much difference between how the user interface and the database interact with an application, since they are both external actors which are interchangeable with similar components that would, in equivalent ways, interact with an application. By seeing things this way, one could focus on keeping the application agnostic of these “external” actors, allowing them to interact via Ports and Adapters, thus avoiding entanglement and logic leakage between business logic and external components.

In this article, I will attempt to guide you through the main concepts of the Hexagonal Architecture, its benefits and caveats, and depict in a simplistic way how you can profit from this pattern in your projects.

![](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*GQo8qpOMKE_UfBjGm6wkVg.png)

The Hexagonal Architecture, also referred to as Ports and Adapters, is an architectural pattern that allows input by users or external systems to arrive into the Application at a Port via an Adapter, and allows output to be sent out from the Application through a Port to an Adapter. This creates an abstraction layer that protects the core of an application and isolates it from external — and somehow irrelevant — tools and technologies.

## Ports

We can see a Port as a technology-agnostic entry point, it determines the interface which will allow foreign actors to communicate with the Application, regardless of who or what will implement said interface. Just as a USB port allows multiple types of devices to communicate with a computer as long as they have a USB adapter. Ports also allow the Application to communicate with external systems or services, such as databases, message brokers, other applications, etc.

Pro tip: a Port should always have two items hooked to it, one always being a test.

## Adapters

An Adapter will initiate the interaction with the Application through a Port, using a specific technology, for example, a REST controller would represent an adapter that allows a client to communicate with the Application. There can be as many Adapters for any single Port as needed without this representing a risk to the Ports or the Application itself.
