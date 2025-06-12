# **[Linux Port Forwarding with iptables](https://contabo.com/blog/linux-port-forwarding-with-iptables/)**

**[Back to Research List](../../../../../../research_list.md)**\
**[Back to Current Tasks](../../../../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../../../../README.md)**

In networking, a **packet** is the basic unit of data transmitted over a network, typically at the network layer (Layer 3 of the OSI model). A **frame**, on the other hand, encapsulates a packet and other information for transmission across a specific network technology at the data link layer (Layer 2 of the OSI model). Think of **it like putting a letter (the packet) into an envelope (the frame)** for mailing.

![iptfc1](https://miro.medium.com/v2/resize:fit:720/format:webp/1*OIoNQkH4RTSm-eY2lUMBcQ.jpeg)**

| Tables↓/Chains→               | PREROUTING | INPUT | FORWARD | OUTPUT | POSTROUTING |
|-------------------------------|------------|-------|---------|--------|-------------|
| (routing decision)            |            |       |         | ✓      |             |
| raw                           | ✓          |       |         | ✓      |             |
| (connection tracking enabled) | ✓          |       |         | ✓      |             |
| mangle                        | ✓          | ✓     | ✓       | ✓      | ✓           |
| nat (DNAT)                    | ✓          |       |         | ✓      |             |
| (routing decision)            | ✓          |       |         | ✓      |             |
| filter                        |            | ✓     | ✓       | ✓      |             |
| security                      |            | ✓     | ✓       | ✓      |             |
| nat (SNAT)                    |            | ✓     |         |        | ✓           |

- Incoming packets destined for the local system: PREROUTING -> INPUT
- Incoming packets destined to another host: PREROUTING -> FORWARD -> POSTROUTING
- Locally generated packets: OUTPUT -> POSTROUTING

![ipt](https://stuffphilwrites.com/wp-content/uploads/2024/05/FW-IDS-iptables-Flowchart-v2024-05-22-768x978.png)**

## **[Architecture](https://www.digitalocean.com/community/tutorials/a-deep-dive-into-iptables-and-netfilter-architecture)**

## Troubleshooting Port Forwarding Issues

Even with careful setup, you might encounter issues with port forwarding in iptables. Understanding common problems and their solutions is important for maintaining a smooth operation. This section covers typical issues and offers tips for diagnosing and resolving port forwarding challenges.
