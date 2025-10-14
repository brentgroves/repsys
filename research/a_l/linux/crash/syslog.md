# **[](https://www.auvik.com/franklyit/blog/what-is-syslog/)**

If you’re new to IT, the “what is syslog?” question can get confusing fast because when someone says syslog, they might mean:

- **A local file on a system** like /var/log/messages on an Ubuntu virtual machine
- **A way to send log messages** over the network such as sending logs from endpoints to a syslog server listening for traffic on UDP port 514
- **One of several ways to format log messages**, including the legacy BSD syslog format that is still popular in the wild

And, frankly, it’s fair to use the word syslog for all of those. By the end of this article, you’ll understand why.

This article will explain the syslog protocol in detail, including its definition, formats, best practices, and challenges.

## What is syslog?

Syslog is a protocol for recording and transmitting log messages common on a wide range of systems.

Syslog is a staple of modern IT operations and network management. Many types of network devices, IoT systems, desktops, and servers support the protocol and its standard plaintext format makes messages easy for machines and humans to read.

Debugging and detecting system issues are the two most common use cases for syslog. For example:

tail -f /var/log/syslog and tail -f /var/log/messages
Commands that print the last 10 lines of a local syslog file and continues to print the output to the screen (stdout) have long been go-to troubleshooting steps for *nix administrators.

Example of syslog file content on an Ubuntu Linux system
Example of syslog file content on an Ubuntu Linux system.

Similarly, network engineers often aggregate syslog messages from multiple devices to a central syslog server to streamline anomaly detection and have a single “event log” for the entire network.

## Overview of syslog RFCs

Request For Comments (RFC) documents from the Internet Engineering Task Force (ITEF) help provide standardization and a source of truth for technical information.

When it comes to syslog, there are multiple RFCs you may encounter. The table below summarizes some of the most important syslog RFCs. We’ll take a closer look at some of these below.

| Syslog RFC            | Description                                                                                                                    |
|-----------------------|--------------------------------------------------------------------------------------------------------------------------------|
| RFC 3164              | The initial “BSD syslog” protocol and formatting. Despite being obsoleted by RFC 5424, RFC 3164 style syslog is still common.  |
| RFC 5424              | The current syslog protocol and formatting. RFC 5424 obsoletes RFC 3164                                                        |
| RFC 5426              | Details transmission of syslog messages using UDP.                                                                             |
| RFC 3195 and RFC 6587 | Details transmission of syslog messages using TCP.                                                                             |
| RFC 5425              | Details the use of TLS encryption for syslog message transmission.                                                             |

## History and Evolution

In the 1980s, syslog began as a logging mechanism developed by Eric Allman as part of the open-source Sendmail project. Sendmail became part of the University of California’s Berkeley Software Distribution (BSD) TCP/IP system implementations and became a popular Unix/Linux mail transfer agent (MTA). Over time, other projects adopted Sendmail’s protocol and it became something of a de-facto logging standard.

In 2001, the ITEF documented the syslog protocol in RFC 3164. Because it has its roots in BSD software, the early approach to syslog documented in RFC 3164 is often called “BSD syslog.” Many systems still use RFC 3164 formatting for syslog messages today.

In 2009, the ITEF obsoleted RFC 3164 and replaced it with RFC 5424. RFC 5424 is the “modern” version of syslog and adds more structure and standardization to messages. Key changes in RFC 5424 include:

- ISO-8601 timestamps that include the year
- Structured data fields
- Support for UTF-8 encoding

In addition to changes in formatting that have occurred from RFC 3164 to RFC 5424, syslog network transport has evolved. The earliest syslog implementations used UDP (documented in RFC 5426), but syslog implementations have evolved to support TCP and the Reliable Event Logging Protocol (RELP).

Additionally, while syslog messages were originally transmitted in plaintext, modern implementations support TLS encryption as documented in RFC 5425.

## How Syslog Works Now

aerial view of highways, representing syslog
The specifics of a syslog implementation on a system or network can vary significantly. For example, one implementation may send plaintext messages over UDP while another transmits encrypted messages using TLS and TCP.

That said, some components and processes can help define how syslog works in general. Let’s start with the basic syslog architecture components and what they do:

- Syslog clients**, such as network endpoints, generate and transmit syslog messages to a syslog server.
- **Syslog servers** aggregate and store syslog messages from syslog clients. Syslog servers are sometimes called “collectors.”
- **Syslog relays** receive messages and forward them to syslog server or another syslog.
- **Transport methods** enable network transport between syslog clients, servers, and relays. Syslog implementations support TCP, UDP, and RELP.

Additionally, many tools enable analysis, visualization, and alerting based on syslog messages. For example, a Security Information and Event Management (SIEM) solution might analyze log records to detect security-related anomalies. Similarly, a syslog server program might email an administrator when an event with a critical severity is logged.  

## Message Format

