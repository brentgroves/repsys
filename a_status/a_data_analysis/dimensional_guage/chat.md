# Marposs dimensional gauge project

Status:

- A new VLAN is being created for JT Fronts
- After VLAN has been created the edge switches need to be configured for it.
- The Moxa serial device server has an IP of 10.188.74.11 and is being tested from Avilla IT office using a test switch not connected to the network.
- Need time on the Marposs gauge with quality eng/tech.

Choices:

1. Do we use Moxa serial device server in UDP/TCP server mode

    - UDP
      - Moxa UDP mode broadcasts to multiple IPs
      - connectionless/faster
      - less phone calls
      - Don't know if Mach2 can listen for UDP datagrams on a specific socket.
    - TCP
      - Moxa TCP mode allows multiple connections upto 8
      - connections made/slower
      - if connection is lost someone may have to intervene or reset something.

2. Should we connect Mach2 to KepServerEx OCP UA data point or directly to Moxa serial device server via a socket.

## KepServerEx - OPC UA data points

- create UDP/TCP listener/connection to moxa serial device server for trouble shooting
- Using OPC UA ensures secure data exchange through encryption and certificate-based authentication, protecting the data as it travels from KEPServerEX to Mach2.

## Trouble Shooting

No matter how Mach2 connects, UDP/TCP, to the Moxa serial device server we could also connect to it from KepServerEx so we can have an OPC UA data point available to monitor the Moxa serial device server and Marposs gauge independantly from Mach2. KepServerEx can listen for UDP datagrams on a socket so that is not an issue with it.

- Python
the ip address will be 10.188.74.11 but we must wait for corporate to setup vlan and Jared to configure edge switch
