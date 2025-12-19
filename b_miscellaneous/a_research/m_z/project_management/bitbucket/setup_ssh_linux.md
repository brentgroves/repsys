# **[Set up personal SSH keys on Linux](https://support.atlassian.com/bitbucket-cloud/docs/set-up-personal-ssh-keys-on-linux/)**

## check access

```bash
curl https://bitbucket.org/site/ssh
```

The Secure Shell protocol (SSH) is used to create secure connections between your device and Bitbucket Cloud. The connection is authenticated using public SSH keys, which are derived from a private SSH key (also known as a private/public key pair). The secure (encrypted) connection is used to securely transmit your source code between your local device and Bitbucket Cloud. To set up your device for connecting Bitbucket Cloud using SSH, you need to:

1. Install OpenSSH on your device.
2. Start the SSH Agent.
3. Create an SSH key pair.
4. Add your key to the SSH agent.
5. Provide Bitbucket Cloud with your public key.
6. Check that your SSH authentication works.

## Create an SSH key pair

To create an SSH key pair:

1. Open a terminal and navigate to your home or user directory using cd, for example:

    `cd ~`
2. Generate a SSH key pair using ssh-keygen, such as:

```bash
ssh-keygen -t ed25519 -b 4096 -C "{<username@emaildomain.com>}" -f ~/.ssh/{ssh-key-name}
```

Where:

- {<username@emaildomain.com>} is the email address associated with the Bitbucket Cloud account, such as your work email account.

- {ssh-key-name} is the output filename for the keys. We recommend using a identifiable name such as bitbucket_work.
