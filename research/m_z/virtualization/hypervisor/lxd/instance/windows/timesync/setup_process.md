# process

1. ensure w32Time services is set to automatically start at boot even if no one logs in.
2. taskschd.msc create a task to run w32tm /resync at boot
run as administrators group.
