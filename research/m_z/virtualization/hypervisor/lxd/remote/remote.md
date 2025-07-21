# **[](https://documentation.ubuntu.com/lxd/en/latest/remotes/#:~:text=The%20LXD%20command%2Dline%20client,See%20the%20following%20example%20configuration:)**

## ai

To configure a remote LXD server, use the lxc remote add command, followed by a unique name for the remote and the server's address. You'll likely be prompted for a trust password or token to authenticate. Once added, you can manage the remote server using the LXD client.

Here's a more detailed explanation:
Add the remote: Use the lxc remote add <remote_name> <remote_address> command, replacing <remote_name> with a chosen name for the remote and <remote_address> with the server's address (e.g., an IP address or hostname).
Authentication: LXD will attempt to authenticate you using TLS certificates. If a trust password is set, you'll be prompted for it. If not, the connection might be rejected.
Token-based authentication: LXD also supports token-based authentication. You can generate a token on the server using lxc config trust add and use it with the lxc remote add command on the client.
Switching remotes: To switch the default remote, use lxc remote switch <remote_name>.
Listing remotes: Use lxc remote list to see all configured remotes.
Global configuration: You can configure remotes on a system-wide basis by editing the global configuration file (e.g., /etc/lxd/config.yml or /var/snap/lxd/common/global-conf/config.yml for the snap version).
Certificate storage: Certificates for remotes should be stored in the servercerts directory within the configuration directory (e.g., /etc/lxd/servercerts/ or /var/snap/lxd/common/global-conf/servercerts/).
