# pyserial from a socket

**[](https://github.com/xanthium-enterprises/CrossPlatform-Serial-Port-Programming-using-Python-and-PySerial/tree/master/_1_Python3_Codes)**
**[garbage characters](https://stackoverflow.com/questions/26803825/python-read-serial-rs-232-data-over-tcp-ip)**
PySerial can interact with a TCP/IP socket that acts as a serial port bridge, allowing applications designed for serial communication to connect to network-enabled serial port converters. This is achieved through PySerial's URL handlers.
To use PySerial with a socket, specify the connection type as socket:// followed by the host and port of the TCP/IP socket. For example, to connect to a socket on localhost at port 1234:

```python
import serial

ser = serial.Serial('socket://localhost:1234', timeout=1) 
# The timeout parameter is important for controlling read behavior.

# Now, you can use 'ser' as if it were a regular serial port object
# to send and receive data.
ser.write(b'Hello from PySerial!\n')
data = ser.read(10)
print(f"Received: {data}")

ser.close()
```
