# work with e0986 usb serial cable in linux

**[](https://kb.plugable.com/serial-adapter/how-to-connect-to-a-serial-device-linux#:~:text=For%20USB%20serial%20devices%20like,prompted%20to%20kill%20the%20session.)**

- **[](https://www.youtube.com/watch?v=YNfvNvqnYgM&t=8)**

To work with a USB serial cable in Linux, the generic usbserial driver in the Linux kernel typically provides built-in support for most adapters, often without needing manual driver installation. Your cable will likely be assigned a name like /dev/ttyUSB0.

The main steps involve:

- Connecting the cable and verifying detection.
- Identifying the assigned serial port name.
- Using a terminal program to communicate over the port.
- Troubleshooting permissions if necessary.

## Step 1 & 2: Connect and Identify the Device

- Plug in the E0986 USB serial cable.
- Open a terminal and use the dmesg command to check kernel messages and confirm the system recognizes the device and which port it's assigned to.

```bash
sudo dmesg | tail
[12838.557880] usb 3-4.1: Product: FT232R USB UART
[12838.557882] usb 3-4.1: Manufacturer: FTDI
[12838.557883] usb 3-4.1: SerialNumber: AO003HLH
[12838.583110] usbcore: registered new interface driver usbserial_generic
[12838.583118] usbserial: USB Serial support registered for generic
[12838.586563] usbcore: registered new interface driver ftdi_sio
[12838.586578] usbserial: USB Serial support registered for FTDI USB Serial Device
[12838.586629] ftdi_sio 3-4.1:1.0: FTDI USB Serial Device converter detected
[12838.586660] usb 3-4.1: Detected FT232R
[12838.587153] usb 3-4.1: FTDI USB Serial Device converter now attached to ttyUSB0
```

Look for output similar to: ... converter now attached to ttyUSB0 or ... FTDI USB Serial Device converter now attached to ttyUSB0. This identifies your serial port as /dev/ttyUSB0 (it could also be ttyUSB1, ttyACM0, etc.).
Alternatively, you can list available tty devices:

```bash
ls /dev/ttyUSB*
/dev/ttyUSB0

```

## Step 3: Communicate Using a Terminal Program

Use a program like screen or minicom to establish a connection. screen is often simpler for basic use.
Install screen if it's not already installed:

```bash
sudo apt update
sudo apt install screen
```

Connect to the serial port. You'll need to know the correct baud rate for the device you're connecting to (common rates are 9600, 115200, etc.).

```bash
sudo screen /dev/ttyUSB0 9600
```

(Replace /dev/ttyUSB0 and 9600 with your identified port and the correct baud rate).

You can now type into the terminal to send data or read output from the connected device.

To exit screen, press Ctrl+a, then press k, and then y when prompted to kill the session.

```

## Step 4: Troubleshooting Permissions

If you receive a "Permission denied" error, your user account likely needs to be added to the dialout group to access serial ports. 
Add your user to the dialout group:

```bash
sudo usermod -a -G dialout $USER
```

Log out and log back in (or reboot) for the changes to take effect. You should now be able to use the cable without sudo.

## Identifying the Chipset (Advanced)

If the device isn't automatically detected, the exact chipset (e.g., Prolific PL2303, FTDI, CH340, etc.) is the key to ensuring compatibility. Use the lsusb command to list device details, including vendor and product IDs:

```bash
lsusb
```

The output will show entries like ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port which helps confirm the chipset and verify the kernel has loaded the correct module.