While there is undoubtedly some standardization in syslog message formats, you can expect to see different syslog message types in the wild. Let’s compare two example messages to visualize some of the differences between the two most popular formats, RFC3164 and RFC 5424. An RFC 3164 message looks something like this:

<34>Nov 11 11:11:11 nixbox su: 'su admin' failed for someuser on /dev/pts/3
Here’s a breakdown of each portion of that message:

| Data                                             | What is it?                                                                                                                                               |
|--------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
| <34>                                             | The PRI value which is calculated by multiplying the facility number by 8 and adding the value of the severity.                                           |
| Nov 11 11:11:11                                  | A timestamp. It is part of the message header.                                                                                                            |
| nixbox                                           | The hostname of the system that generated the message. It is part of the message header. A syslog client may use a hostname or IP address in this field.  |
| su: ‘su admin’ failed for someuser on /dev/pts/3 | The message (MSG) part of an RFC 3164 syslog message.                                                                                                     |
A comparable RFC 5424 message looks more like this:

<34>1 2023-11-11T11:11:11.123Z nixbox.example.com su - ID47 - BOM'su admin' failed for someuser on /dev/pts/3
Here is a breakdown of how that message is formatted.

| Data                                            | What is it?                                                                                                                                                                                                                                           |
|-------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <34>                                            | The PRI value which is calculated by multiplying the facility number by 8 and adding the value of the severity. It is part of the message header.                                                                                                     |
| 1                                               | A version number that indicates the syslog version in use. It is part of the message header.                                                                                                                                                          |
| 2023-11-11T11:11:11.123Z                        | An ISO 8601/RFC3339 timestamp. It is part of the message header.                                                                                                                                                                                      |
| nixbox.example.com                              | The fully-qualified domain name (FQDN) of the system that generated the message. According to RFC 5424, a syslog client can send (in order of preference) these values in this field: FQDNA static IP addressA hostnameA dynamic IP addressA NILVALUE |
| su                                              | The APP-NAME field that provides the name of the application which triggered the message.                                                                                                                                                             |
| –                                               | The PROCID field which could indicate a process ID. In this case, the PROCID is unknown.                                                                                                                                                              |
| ID47                                            | The MSGID field that enables filtering based on message type.                                                                                                                                                                                         |
| –                                               | The structured data field. In this message, there is no structured data.                                                                                                                                                                              |
| BOM’su admin’ failed for someuser on /dev/pts/3 | The MSG data (‘su admin’ failed for someuser on /dev/pts/3) and byte order mark (BOM) indicating the message encoding.                                                                                                                                |

Understanding Syslog Severity
Severity and facility are fundamental syslog concepts that are represented by the PRI value in the examples above. Let’s take a closer look at each one to better understand what they mean.

The severity value is simple. It includes a single number between 0 and 7 the importance of a message, with 0 being the most important.

| Numerical Code | Severity      | Meaning                          |
|----------------|---------------|----------------------------------|
| 0              | Emergency     | System is unusable               |
| 1              | Alert         | Action must be taken immediately |
| 2              | Critical      | Critical conditions              |
| 3              | Error         | Error conditions                 |
| 4              | Warning       | Warning conditions               |
| 5              | Notice        | Normal but significant condition |
| 6              | Informational | Informational messages           |
| 7              | Debug         | Debug-level messages             |

In practice, you don’t usually see emergency-level messages because if the system is that badly broken, it probably can’t send a message. And you probably don’t want to see debugging messages in your log because there will be too many of them, and they’re rarely important for operational purposes. So typical production systems will normally be set to a logging level of 5 or 6. The sending system might keep a local copy of the less severe messages, but it won’t send them to the central server.

## Understanding Syslog Facility Codes

The facility code requires a little more explanation. Early implementations of syslog server software generally just dumped the incoming messages into one or more log files. The server system used the facility code to sort related messages into the same file. Modern syslog implementations dump all messages into a common database and simply use the facility code as one of many possible search keys.

Facility codes are also numerical values, which are listed in the following table. Notice many of them are highly specific to systems that are, in many cases, not commonly used anymore. The facility codes defined in RFC 5424 differ from those used by BSD Unix. The differences are mostly an historical curiosity and aren’t all that important for most purposes.

The Importance of Syslog in Network and System Administration
Syslog provides five key benefits to IT and cybersecurity teams:

Enhanced visibility across the network. It’s impractical for network administrators to log into every device on their network and view individual logs. Fortunately, syslog is almost ubiquitous on network-connected devices. Aggregating logs on a central syslog server helps administrators understand where recent high-priority events have occurred so they can be efficient with their attention.
Streamlined debugging. When something is broken and you’re unsure where to look, a syslog file is often the right start. You may immediately see the problem and can increase the log level if you don’t.
Reduced mean time to resolution (MTTR). Syslog messages can help IT identify problems before users do. As a result, solutions can be enacted quicker or even automated thanks to syslog. For IT, this means lower MTTR, higher uptime, and happier users.
Stronger security. Syslog messages are key inputs to systems like SIEM and IPS appliances. Syslog provides event data that enables those systems to detect anomalies and can enable security administrators to piece together exactly what happened during an incident.
Simpler compliance. Many regulatory standards have strict requirements around auditing and log retention. A properly configured syslog implementation can enable teams to aggregate, store, and secure log records in a way that makes compliance easier.

