
# Marposs gauge

Hi Team,

Happy Friday! I can setup the Serial device server and help configure the Marposs dimensional guage. Jared has had previous experience working the Marposs so he is taking a look at it also.

Thanks,
Brent

Status:

The serial device server is now running on socket 10.188.74.11/4065.  Thank you Jared for creating the VLAN!

Currently, it is connected to a computer and not a gauge.  A program is sending a number from 1 to 10 every 2 seconds.

Next I need to configure Merlin with qualities help.

We also will need another network drop for the long term but we could test with the one that is there already.

Thank you Carl for ordering a db9 F/F cable!

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

## Tasks

- Set up serial device server on research11 with server VLAN IP.

## Oct 30 Meeting

- meeting with Marposs techical support.
- get recommended serial device server.
- configure Marposs
  - output data to serial port
  - output csv file to windows share
  - Include if there was a tool change in output
  
## CSV PROS

- Marposs gauage is a full computer and is connected to the network via a network cable but no testing was done on it yet. Config request to connect it to a shared folder.
- data is formatted and available in a CSV file on a network drive.

## CSV CONS

- Don't know when each row is added to the CSV file

## CSV solution

- Cron job copies active CSV to working CSV and parses it.
- Then updates KepServerEx OPCUA data point with each row of the CSV giving Mach2 enough time to process each row.

## Serial device server PROS

- Use case is similar to collecting scale weight and this is how Mach2 is made to work.

## Serial device server CONS

- Marpose gauge does not have a serial device server attached and would need configured to output data to the com port.
- Since gauge is already attached to the network we would need to install and configure a network switch for the serial device server.

## Serial device server solution

- Attach and configure a serial device server to a network switch.
- Program gauge to output dimensional data.
- Connect to socket from Mach2.
- Parse incoming data.
