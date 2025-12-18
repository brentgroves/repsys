- How to keep your git directories uptodate with the main branch

```bash
# git@github.com:brentgroves/linux-utils.git
# git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/mobexsql
# git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/reports
# If you want to change anything in them please create a new branch
# At the start of the day you run this command to get repo updates
~/startday.sh
# If you get error messages from ~/startday.sh that means there were changes made in our repo directories.  In that case you can either stash your changes or undo them.
# To undo any changes inadvertantly made in the repo directories run this command which removes the directies and recreates them.
~/freshstart.sh

```