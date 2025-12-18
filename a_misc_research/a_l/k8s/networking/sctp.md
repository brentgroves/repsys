# Stream Control Transmission Protocol

## references

<https://www.geeksforgeeks.org/sctp-full-form/>

SCTP stands for Stream Control Transmission Protocol.

It is a connection- oriented protocol in computer networks which provides a full-duplex association i.e., transmitting multiple streams of data between two end points at the same time that have established a connection in network. It is sometimes referred to as next generation TCP or TCPng, SCTP makes it easier to support telephonic conversation on Internet. A telephonic conversation requires transmitting of voice along with other data at the same time on both ends, SCTP protocol makes it easier to establish reliable connection.

SCTP is also intended to make it easier to establish connection over wireless network and managing transmission of multimedia data. SCTP is a standard protocol (RFC 2960) and is developed by Internet Engineering Task Force (IETF).

Characteristics of SCTP :

Unicast with Multiple properties –
It is a point-to-point protocol which can use different paths to reach end host.
Reliable Transmission –
It uses SACK and checksums to detect damaged, corrupted, discarded, duplicate and reordered data. It is similar to TCP but SCTP is more efficient when it comes to reordering of data.
Message oriented –
Each message can be framed and we can keep order of datastream and tabs on structure. For this, In TCP, we need a different layer for abstraction.
Multi-homing –
It can establish multiple connection paths between two end points and does not need to rely on IP layer for resilience.
Security –
Another characteristic of SCTP that is  security. In SCTP, resource allocation for association establishment only takes place following cookie exchange identification verification for the client (INIT ACK). Man-in-the-middle and denial-of-service attacks are less likely as a result. Furthermore, SCTP doesn’t allow for half-open connections, making it more resistant to network floods and masquerade attacks.
Advantages of SCTP :

It is a full- duplex connection i.e. users can send and receive data simultaneously.
It allows half- closed connections.
The message’s boundaries are maintained and application doesn’t have to split messages.
It has properties of both TCP and UDP protocol.
It doesn’t rely on IP layer for resilience of paths.
Disadvantages of SCTP :

One of key challenges is that it requires changes in transport stack on node.
Applications need to be modified to use SCTP instead of TCP/UDP.
Applications need to be modified to handle multiple simultaneous streams.
