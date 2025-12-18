# Where to put Unix sockets?

## references

<https://superuser.com/questions/482977/where-to-put-unix-sockets>

The defaults I find are usually good. Unix sockets only live while the program is running, so /tmp/ is usually an alright place for them to live, some programs chose to put them into /var/run/ (since while they are in essence "temporary", they have persistent names).

Most clients will look for sockets in the default place first, so changing the default socket location may require additional configuration in clients trying to use that service.
