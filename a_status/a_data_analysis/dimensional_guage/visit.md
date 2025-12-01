# Marposs visit

Hi Team,
Bill Gstalder, the Pride Gage representive, said he will talk with Brian Segro, the Marposs rep, when he returns from Italy this week about a visit to our Avilla facility.

## Questions

- Should we collect the CNC# and tool counts along with the dimensional values? If so maybe we could ask the Marposs rep to update the program to do this.

## Marposs gage program modification

- The tool setter could enter the CNC and tool number that was changed as part of the tool change process.
- After that the CNC operator/gager, would identify the CNC that is being gaged.
- The marposs gage would increment the tool counts and display the counts when each part is gaged.
- If the tool counts displayed is not correct the CNC operator/gager could change it.
- The feature measurement along with the CNC and tool counts is recorded and output to the CSV file and serial port.

Thanks,
Brent
260.564.4868

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>>.

## Marposs/Pride Gage Visit

## Prelim

- At least one network cable at JT Fronts cell that is setup to access JT Fronts VLAN from an edge switch POE enabled untagged port. (IT)
- 1 straight-through serial cable with DB9 F/F ends. (Still needs order)

## Setup

- The Marposs gage computer is powered by a 36V DC converter plugged into a standard 120VAC outlet.
- One of the two Marposs gage computer USB ports is connected to a 10 port USB hub.
- One model B6871250050 Easy Box U8I/O with 8 INPUT/OUTPUT which is not being used.
- Three **[EasyBox U4F-HR, U4H, or U4T transducers](https://www.marposs.com/media/4263/d-1/t-file/D6D02000G0.pdf)** to connect up to 4 MARPOSS standard full-bridge or half-bridge transducers

## Windows

- There are two USB ports on the Marposs Gage computer. 1 USB port is connected to a 10 port USB hub and the other may be being used by a thumb drive. The USB hub is being used to power four EasyBox units.
- Identify Windows edition and version.
- How to safely exit and restart the Merlin UI and Windows.
- Are the 2 serial ports recognized by Windows.
- Are the 2 network ports functional.
- What is the Windows username/password.
- Does the user have admin rights.
- Config the Marposs gauge computers serial port. (Brent)
  - To configure a serial port in Windows 10, open Device Manager, expand Ports (COM & LPT), right-click the desired serial port, select Properties, and then go to the Port Settings tab to adjust parameters like baud rate, data bits, and parity.
  - Serial Port Settings:

      ```yaml
      baud: 9600
      parity: N
      data bits: 8
      stop bits: 1
      ```

## Merlin

- How to backup existing programs to a USB drive.
- How to change between different programs.
- How are CSV files being created and archived.
- How to make a very simple program for testing.

## Serial Device Server

- Attach the Serial Device Server to the configured serial port of the Marposs gauge computer using a straight-through serial cable with DB9 F/F ends. (Brent)
- Create and load simple test program.
- From test program output to serial port.
- Connect to serial device server's TCP socket from the IT ofice and verify the test program data is being sent. (Brent)

## Quality Team

- Ron James, Quality Manager
- April Sumner, Quality Engineer
- Nickolas Dekoninck, Quality Engineer
- Chelsea Prill, Quality Engineer
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Sam Jackson, Information Systems Developer, Southfield
- Carl Stangland, Desktop and System Support Technician, Indiana
- Brian Segro, Marposs Sales Engineer,+1 216 702-3887, <brian.segro@us.marposs.com>
Bill Gstalder, Pride Gage Associates, Programmer, <bgstalder@pridegage.com>
MARPOSS CORPORATION
3300 Cross Creek Parkway
Auburn Hills MI 48326
phone: +1 248 370-0404
