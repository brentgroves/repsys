# hostname parameter

**[Ubuntu 22.04 Desktop](../../../linux/ubuntu22-04/desktop-install.md)**\
**[Ubuntu 22.04 Server](../../../linux/ubuntu22-04/server-install.md)**\
**[Back to Main](../../../README.md)**

## references

- **[When to use](https://stackoverflow.com/questions/43031100/when-to-use-hostname-in-docker)**

## when to use

The --hostname flag only changes the hostname inside your container. This may be needed if your application expects a specific value for the hostname. It does not change DNS outside of docker, nor does it change the networking isolation, so it will not allow others to connect to the container with that name.

You can use the container name or the container's (short, 12 character) id to connect from container to container with docker's embedded dns as long as you have both containers on the same network and that network is not the default bridge.

The implication was that the users outside of the container would not be able to resolve the hostname just by setting that value on the container. Inside of docker networking, there's a different DNS. But the statement was also wrong at least with current versions of docker, the hostname is not added as a network alias, only the container id and the container name resolve with the internal docker DNS.
