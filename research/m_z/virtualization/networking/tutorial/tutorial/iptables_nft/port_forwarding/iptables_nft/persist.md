# does Iptables-persistent work with iptables-nft

## AI Overview

Yes, iptables-persistent can be used with iptables-nft. The iptables-nft utility provides a way to use the legacy iptables syntax while working with the newer nf_tables kernel subsystem. While it's possible to run both iptables and nftables in parallel, it's generally recommended to use iptables-nft for a more streamlined and conflict-free experience.

Here's a more detailed explanation:

## iptables-nft

This tool bridges the gap between the legacy iptables syntax and the nf_tables kernel backend. It allows you to use the familiar iptables commands and rules, but they are translated to the nf_tables format.
iptables-persistent:

This tool is used to persist (save and restore) iptables rules across reboots. It can work with iptables-nft as well.
Using both:

If you're using iptables-nft, the iptables-persistent tool will save your iptables rules (which are then translated to nf_tables format) to the relevant files, and restore them when the system boots, according to a post on **[Ask Ubuntu](https://askubuntu.com/questions/1382491/best-practices-for-persisting-nftables-rules)**.

In essence, you can use iptables-persistent to save and restore iptables rules (which are handled by iptables-nft), ensuring that your firewall configurations are persistent across reboots.

## **[Best Practices for persisting nftables rules](https://askubuntu.com/questions/1382491/best-practices-for-persisting-nftables-rules)**
