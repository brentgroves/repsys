# **[How to configure Postfix relayhost (smarthost) to send eMail using an external smptd](https://www.cyberciti.biz/faq/how-to-configure-postfix-relayhost-smarthost-to-send-email-using-an-external-smptd/)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

How do I configure Postfix MTA to send eMail using an external cloud-based SMTP server (with username: password) from a web server on Linux or Unix-like system? How do I configure an Ubuntu server and postfix as the relay server (smarthost)?

You can configuring Postfix MTA to use as a Smarthost i.e. routing all mails to a smarthost. A smarthost can be an external smtpd server provided by SendGrid, AWS, Rackspace, Google apps/Gmail, ISP or your own server in another data center. In this tutorial, you will learn how to install a Postfix smtpd and send email through ISP/Google Apps/SendGrid/AWS/Rackspace cloud email services with the help of the relay server.

## Install postfix (if not installed on a web server)

Type the following command to install postfix. Here is how to install the Postfix MTA on a Debian or Ubuntu/Linux mint using the apt command or apt-get command:

`sudo apt install postfix`

You need to select mail server type as prompted by the system:

![i1](https://www.cyberciti.biz/media/new/faq/2016/08/1-1.jpg)

Fig.01: Postfix config during installation on an Ubuntu or Debian server

Select Internet Site as you need to send email out to other email servers:

![i2](https://www.cyberciti.biz/media/new/faq/2016/08/2-1.jpg)

Fig: Select internet site as type of mail configuration

Type fully qualified name of your domain such as bash.cyberciti.biz (or <www.cyberciti.biz>):

![i3](https://www.cyberciti.biz/media/new/faq/2016/08/3-1.jpg)

## Install pluggable authentication modules

You must install the **[libsasl2-modules](https://www.cyberciti.biz/faq/ubuntu-lts-debian-linux-apt-command-examples/)** for authentication purpose using apt command:

`sudo apt install libsasl2-modules postfix`

Sample outputs:

```bash
Reading package lists... Done
Building dependency tree
Reading state information... Done
postfix is already the newest version (3.1.0-3).
Suggested packages:
  libsasl2-modules-otp libsasl2-modules-ldap libsasl2-modules-sql
  libsasl2-modules-gssapi-mit | libsasl2-modules-gssapi-heimdal
The following NEW packages will be installed:
  libsasl2-modules
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 47.5 kB of archives.
After this operation, 227 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 <http://archive.ubuntu.com/ubuntu> xenial/main amd64 libsasl2-modules amd64 2.1.26.dfsg1-14build1 [47.5 kB]
Fetched 47.5 kB in 0s (95.8 kB/s)
Selecting previously unselected package libsasl2-modules:amd64.
(Reading database ... 21643 files and directories currently installed.)
Preparing to unpack .../libsasl2-modules_2.1.26.dfsg1-14build1_amd64.deb ...
Unpacking libsasl2-modules:amd64 (2.1.26.dfsg1-14build1) ...
Setting up libsasl2-modules:amd64 (2.1.26.dfsg1-14build1) ...
```

## Configure myhostname

Edit /etc/postfix/main.cf, enter:

`sudo vi /etc/postfix/main.cf`

Set myhostname to FQDN as configured earlier (see fig.03):

`myhostname = bash.cyberciti.biz`

Save and close the file.

## Setup the relay server

Again open /etc/postfix/main.cf, enter:

`sudo vi /etc/postfix/main.cf`

## Edit/Update it as follows

```bash
# Enable auth

smtp_sasl_auth_enable = yes

# Set username and password

smtp_sasl_password_maps = static:YOUR-SMTP-USER-NAME-HERE:YOUR-SMTP-SERVER-PASSWORD-HERE
smtp_sasl_security_options = noanonymous

# Turn on tls encryption

smtp_tls_security_level = encrypt
header_size_limit = 4096000

# Set external SMTP relay host here IP or hostname accepted along with a port number

relayhost = [YOUR-SMTP-SERVER-IP-HERE]:587

# accept email from our web-server only (adjust to match your VPC/VLAN etc)

inet_interfaces = 127.0.0.1
```

Save and close the file. Since you changed to inet_interfaces, stop and start Postfix, type:

```bash
sudo systemctl stop postfix
sudo systemctl start postfix

# OR
sudo systemctl restart postfix
```

Verify that TCP port #25 is in listing state on 127.0.0.1 using the netstat command or ss command:

```bash
sudo ss -tulpn | grep 25
netstat -tulpn | grep :25
```
