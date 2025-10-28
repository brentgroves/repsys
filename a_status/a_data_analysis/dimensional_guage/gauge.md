
# Marposs gauge

Hi Team,

Marposs dimensional guage options: We can either capture serial data or read dimensional timestamped data from a csv.

Thanks,
Brent

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
