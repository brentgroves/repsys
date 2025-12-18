# **[How to install the Containerd runtime engine on Ubuntu Server 22.04](https://www.techrepublic.com/article/install-containerd-ubuntu/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Jack Wallen walks you through the process of manually installing the Containerd container runtime engine on Ubuntu Server 22.04.

Containerd is a container runtime engine created for simplicity and portability. This runtime is considered an industry standard and is available as a daemon for Linux and Windows and can manage the entire container lifecycle for image transfer and storage, container deployment and supervision, storage and network, and more.

SEE: Hiring kit: Back-end Developer (TechRepublic Premium)

I’m going to walk you through the process of installing Containerd on Ubuntu Server 22.04. This isn’t quite as simple as installing the Docker runtime engine, but it’s only just a matter of running a few commands. With the introduction out of the way, let’s get right to the installation.

## How to install Containerd on Ubuntu Server

There are a few pieces to this puzzle, the first of which is the Containerd runtime itself. To begin with, download the Containerd runtime with the command:

```bash
wget https://github.com/containerd/containerd/releases/download/v1.6.8/containerd-1.6.8-linux-amd64.tar.gz
```

Do check the Containerd Download page to ensure you’re downloading the latest release.

Unpack that file into /usr/local/ with the command:

```bash
sudo tar Cxzvf /usr/local containerd-1.6.8-linux-amd64.tar.gz
```

Next, we need the runc command line tool which is used to deploy containers with Containerd. Download this package with:

```bash
wget https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64

sudo install -m 755 runc.amd64 /usr/local/sbin/runc
```

The binary is built statically and should work on any Linux distribution.

Now, we need the Container Network Interface, which is used to provide the necessary networking functionality. Download CNI with:

```bash
wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
```
