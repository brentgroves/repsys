# **[ss command: Display Linux TCP / UDP Network/Socket Information](https://www.cyberciti.biz/tips/linux-investigate-sockets-network-connections.html)**

**[Back to Research List](../../../../../research_list.md)**\
**[Back to Current Tasks](../../../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../../../README.md)**

The ss command is used to show socket statistics. It can display stats for PACKET sockets, TCP sockets, UDP sockets, DCCP sockets, RAW sockets, Unix domain sockets, and more. It allows showing information similar to netstat command. It can display more TCP and state information than other tools. It is a new, incredibly useful and faster (as compared to netstat) tool for tracking TCP connections and sockets. SS can provide information about:

- All TCP sockets.
- All UDP sockets.
- All established ssh / ftp / http / https connections.
- All local processes connected to X server.
- Filtering by state (such as connected, synchronized, SYN-RECV, SYN-SENT,TIME-WAIT), addresses and ports.
- All the tcp sockets in state FIN-WAIT-1 and much more.

How to display sockets summary with ss command
List currently established, closed, orphaned and waiting TCP sockets, enter:
ss -s

Sample Output:

Total: 734 (kernel 904)
TCP:   1415 (estab 112, closed 1259, orphaned 11, synrecv 0, timewait 1258/0), ports 566

Transport Total     IP        IPv6

- 904       -         -

RAW   0         0         0
UDP   15        12        3
TCP   156       134       22
INET   171       146       25
FRAG   0         0         0

How to display all open network ports with ss command on Linux
ss -l

Type the following to see process named using open socket:
ss -pl

Find out **[who is responsible for opening socket / port # 4949 using the ss command](https://www.cyberciti.biz/tips/linux-display-open-ports-owner.html)** and grep command:
ss -lp | grep 4949

munin-node (PID # 3772) is responsible for opening port # 4949. You can get more information about this process (like memory used, users, current working directory and so on) visiting /proc/3772 directory:
cd /proc/3772
ls -l

Display All Established SMTP Connections
ss -o state established '( dport = :smtp or sport = :smtp )'

Display All Established HTTP Connections
ss -o state established '( dport = :http or sport = :http )'
