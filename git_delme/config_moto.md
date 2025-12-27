Host ssh.dev.azure.com
    User git
    PubkeyAcceptedAlgorithms +ssh-rsa
    HostkeyAlgorithms +ssh-rsa
Host research01
    ForwardX11 yes

# Host bitbucket.org

# AddKeysToAgent yes

# IdentityFile ~/.ssh/bitbucket_home

# brent_admin account
Host bitbucket.org-brent_admin
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/bitbucket_home
  IdentitiesOnly yes
# brent_groves account
Host bitbucket.org-brent_groves
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/bitbucket_personal
  IdentitiesOnly yes

# Default configuration for other hosts (optional)

Host *
  AddKeysToAgent yes  
