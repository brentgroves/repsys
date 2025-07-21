# **[](https://documentation.ubuntu.com/lxd/latest/howto/server_expose/)**

How to expose LXD to the network
By default, LXD can be used only by local users through a Unix socket and is not accessible over the network.

To expose LXD to the network, you must configure it to listen to addresses other than the local Unix socket. To do so, set the core.https_address server configuration option.

For example, allow access to the LXD server on port 8443:
