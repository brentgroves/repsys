
# Marposs gauge

Hi Team,

Happy Friday! I can setup the Serial device server and help configure the Marposs dimensional guage. Jared has had previous experience working the Marposs so he is taking a look at it also.

Thanks,
Brent

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
