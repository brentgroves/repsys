# **[into to tcpdump](https://opensource.com/article/18/10/introduction-tcpdump)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[into to tcpdump](https://opensource.com/article/18/10/introduction-tcpdump)**

## An introduction to using tcpdump at the Linux command line

This flexible, powerful command-line tool helps ease the pain of troubleshooting network issues.

Tcpdump is a command line utility that allows you to capture and analyze network traffic going through your system. It is often used to help troubleshoot network issues, as well as a security tool.

A powerful and versatile tool that includes many options and filters, tcpdump can be used in a variety of cases. Since it's a command line tool, it is ideal to run in remote servers or devices for which a GUI is not available, to collect data that can be analyzed later. It can also be launched in the background or as a scheduled job using tools like cron.

In this article, we'll look at some of tcpdump's most common features.

## Installation on Linux

Tcpdump is included with several Linux distributions, so chances are, you already have it installed. Check whether tcpdump is installed on your system with the following command:

```bash
$ which tcpdump
/bin/tcpdump
```


Tcpdump requires libpcap, which is a library for network packet capture. If it's not installed, it will be automatically added as a dependency.

You're ready to start capturing some packets.

