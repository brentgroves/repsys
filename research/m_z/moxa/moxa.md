# **[](https://www.moxa.com/en/products/industrial-edge-connectivity/serial-device-servers/general-device-servers/nport-5100a-series/nport-5150a)**

There is an ISO image of the software CD and we can mount it to the laptop's Win11 VM.
We can also connect to the web server of the SDS to perform configuration tasks. If the IP address needs to be changed to a different subnet you can connect both the laptop and SDS to small isolated switch.

## Serial Device Server

```yaml
ip: 10.188.74.11
gw: 10.188.74.254
ns: none
mask: 255.255.255.0
admin:admin
moxa:moxa
servername: NPP5150A_9693


IP address: 10.188.74.11
Netmask: 255.255.252.0
Gateway: 10.188.74.254
IP configuration: Static
DNS server 1: 10.225.50.203
DNS server 2: 10.224.50.203


Model: NPort P5150A
Name: NPP5150A_9693
Serial NO.: 9693
Firmware 1.5 Build: 19032122
IP: 10.188.74.11
Mac Address" 00:90:E8:85:C7:B3
Up Time: 0 days 00h:02m:46s
Serial Port 1: 9600,None,8,1

```

```yaml
Baud Rate: 9600
Data Bits: 8
Stop Bits: 1 
Parity: none
Flow Control: XON/XOFF
Fifo: enabled
interface: rs-232
```

## udp

```yaml
Operation mode: UDP
Destination IP address Range: 1 
Begin Port: 10.1.1.83:2222 default port is 4001 but we used 2222
End Port: 10.1.1.83:2222
Destination IP address Range: 2 - 4 not configured 
Local listen port: 4065
```

Data Packing

```yaml
Packing length: 0 (0 - 1024)
Delimiter 1: 00 (Hex)  not Enabled
Delimiter 2: 00 (Hex)  not Enabled
Delimiter process 
Do Nothing:  (Processed only when packing length is 0)
Force transmit: 0 (0 - 65535 ms)
```

General Device Servers

Our NPort device servers make your serial devices network-ready in an instant. Their compact size makes them ideal for connecting devices such as card readers and payment terminals to an IP-based Ethernet LAN.

Introduction
The NPort® 5100A device servers are designed to make serial devices network-ready in an instant and give your PC software direct access to serial devices from anywhere on the network. The NPort® 5100A device servers are ultra-lean, ruggedized, and user-friendly, making simple and reliable serial-to-Ethernet solutions possible.

A Greener Serial-to-Ethernet Solution
The MiiNe is a small but powerful Arm-based serial-to-Ethernet SoC with RAM and Flash embedded. With the MiiNe inside, the NPort® 5110A Series' power consumption is less than 1 W. The NPort® 5100A Series saves at least 50% on power consumption compared to existing solutions on the market, helping engineers meet the tough environmental compliance challenges found in today’s industrial environments.

3-Step Web-based Configuration
The NPort® 5100A’s 3-step web-based configuration tool is straightforward and user-friendly. The NPort® 5100A’s web console guides users through three simple configuration steps that are necessary to activate the serial-to-Ethernet application. With this fast 3-step web-based configuration, a user only needs to spend an average of 30 seconds to complete the NPort® settings and enable the application, saving a great amount of time and effort.

Easy to Troubleshoot
NPort® 5100A device servers support SNMP, which can be used to monitor all units over Ethernet. Each unit can be configured to send trap messages automatically to the SNMP manager when user-defined errors are encountered. For users who do not use SNMP manager, an email alert can be sent instead. Users can define the trigger for the alerts using Moxa’s Windows utility, or the web console. For example, alerts can be triggered by a warm start, a cold start, or a password change.

![i](https://cdn-cms-frontdoor-dfc8ebanh6bkb3hs.a02.azurefd.net/Moxa/media/PDIM/S100000205/moxa-nport-5100a-series-appearance-image-eng.png)
