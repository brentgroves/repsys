# **[configure chains](https://wiki.nftables.org/wiki-nftables/index.php/Configuring_chains)**

Configuring chains
Jump to navigationJump to search
As in iptables, with nftables you attach your rules to chains. Unlike in iptables, there are no predefined chains like INPUT, OUTPUT, etc. Instead, to filter packets at a particular processing step, you explicitly create a base chain with name of your choosing, and attach it to the appropriate Netfilter hook. This allows very flexible configurations without slowing Netfilter down with built-in chains not needed by your ruleset.

## Base chain priority

Each nftables base chain is assigned a priority that defines its ordering among other base chains, flowtables, and Netfilter internal operations at the same hook. For example, a chain on the prerouting hook with priority -300 will be placed before connection tracking operations.

NOTE: If a packet is accepted and there is another chain, bearing the same hook type and with a later priority, then the packet will subsequently traverse this other chain. Hence, an accept verdict - be it by way of a rule or the default chain policy - isn't necessarily final. However, the same is not true of packets that are subjected to a drop verdict. Instead, drops take immediate effect, with no further rules or chains being evaluated.

The following ruleset demonstrates this potentially surprising distinction in behaviour:

```bash
table inet filter {
        # This chain is evaluated first due to priority
        chain services {
                type filter hook input priority 0; policy accept;

                # If matched, this rule will prevent any further evaluation
                tcp dport http drop

                # If matched, and despite the accept verdict, the packet proceeds to enter the chain below
                tcp dport ssh accept

                # Likewise for any packets that get this far and hit the default policy
        }

        # This chain is evaluated last due to priority
        chain input {
                type filter hook input priority 1; policy drop;
                # All ingress packets end up being dropped here!
        }
}
```

If the priority of the 'input' chain above were to be changed to -1, the only difference would be that no packets have the opportunity to enter the 'services' chain. Either way, this ruleset will result in all ingress packets being dropped.

In summary, packets will traverse all of the chains within the scope of a given hook until they are either dropped or no more base chains exist. An accept verdict is only guaranteed to be final in the case that there is no later chain bearing the same type of hook as the chain that the packet originally entered.

Netfilter's hook execution mechanism is described in more detail in Pablo's paper on connection tracking.

## Base chain policy

This is the default verdict that will be applied to packets reaching the end of the chain (i.e, no more rules to be evaluated against).

Currently there are 2 policies: accept (default) or drop.

- The accept verdict means that the packet will keep traversing the network stack (default).
- The drop verdict means that the packet is discarded if the packet reaches the end of the base chain.
NOTE: If no policy is explicitly selected, the default policy accept will be used.

## Adding regular chains

You can also create regular chains, analogous to iptables user-defined chains:

```bash
# nft -i
nft> add chain [family] <table_name> <chain_name> [{ [policy <policy> ;] [comment "text comment about this chain" ;] }]
```

The chain name is an arbitrary string, with arbitrary case.

Note that no hook keyword is included when adding a regular chain. Because it is not attached to a Netfilter hook, by itself a regular chain does not see any traffic. But one or more base chains can include rules that jump or goto this chain -- following which, the regular chain processes packets in exactly the same way as the calling base chain. It can be very useful to arrange your ruleset into a tree of base and regular chains by using the jump and/or goto actions. (Though we're getting a bit ahead of ourselves, nftables vmaps provide an even more powerful way to construct highly-efficient branched rulesets.)

## Deleting chains

You can delete chains as:

```bash
% nft delete chain [family] <table_name> <chain_name>
```

The only condition is that the chain you want to delete needs to be empty, otherwise the kernel will complain that the chain is still in use.

```bash
% nft delete chain ip foo input
<cmdline>:1:1-28: Error: Could not delete chain: Device or resource busy
delete chain ip foo input
^^^^^^^^^^^^^^^^^^^^^^^^^
You will have to flush the ruleset in that chain before you can remove the chain.
```

## Flushing chains

To flush (delete all of the rules in) the chain input of the foo table:

```nft flush chain foo input```

## Example configuration: Filtering traffic for your standalone computer

You can create a table with two base chains to define rule to filter traffic coming to and leaving from your computer, asumming IPv4 connectivity:

```bash
% nft add table ip filter
% nft 'add chain ip filter input { type filter hook input priority 0 ; }'
% nft 'add chain ip filter output { type filter hook output priority 0 ; }'
```

Now, you can start attaching rules to these two base chains. Note that you don't need the forward chain in this case since this example assumes that you're configuring nftables to filter traffic for a standalone computer that doesn't behave as router.
