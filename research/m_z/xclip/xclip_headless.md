# **[xclip headless](https://www.cyberciti.biz/faq/linux-unix-macos-fix-error-cant-open-display-null-with-ssh-xclip-command-in-headless/)**

On your Linux or Unix desktop client, edit the ~/.ssh/config file and add ForwardX11 yes directive. For example:
vim ~/.ssh/config

Set it as follows for all or selected host:

```bash
Host research01
    ForwardX11 yes
# Host *
    # ForwardX11 yes

```

Save and close the file.

Next log into your ssh server:

```bash
ssh user@server-ip-here
ssh vivek@ln.cbz-www-004
```

Edit the /etc/ssh/sshd_config file using a text editor such as Vim or nano. For instance:

`sudo vim /etc/ssh/sshd_config`

Append or set X11Forwarding to yes as follows:

`X11Forwarding yes`

Save and close the file. Restart or reload the sshd service. For example, here is how to restart ssh on Linux with systemd:
`sudo systemctl restart ssh.service`

Log in using the ssh command and enable X11 forwarding when log into the remote server. On macOS, you may need to pass the -Y option if -X is not working out for you. For example:

```bash
# ssh -X vivek@ln.cbz-www-004
ssh -X brent@research01

```

## AI Overview

x11 connection rejection because of wrong authentication

Try: dont open with sudo command.

AI Overview
The error "X11 connection rejected because of wrong authentication" often arises when you're trying to forward an X11 session over SSH, particularly when switching users (like using sudo or su) or when running applications as root. This usually means the root user's X authority file (.Xauthority) doesn't have the necessary credentials for the display you're trying to use.
Here's a breakdown of common causes and solutions:

1. Incorrect Authentication Credentials for Root:
Problem:
When you switch to root (e.g., using sudo) or run commands as root, the X authority credentials may not be inherited, leading to the error.
Solution:
You need to ensure the root user has the correct authentication credentials for the display. This can be done by:
Merging authentication credentials: Use sudo xauth merge ~/.Xauthority to copy the authentication information from your regular user to the root user's X authority file.
Adding the display information manually: As your regular user, use xauth list to find the display information. Then, as root, use xauth add to add that information to root's X authority file.
2. Permissions Issues:
Problem:
The .Xauthority file might have incorrect permissions, preventing the X server from accessing it.
Solution:
Ensure the .Xauthority file is writable only by the owner (usually 600 permissions).
3. X11 Forwarding Not Enabled:
Problem: X11 forwarding may not be enabled on the SSH server or client.
Solution:
Server-side: Ensure X11Forwarding yes is set in the SSH server configuration (/etc/ssh/sshd_config).
Client-side: Use the -X option when connecting via SSH to enable X11 forwarding.
4. Other Potential Issues:
SELinux:
.
If you're using SELinux, it might be preventing X11 forwarding. Check the SELinux logs and try temporarily disabling SELinux for testing purposes.
Disk Space:
.
Low disk space can interfere with creating or updating the X authority file.
Encrypted Home Directory:
.
If your home directory is encrypted, you might need to mount it properly before X11 forwarding works.
Troubleshooting Steps:
Check SSH Forwarding: Verify that X11 forwarding is enabled on both the client and server.
Examine X Authority File: Ensure the .Xauthority file is present and has the correct permissions.
Merge or Add Credentials: Use sudo xauth merge ~/.Xauthority or manually add the display information as described above.
Check for Disk Space Issues: Ensure you have enough disk space.
Investigate SELinux: If you suspect SELinux, temporarily disable it and see if that resolves the issue.
Check for Encrypted Home Directory: If your home directory is encrypted, try mounting it correctly.

## **[answer](https://stackoverflow.com/questions/18695934/error-cant-open-display-null-when-using-xclip-to-copy-ssh-public-key)**

This was too good of an answer not to post it here. It's from Gilles, an askubuntu fellow:

The clipboard is provided by the X server. It doesn't matter whether the server is headless or not, what matters is that your local graphical session is available to programs running on the remote machine. Thanks to X's network-transparent design, this is possible.

I assume that you're connecting to the remote server with SSH from a machine running Linux. Make sure that X11 forwarding is enabled both in the client configuration and in the server configuration. In the client configuration, you need to have the line ForwardX11 yes in ~/.ssh/config to have it on by default, or pass the option -X to the ssh command just for that session. In the server configuration, you need to have the line X11Forwarding yes in /etc/ssh/sshd_config (it is present by default on Ubuntu).

To check whether X11 forwarding is enabled, look at the value of the DISPLAY environment variable: echo $DISPLAY. You should see a value like localhost:10 (applications running on the remote machine are told to connect to a display running on the same machine, but that display connection is in fact forwarded by SSH to your client-side display). Note that if DISPLAY isn't set, it's no use setting it manually: the environment variable is always set correctly if the forwarding is in place. If you need to diagnose SSH connection issues, pass the option -vvv to ssh to get a detailed trace of what's happening.

If you're connecting through some other means, you may or may not be able to achieve X11 forwarding. If your client is running Windows, PuTTY supports X11 forwarding; you'll have to run an X server on the Windows machine such as Xming.

By Gilles from askubuntu
