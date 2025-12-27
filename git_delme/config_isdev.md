Host ssh.dev.azure.com
    User git
    PubkeyAcceptedAlgorithms +ssh-rsa
    HostkeyAlgorithms +ssh-rsa

```toml
# brent_admin work account
Host bitbucket.org-brent_admin
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/bitbucket_isdev
  IdentitiesOnly yes

# brent_groves personal account
Host bitbucket.org-brent_groves
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/bitbucket_personal
  IdentitiesOnly yes

# Default configuration for other hosts (optional)
Host *
  AddKeysToAgent yes  
```
