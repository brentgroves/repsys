# SSH tunnelling

## references

<https://linuxize.com/post/how-to-setup-ssh-tunneling/>

## How to Set up SSH Tunneling (Port Forwarding)

![](https://linuxize.com/post/how-to-setup-ssh-tunneling/featured_hue1c954e34e19ec8ebc68aff9e2e67e75_25546_768x0_resize_q75_lanczos.jpg)

SSH tunneling or SSH port forwarding is a method of creating an encrypted SSH connection between a client and a server machine through which services ports can be relayed.

SSH forwarding is useful for transporting network data of services that use an unencrypted protocol, such as VNC or FTP , accessing geo-restricted content, or bypassing intermediate firewalls. Basically, you can forward any TCP port and tunnel the traffic over a secure SSH connection.

## There are three types of SSH port forwarding

- Local Port Forwarding. - Forwards a connection from the client host to the SSH server host and then to the destination host port.
- Remote Port Forwarding. - Forwards a port from the server host to the client host and then to the destination host port.
- Dynamic Port Forwarding. - Creates a SOCKS proxy server that allows communication across a range of ports.
