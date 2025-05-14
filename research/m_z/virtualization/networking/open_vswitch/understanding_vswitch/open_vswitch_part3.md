# **[Understanding Open vSwitch: Part 3](https://medium.com/@ozcankasal/understanding-open-vswitch-part-3-3c04e03dbda9)**

**[Back to Research List](../../../../research_list.md)**\
**[Back to Current Status](../../../../../a_status/weekly/current_status.md)**\
**[Back to Main](../../../../../README.md)**

## referenences

- **[This author series](https://medium.com/@ozcankasal)**
- **[Open VSwitch with KVM](https://docs.openvswitch.org/en/latest/howto/kvm/)**
- **[Open VSwitch tutorial](https://medium.com/@ozcankasal/understanding-open-vswitch-part-1-fd75e32794e4)**
- **[Open VSwitch and Windows](https://docs.openvswitch.org/en/latest/topics/windows/)**
- **[open vswitch and ExtremeXOS](https://documentation.extremenetworks.com/exos_22.1/GUID-29B4C015-BDBC-4D79-8CEF-3BDA3D57E676.shtml)**
- **[open vswitch and docker overlay](https://medium.com/@technbd/multi-hosts-container-networking-a-practical-guide-to-open-vswitch-vxlan-and-docker-overlay-70ec81432092)**

In the first part of our Open vSwitch series, we covered the basics, setting up a simple switch with one bridge and two ports sharing a common VLAN tag. In Part 2, we explored OpenFlow rules with a single bridge and two ports, each having different VLAN tags.

Now, in Part 3, we’re taking it a step further. We’ll look into a network setup with two bridges, each having one port with the same VLAN tag. This means extending a VLAN across two bridges at L2 level. To make this work, we’ll introduce patch ports between the bridges, explaining how they enable smooth communication and VLAN extension in this more complex setup.
