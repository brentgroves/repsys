# **[arp fingerprint](https://linux.die.net/man/1/arp-fingerprint)**

## reference

- **[os detect](https://nmap.org/book/osdetect-methods.html)**

## arp-fingerprint - Fingerprint a system using ARP

Synopsis
arp-fingerprint [options] target
The target should be specified as a single IP address or hostname. You cannot specify multiple targets, IP networks or ranges.

If you use an IP address for the target, you can use the -o option to pass the --numeric option to arp-scan, which will prevent it from attempting DNS lookups. This can speed up the fingerprinting process, especially on systems with a slow or faulty DNS configuration.

## Description

arp-fingerprint fingerprints the specified target host using the ARP protocol.
It sends various different types of ARP request to the target, and records which types it responds to. From this, it constructs a fingerprint string consisting of "1" where the target responded and "0" where it did not. An example of a fingerprint string is 01000100000. This fingerprint string is then used to lookup the likely target operating system.

Many of the fingerprint strings are shared by several operating systems, so there is not always a one-to-one mapping between fingerprint strings and operating systems. Also the fact that a system's fingerprint matches a certain operating system (or list of operating systems) does not necessarily mean that the system being fingerprinted is that operating system, although it is quite likely. This is because the list of operating systems is not exhaustive; it is just what I have discovered to date, and there are bound to be operating systems that are not listed.

The ARP fingerprint of a system is generally a function of that system's kernel (although it is possible for the ARP function to be implemented in user space, it almost never is).

Sometimes, an operating system can give different fingerprints depending on the configuration. An example is Linux, which will respond to a non-local source IP address if that IP is routed through the interface being tested. This is both good and bad: on one hand it makes the fingerprinting task more complex; but on the other, it can allow some aspects of the system configuration to be determined.

Sometimes the fact that two different operating systems share a common ARP fingerprint string points to a re-use of networking code. One example of this is Windows NT and FreeBSD.

arp-fingerprint uses arp-scan to send the ARP requests and receive the replies.

There are other methods that can be used to fingerprint a system using arp-scan which can be used in addition to arp-fingerprint. These additional methods are not included in arp-fingerprint either because they are likely to cause disruption to the target system, or because they require knowledge of the target's configuration that may not always be available.

arp-fingerprint is still being developed, and the results should not be relied on. As most of the ARP requests that it sends are non-standard, it is possible that it may disrupt some systems, so caution is advised.

If you find a system that arp-fingerprint reports as UNKNOWN, and you know what operating system it is running, could you please send details of the operating system and fingerprint to <arp-scan@nta-monitor.com> so I can include it in future versions. Please include the exact version of the operating system if you know it, as fingerprints sometimes change between versions.

## TCP/IP Fingerprinting Methods Supported by Nmap

Nmap OS fingerprinting works by sending up to 16 TCP, UDP, and ICMP probes to known open and closed ports of the target machine. These probes are specially designed to exploit various ambiguities in the standard protocol RFCs. Then Nmap listens for responses. Dozens of attributes in those responses are analyzed and combined to generate a fingerprint. Every probe packet is tracked and resent at least once if there is no response. All of the packets are IPv4 with a random IP ID value. Probes to an open TCP port are skipped if no such port has been found. For closed TCP or UDP ports, Nmap will first check if such a port has been found. If not, Nmap will just pick a port at random and hope for the best.

The following sections are highly technical and reveal the hidden workings of Nmap OS detection. Nmap can be used effectively without understanding this, though the material can help you better understand remote networks and also detect and explain certain anomalies. Plus, some of the techniques are pretty cool. Readers in a hurry may skip to the section called “Dealing with Misidentified and Unidentified Hosts”. But for those of you who are ready for a journey through TCP explicit congestion notification, reserved UDP header bits, initial sequence numbers, bogus flags, and Christmas tree packets: read on!

Even the best of us occasionally forget byte offsets for packet header fields and flags. For quick reference, the IPv4, TCP, UDP, and ICMP header layouts can be found in the section called “TCP/IP Reference”. The layout for ICMP echo request and destination unreachable packets are shown in Figure 8.1 and Figure 8.2.
