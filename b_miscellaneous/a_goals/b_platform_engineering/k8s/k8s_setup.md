# Structures K8S Clusters Setup

Hi Team,

I wanted to share the Structures K8S setup and pull our resource knowledge to find the most reliable on-prem K8S solution.

-Thanks

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

The Structures K8S Clusters are set up in this way:

- 3 Dell PowerEdge R620 servers with 128 GB RAM and 2 TB EVO SSD storage each.
- The **[MicroCloud (LXD, OVN, Ceph Clusters)](https://documentation.ubuntu.com/microcloud/v2-edge/microcloud/)** is the base.
![mc](https://documentation.ubuntu.com/microcloud/v2-edge/microcloud/_images/microcloud_basic_architecture.svg)
- One 3-node **[MicroK8S cluster](https://www.sysdig.com/learn-cloud-native/what-is-microk8s)** is running on each physical server.
- Identical software is running on each MicroK8S Cluster.
- **[HAProxy/Keepalived load-balancer](https://sysadmins.co.za/achieving-high-availability-with-haproxy-and-keepalived-building-a-redundant-load-balancer/)** is configured with 1 primary and 2 standby servers.  

## Usage

Keepalived monitors the health of the servers, and if an issue is detected with the primary server, one of the standby servers will be promoted to primary without interruption.

![i1](https://miro.medium.com/v2/resize:fit:720/format:webp/1*KoHLpnJkX095OmTtGElIUA.png)

## Other MicroCloud Features

- **[OVN SDN controller Cluster](https://ubuntu.com/blog/data-centre-networking-what-is-ovn#:~:text=Each%20transport%20node%20also%20hosts%20an%20Open,ovsdb%2Dserver%20to%20monitor%20and%20control%20OVS%20configuration.)**

![o](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,c_fill,w_1600,h_1209/https%3A%2F%2Fubuntu.com%2Fwp-content%2Fuploads%2Fd5c3%2Fimage.png)

- **[Ceph Storage Cluster](https://docs.ceph.com/en/reef/architecture/)**
![i1](https://docs.ceph.com/en/reef/_images/stack.png)

## reference

**[Keepalived](https://www.youtube.com/watch?v=hPfk0qd4xEY&t=9s)**

## K8S team

- Kristian Smith: Global Directory IT
- Adrian Wise: System Admin, Technical Services Manager.
- Ramarao Guttikonda, Senior System Administrator
- Aamir Ghaffar: IT Systems Architect
- Justin Langille, Network Technician
- Christian. Trujillo, IT Structures Manager
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Hayley Rymer, IT Supervisor
