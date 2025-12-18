# - **[Install and configure Postfix](https://documentation.ubuntu.com/server/how-to/mail-services/install-postfix/index.html)**

**[Current Tasks](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Install Postfix

To install **[Postfix](https://www.postfix.org/)** run the following command:

Open your terminal and run:

```bash
sudo apt update && sudo apt install postfix
```

It is OK to accept defaults initially by pressing return for each question. Some of the configuration options will be investigated in greater detail in the configuration stage.

### Warning

The mail-stack-delivery metapackage has been deprecated in Focal. The package still exists for compatibility reasons, but won’t setup a working email system.

## Configure Postfix

There are four things you should decide before configuring:

1. The <Domain> for which you’ll accept email (we’ll use mail.example.com in our example)
2. The network and class range of your mail server (we’ll use 192.168.0.0/24)
3. The username (we’re using steve)
4. Type of mailbox format (mbox is the default, but we’ll use the alternative, Maildir)
