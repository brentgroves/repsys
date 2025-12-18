# **[passwordless sudo access](https://www.ibm.com/docs/en/zscc/1.2.1?topic=eylzsdg-enable-passwordless-sudo-access-your-linux-user-id)**

Enable passwordless sudo access for your linux user ID
Last Updated
: 2025-01-30
As the Linux administrator, you must enable passwordless sudo access for your linux user ID.

## About this task

The sudo command allows you to run programs with the security privileges of another user, such as the superuser.

## Procedure

Edit the sudoers file.
The sudoers file is a file that administrators use to allocate system rights to users.

It is recommended that you use the visudo command, rather than editing this file directly:

```bash
sudo visudo
```

Locate the line that contains includedir /etc/sudoers.d
Below that line, add the following command:

```bash
username ALL=(ALL) NOPASSWD: ALL
```

Where username is your passwordless sudo user name.
Save your changes.
To verify that it worked, enter the following commands:

```bash
su - <username>
sudo ip a
```

The sudo command should display all of the IP addresses on the server without prompting you for a password.

## What to do next

Your Linux user ID is able to run sudo <any command> without the need for a sudo password.
