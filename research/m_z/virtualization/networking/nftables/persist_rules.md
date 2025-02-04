# **[NFTables Basics](https://cycle.io/learn/nftables-basics)**

**[Back to Research List](../../../../research_list.md)**\
**[Back to Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../../README.md)**

## reference

- **[gentoo](https://wiki.gentoo.org/wiki/Nftables/Examples)**

## Listing Rules

You can list the rules in your nftables configuration with the following command:

```bash
sudo nft list table inet my_filter_table
```
This command displays all chains and rules within the specified table.

## Saving and Restoring Rules

To ensure that your nftables rules persist across reboots, you need to save them to a file and restore them on startup.

### Saving Rules

You can save the current nftables configuration to a file:

```bash
sudo nft list ruleset > /etc/nftables.conf
```

### Restoring Rules on Boot

To automatically restore nftables rules on boot, you can create a systemd service or modify the nftables service to load the saved configuration:

```bash
sudo systemctl enable nftables
sudo systemctl start nftables
```

Make sure the configuration file is specified in the nftables service configuration.

