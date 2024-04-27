# Install OpenStack

## references

<https://opendev.org/openstack/devstack>

<https://medium.com/@kcoupal/how-to-install-openstack-on-ubuntu-22-04-with-devstack-3336c01ddcfa>

## How to Install OpenStack on Ubuntu 22.04 with DevStack

### What is OpenStack?

OpenStack is a free, open standard cloud computing platform. It is mostly deployed as infrastructure-as-a-service in public and private clouds where virtual servers and other resources are available to users.

### Whats is DevStack?

Devstack is a series of scripts used to quickly bring up a complete OpenStack environment. We can download the latest version of OpenStack from the git master branch. It used to set up a faster and quicker way to set up the development environment and as the basis for most of the OpenStack project functional testing.

### Minimum Requirements

Before we begin, ensure you have the following minimum prerequisites

- A fresh Ubuntu 22.04 installation
- User with sudo privileges
- 4 GB RAM
- 2 vCPUs
- Hard disk capacity of 10 GB
- Internet connection

### Step 1: Update and Upgrade the System

**[DEVSTACK](https://opendev.org/openstack/devstack)** RECOMMENDS DOING THIS ON A VM OR SYSTEM YOU DON'T CARE ABOUT.

To start off, log into your Ubuntu 22.04 system using SSH protocol and update & upgrade system repositories using the following command.

### Step 2: Create Stack user and assign sudo priviledge

Best practice demands that devstack should be run as a regular user with sudo privileges. With that in mind, we are going to add a new user called “stack” and assign sudo privileges. To create stack user execute

```bash
sudo adduser -s /bin/bash -d /opt/stack -m stack
sudo chmod +x /opt/stack
```

Next, run the command below to assign sudo privileges to the user

```bash
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
```

### Step 3: Install git and download DevStack

Once you have successfully created the user ‘stack’ and assigned sudo privileges, switch to the user using the command.

```bash
su - stack
```

In most Ubuntu 22.04 systems, git comes already installed. If by any chance git is missing, install it by running the following command.

```bash
sudo apt install git -y
```

Using git, clone devstack’s git repository as shown.

```bash
cd ~/src
git clone https://git.openstack.org/openstack-dev/devstack
```

### Step 4: Create devstack configuration file

In this step, navigate to the devstack directory.

```bash
cd ~/src/devstack
```

Then create a local.conf configuration file.

```bash
code local.conf
```

Paste the following content

```conf
[[local|localrc]]
# Password for KeyStone, Database, RabbitMQ and Service
ADMIN_PASSWORD=StrongAdminSecret
DATABASE_PASSWORD=$ADMIN_PASSWORD
RABBIT_PASSWORD=$ADMIN_PASSWORD
SERVICE_PASSWORD=$ADMIN_PASSWORD
# Host IP - get your Server/VM IP address from ip addr command
HOST_IP=10.208.0.10
```

Save and exit the text editor. NOTE:

The ADMIN_PASSWORD is the password that you will use to log in to the OpenStack login page. The default username is admin.
The HOST_IP is your system’s IP address that is obtained by running ifconfig or ip addr commands.

### Step 5: Install OpenStack with Devstack

To commence the installation of OpenStack on Ubuntu 22.04, run the script below contained in devstack directory.

```bash
./stack.sh
```

The following features will be installed:

Horizon — OpenStack Dashboard
Nova — Compute Service
Glance — Image Service
Neutron — Network Service
Keystone — Identity Service
Cinder — Block Storage Service
Placement — **[Placement API](https://docs.openstack.org/api-ref/placement/)**

The deployment takes about 10 to 15 minutes depending on the speed of your system and internet connection. In our case, it took roughly 12 minutes. At the very end, you should see output similar to what we have below.

![](https://miro.medium.com/v2/resize:fit:4800/format:webp/0*roHTfRye_CN5tyO6.jpg)

This confirms that all went well and that we can proceed to access OpenStack via a web browser.

## Step 6: Accessing OpenStack on a web browser

To access OpenStack via a web browser browse your Ubuntu’s IP address as shown. <https://server-ip/dashboard> This directs you to a login page as shown.

![](https://miro.medium.com/v2/resize:fit:640/format:webp/0*ACjue7WCslkHjP4C.png)

Enter the credentials and hit “Sign In” You should be able to see the Management console dashboard as shown below.

![](https://miro.medium.com/v2/resize:fit:720/format:webp/0*dya1n9DWtYUeCF4E.png)
