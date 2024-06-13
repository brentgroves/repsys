# **[nftables wiki](https://wiki.nftables.org/wiki-nftables/index.php/Main_Page)**

What is nftables?
nftables is the modern Linux kernel **packet classification framework**. New code should use it instead of the legacy {ip,ip6,arp,eb}_tables (xtables) infrastructure. For existing codebases that have not yet converted, the legacy xtables infrastructure is still maintained as of 2021. Automated tools assist the xtables to nftables conversion process.

nftables in a nutshell:

It is available in Linux kernels >= 3.13.
It comes with a new command line utility nft whose syntax is different to iptables.
It also comes with a compatibility layer that allows you to run iptables commands over the new nftables kernel framework.
It provides a generic set infrastructure that allows you to construct maps and concatenations. You can use these new structures to arrange your ruleset in a multidimensional tree which drastically reduces the number of rules that need to be inspected until reaching the final action on a packet.