## Why use syslog if you have SNMP?

If you’re familiar with SNMP, you might wonder why you should bother with syslog if your devices already support SNMP trap messages.

Both syslog and SNMP are used to send alerts and messages to a central server without being polled. As soon as an event occurs, the message can be sent without waiting for the server to poll for status.

The biggest difference is that SNMP traps have a predefined format in a MIB file. If an interface on a switch goes down, the MIB file defines an “ifDown” trap message that includes useful information like the specific interface. That’s great if you know ahead of time exactly what information the message will contain. But sometimes you don’t.

2 use cases
There are two significant cases where having a MIB file with predefined message types is impractical. The first is the one for which syslog was originally invented: application alerting.

Suppose you’ve written an in-house application that performs some business function. Such applications will generally have a huge range of log messages, and each new release of the software could have a bunch of new messages. It’s simply not practical to create a new MIB file for each of these messages and load it into your central logging server for every software release. The MIB file will always be a release or two behind, and the central server cannot parse any new message types.

The second important case is log messages for security devices like IDS (intrusion detection systems). These systems are constantly being updated with new signatures. There could be so much variation in the information detected by these signatures that it’s almost impossible to standardize the event messages. And many commercial IDS systems subscribe to services that download new signatures daily.

So SNMP is useful for well-defined events like interface resets, particularly on network devices, while syslog events are best for events that are more general and harder to predict.

## Tools and applications

There are plenty of open-source and commercial syslog tools and applications available. For example, open-source syslog tools are common in the Linux ecosystem. Each tool has its own features and options, but we can broadly group them into categories such as:

Syslog agents that enable client devices to transmit syslog messages
Log aggregators that act as syslog servers and provide centralization and storage of syslog records
Analytics tools that derive insights from syslog messages
For network management, tools like Auvik Syslog can make it easy to hit the ground running with syslog. The standard Auvik collector enables administrators to aggregate logs from multiple systems across the network and integrate them with the Auvik platform with minimal setup and configuration.

Best practices for using syslog
With all the things you could do with syslog, it’s hard to know what you should do.

Here are five best practices to help you get started:

Pick the right log levels. Striking a balance between data retention and noise reduction is an important aspect of an effective syslog implementation. Some teams take a “log everything” approach while others prefer to reduce data storage and noise by only logging lower severity messages.
Use encryption if you can. This one is simple: wherever you reasonably can encrypt network data, do it. TLS encryption is a practical way to improve security and many modern syslog implementations support it.
Define a retention and rotation policy. Logs can take up a lot of storage space if you’re not careful. Create a strategy that details policies such as how long you’ll store logs and when they’ll be moved to a lower-cost storage medium.
Avoid logging sensitive data. Financial data, personal data, and personally identifiable information (PII) come with specific security and compliance requirements. Avoid transmitting this via syslog as much as practical.
Standardize where you can. Being able to parse and analyze logs at scale quickly is a key benefit of syslog. The more standardized your implementation is, the easier it is for you to scale it and get the information you need when needed. Aim to standardize on message formats, schemas, and tools throughout your network.

Challenges and limitations of syslog
Like any technology, syslog has its shortcomings and limitations. One of the most common syslog “gotchas” is that log files can grow fast. And if you don’t implement log compression or rotation, low growth can quickly chew up system resources.

Additionally, syslog’s benefits come with trade-offs too. The free-form nature of syslog messages is syslog’s greatest strength, but it’s also syslog’s greatest problem.

It’s tough to parse through a log including events from dozens of different systems from different vendors (check out Auvik’s Vendor Diversity Report to get a feel for just how diverse modern networks are) and make sense of them simultaneously. Which messages represent what functions? And which ones represent critical events versus mere informational messages?

A well-architected implementation and the right log aggregation tools can solve this problem, but it’s important to keep it in mind as you devise a logging strategy.

Final thoughts: Syslog enables network visibility
Syslog is a key enabler of overall network visibility. It’s remained a staple in IT for so long, because it is widely implemented and it works. Network engineers who understand and effectively implement syslog can improve their network reliability and reduce MTTR.

If you’d like to dive deeper into syslog and network management with Auvik, get a free trial or check out this support article on getting started with Auvik syslog.

Now, we’ve covered the basics of what syslog is. In my next article, I’ll show you how to enable both UDP and TLS syslog versions on a Cisco device.

Your guide to selling managed network services

Get templates for network assessment reports, presentations, pricing & more—designed just for MSPs.

Download the kit
