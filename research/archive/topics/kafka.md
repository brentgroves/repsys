# **[Message Queue](https://www.confluent.io/what-is-apache-kafka/)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research Summary](./research_summary.md)**\
**[Back Main](../../README.md)**

![np](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de6a24f3bc7cfdb5711e46_ethernet2.jpeg)

## What is Apache Kafka®?

Apache Kafka is an open-source distributed streaming system used for stream processing, real-time data pipelines, and data integration at scale. Originally created to handle real-time data feeds at LinkedIn in 2011, Kafka quickly evolved from a messaging queue to a full-fledged event streaming platform, capable of handling over one million messages per second, or trillions of messages per day.

Founded by the original creators of Apache Kafka, Confluent provides the most comprehensive Kafka tutorials, training, services, and support. Confluent also offers fully managed, cloud-native data streaming services built for any cloud environment, ensuring scalability and reliability for modern data infrastructure needs.

Why Kafka?
Kafka has numerous advantages. Today, Kafka is used by over 80% of the Fortune 100 across virtually every industry, for countless use cases big and small. It is the de facto technology developers and architects use to build the newest generation of scalable, real-time data streaming applications.

While these can be achieved with a range of technologies available in the market, below are the main reasons Kafka is so popular.

## How Does Apache Kafka Work?

Apache Kafka consists of a storage layer and a compute layer, which enable efficient, real-time data ingestion, streaming data pipelines, and storage across distributed systems. Its design facilitates simplified data streaming between Kafka and external systems, so you can easily manage real-time data and scale within any type of infrastructure.

## Real-Time Processing at Scale

A data streaming platform would not be complete without the ability to process and analyze data as soon as it's generated. The Kafka Streams API is a powerful, lightweight library that allows for on-the-fly processing, letting you aggregate, create windowing parameters, perform joins of data within a stream, and more. It is built as a Java application on top of Kafka, which maintains workflow continuity without requiring extra clusters to manage.

## Durable, Persistent Storage

Kafka provides durable storage by abstracting the distributed commit log commonly found in distributed databases. This makes Kafka capable of acting as a “source of truth,” able to distribute data across multiple nodes for a highly available deployment, whether within a single data center or across multiple availability zones. This durable and persistent storage ensures data integrity and reliability, even during server failures.

## Publish + Subscribe

Kafka features a humble, immutable commit log. Users can subscribe to it, and publish data to any number of systems or real-time applications. Unlike traditional messaging queues, Kafka is a highly scalable, fault-tolerant distributed system. This allows Kafka to scale from individual applications to company-wide deployments. For example, Kafka is used to manage passenger and driver matching at Uber, provide real-time analytics and predictive maintenance for British Gas' smart home, and perform numerous real-time services across all of LinkedIn.

## What is Kafka Used For?

Commonly used to build real-time streaming data pipelines and real-time streaming applications, Kafka supports a vast array of use cases. Any company that relies on, or works with data, can find numerous benefits in utilizing Kafka.

## Data Pipelines

In the context of Apache Kafka, a streaming data pipeline means ingesting the data from sources into Kafka as it’s created, and then streaming that data from Kafka to one or more targets. This allows for seamless data integration and efficient data flow across different systems.

## Stream Processing

Stream processing includes operations like filters, joins, maps, aggregations, and other transformations that enterprises leverage to power many use cases. Kafka Streams, a stream processing library built for Apache Kafka, enables enterprises to process data in real-time, making it ideal for applications requiring immediate data processing and analysis.

## Streaming Analytics

Kafka provides high throughput event delivery. When combined with open-source technologies such as Druid, it can form a powerful Streaming Analytics Manager (SAM). Druid consumes streaming data from Kafka to enable analytical queries. Events are first loaded into Kafka, where they are buffered in Kafka brokers, then they are consumed by Druid real-time workers. This allows for real-time analytics and decision-making.

## Streaming ETL

Real-time ETL with Kafka combines different components and features such as Kafka Connect source and sink connectors, used to consume and produce data from/to any other database, application, or API; Single Message Transforms (SMT)—an optional Kafka Connect feature; and Kafka Streams for continuous data processing in real-time at scale. Altogether they ensure efficient data transformation and integration.

## Event-Driven Microservices

Apache Kafka is the most popular tool for microservices, because it solves many issues related to microservices orchestration, while enabling attributes that microservices aim to achieve, such as scalability, efficiency, and speed. Kafka also facilitates inter-service communication, preserving ultra-low latency and fault tolerance. This makes it essential for building robust and scalable microservices architectures.

By using Kafka's capabilities, organizations can build highly efficient data pipelines, process streams of data in real time, perform advanced analytics, and develop scalable microservices—all ensuring they can meet the demands of modern data-driven applications.

![kia](https://images.ctfassets.net/8vofjvai1hpv/4SLkmj6QrpolaVpL0c0bVX/0441ec6dad62ee7c40559653ae9aaec1/kafka_keyword_diagram.svg)

## To Maximize Kafka, You Need Confluent

Founded by the original developers of Kafka, Confluent delivers the most complete distribution of Kafka, improving Kafka with additional community and commercial features designed to enhance the streaming experience of both operators and developers in production, at massive scale.

You love Apache Kafka®, but not managing it. Confluent's cloud-native, complete, and fully managed service goes above & beyond Kafka, so that your best people can focus on delivering value to your business.
