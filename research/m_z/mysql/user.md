# **[mysql user](https://stackoverflow.com/questions/10823854/using-for-host-when-creating-a-mysql-user)**

My MySQL database needs two users: appuser and support.
One of the application developers insists that I create four accounts for these users:

```mysql
appuser@'%'
appuser@'localhost'
support@'%'
support@'localhost'
```

For the life of me I can't figure out why he thinks we need this. Wouldn't using the wildcard as the host take care of the 'localhost'?

Any ideas?

(Using MySQL 5.5 here)

localhost is special in MySQL, it means a connection over a UNIX socket (or named pipes on Windows, I believe) as opposed to a TCP/IP socket. Using % as the host does not include localhost, hence the need to explicitly specify it.

As @nos pointed out in the comments of the currently accepted answer to this question, the accepted answer is incorrect.

Yes, there IS a difference between using % and localhost for the user account host when connecting via a socket connect instead of a standard TCP/IP connect.

A host value of % does not include localhost for sockets and thus must be specified if you want to connect using that method.

```mysql
update user set host='%' where user='foo'; flush privileges;
```
