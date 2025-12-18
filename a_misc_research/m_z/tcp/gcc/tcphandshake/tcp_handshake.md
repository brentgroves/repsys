# **[Implement TCP hand shake in C](https://stackoverflow.com/questions/26323249/implement-tcp-hand-shake-in-c)**

**[Back to Research List](../../../../../research_list.md)**\
**[Back to Current Tasks](../../../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../../../README.md)**

I've used TCP raw sockets to implement a simple TCP handshake in order create a simple port scanner, In this port scanner I want to follow method half-open. As we know in this method, we first send a SYN packet to the remote host and then:

If host responds with SYN/ACK then that port is open and we should reset the connection.
If host responds with RST then that port is closed and we'r done.
If host does not respond then we can consider that port is filtered.
