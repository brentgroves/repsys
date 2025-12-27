# **[Managing multiple Bitbucket user SSH keys on one device](https://support.atlassian.com/bitbucket-cloud/docs/managing-multiple-bitbucket-user-ssh-keys-on-one-device/)**

If you have more than one Bitbucket Cloud account (such as a personal account and a work account), some additional configuration is required to use two (or more) accounts on the same device. This additional configurations ensures that Git connects to Bitbucket as the correct user for each repository cloned to your device. Due to the differences between operating systems and SSH-based access methods (Personal SSH Keys and Access Keys), this guide should be read alongside the relevant **[SSH setup guide for your operating system](https://support.atlassian.com/bitbucket-cloud/docs/configure-ssh-and-two-step-verification/)**.

## 1. Check that SSH is installed and the SSH Agent is started (see the relevant SSH setup guide for your operating system)

## 2. Create an SSH key pair for each account, such as

```bash
# ssh-keygen -t ed25519 -b 4096 -C "{username@emaildomain.com}" -f {ssh-key-name}
# laptop work account
ssh-keygen -t ed25519 -b 4096 -C "brent.groves@linamar.com" -f ~/.ssh/bitbucket_isdev
# moto work account
ssh-keygen -t ed25519 -b 4096 -C "brent.groves@linamar.com" -f ~/.ssh/bitbucket_home
# all machines personal account
ssh-keygen -t ed25519 -b 4096 -C "brent.groves@gmail.com" -f ~/.ssh/bitbucket_personal

```

## 3. Add each private key to the SSH agent, such as

```bash
# ssh-add ~/.ssh/{ssh-key-name}
# laptop work account
ssh-add ~/.ssh/bitbucket_isdev
Identity added: /home/brent/.ssh/bitbucket_isdev (brent.groves@linamar.com)
# moto work account
ssh-add ~/.ssh/bitbucket_home
Identity added: /home/brent/.ssh/bitbucket_isdev (brent.groves@linamar.com)
# all machines personal account
ssh-add ~/.ssh/bitbucket_personal

```

## 4. Add each private key to the SSH configuration, such as

The following is an example look in git directory for actual config files.

```toml
#brent_admin account
Host bitbucket.org-brent_admin
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/bitbucket_home
  IdentitiesOnly yes
#brent_groves account
Host bitbucket.org-brent_groves
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/bitbucket_personal
  IdentitiesOnly yes
```

Where bitbucket_username1 and bitbucket_username2 are the Bitbucket usernames of the two accounts the SSH keys were created for. Your Bitbucket username is listed under Bitbucket profile settings on your **[Bitbucket Personal settings](https://bitbucket.org/account/settings/)** page.

## 5. Provide Bitbucket Cloud with your public key

To add an SSH key to your user account:

1. Select the Settings cog on the top navigation bar.
2. From the Settings dropdown menu, select Personal Bitbucket settings.
3. Under Security, select SSH keys.
4. Select Add key.
5. In the Add SSH key dialog, provide a Label to help you identify which key you are adding. For example, Work Laptop <Manufacturer> <Model>. A meaningful label will help you identify old or unwanted keys in the future.
6. Copy the contents of the public key file and paste the key into the Key field of the Add SSH key dialog.

Copy and paste your key with

```bash
# laptop work account
cat ~/.ssh/bitbucket_isdev.pub | xclip -selection clipboard
# moto work account
cat ~/.ssh/bitbucket_home.pub | xclip -selection clipboard
# all machines personal account
cat ~/.ssh/bitbucket_personal.pub | xclip -selection clipboard

```

1. Under Expiry, select No expiry to not set an expiry date, or select Expires on and then select the date picker to set a specific date for your SSH key to expire. Note: The default date range for expiry is set to 365 days (one year) from today’s date.

2. Select Add key.

If the key is added successfully, the dialog will close and the key will be listed on the SSH keys page.

If you receive the error That SSH key is invalid, check that you copied the entire contents of the public key (.pub file).

## Check that your SSH authentication works

Since I have configured 2 bitbucket accounts in SSH I don't know if this is valid.
To test that the SSH key was added successfully, open a terminal on your device and run the following command:

```bash
# personal account
ssh -T git@bitbucket.org-brent_groves
authenticated via ssh key.
You can use git to connect to Bitbucket. Shell access is disabled

# work account
ssh -T git@bitbucket.org-brent_admin 
authenticated via ssh key.
You can use git to connect to Bitbucket. Shell access is disabled

```

If SSH can successfully connect with Bitbucket using your SSH keys, the command will produce output similar to:

authenticated via ssh key.
You can use git to connect to Bitbucket. Shell access is disabled

1. Clone repositories or update the git remote for repositories already cloned.

To clone a repository, use the git clone command with the updated host bitbucket.org-{bitbucket_username}, such as:

```bash
# git clone git@bitbucket.org-{bitbucket_username}:{workspace}/{repo}.git
# personal account
git clone git@bitbucket.org-brent_groves:biokr/biokr.git
# work account
git clone git@bitbucket.org-brent_admin:liokr/liokr.git
```
