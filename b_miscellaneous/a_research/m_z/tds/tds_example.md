# **[TDS protocol examples](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-tds/b46a581a-39de-4745-b076-ec4dbb7d13ec)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## references

- **[TDS protocol](https://wiki.wireshark.org/Protocols/tds)**
- **[Microsoft Docs](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-tds/b46a581a-39de-4745-b076-ec4dbb7d13ec)**
- **[Pre-Login](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-tds/60f56408-0188-4cd5-8b90-25c6f2423868)**

## 4.1 Pre-Login Request

Pre-Login request sent from the client to the server:

```binary
12 01 00 2F 00 00 01 00 00 00 1A 00 06 01 00 20
00 01 02 00 21 00 01 03 00 22 00 04 04 00 26 00
01 FF 09 00 00 00 00 00 01 00 B8 0D 00 00 01
```

```xml
 <PacketHeader>
     <Type>
       <BYTE>12 </BYTE>
     </Type>
     <Status>
       <BYTE>01 </BYTE>
     </Status>
     <Length>
       <BYTE>00 </BYTE>
       <BYTE>2F </BYTE>
     </Length>
     <SPID>
       <BYTE>00 </BYTE>
       <BYTE>00 </BYTE>
     </SPID>
     <PacketID>
       <BYTE>01 </BYTE>
     </PacketID>
     <Window>
       <BYTE>00 </BYTE>
     </Window>
   </PacketHeader>
   <PacketData>
     <PRELOGIN>
       <PL_OPTION_TOKEN>
          <BYTE>00 </BYTE>
       </PL_OPTION_TOKEN>
       <PL_OFFSET>
          <USHORT>00 1A</USHORT> <PacketHeader>
     <Type>
       <BYTE>12 </BYTE>
     </Type>
     <Status>
       <BYTE>01 </BYTE>
     </Status>
     <Length>
       <BYTE>00 </BYTE>
       <BYTE>2F </BYTE>
     </Length>
     <SPID>
       <BYTE>00 </BYTE>
       <BYTE>00 </BYTE>
     </SPID>
     <PacketID>
       <BYTE>01 </BYTE>
     </PacketID>
     <Window>
       <BYTE>00 </BYTE>
     </Window>
   </PacketHeader>
   <PacketData>
     <PRELOGIN>
       <PL_OPTION_TOKEN>
          <BYTE>00 </BYTE>
       </PL_OPTION_TOKEN>
       <PL_OFFSET>
          <USHORT>00 1A</USHORT>
       </PL_OFFSET>
       <PL_OPTION_LENGTH>
          <USHORT>00 06</USHORT>
       </PL_OPTION_LENGTH>
       <PL_OPTION_TOKEN>
          <BYTE>01 </BYTE>
       </PL_OPTION_TOKEN>
       <PL_OFFSET>
          <USHORT>00 20</USHORT>
       </PL_OFFSET>
       <PL_OPTION_LENGTH>
          <USHORT>00 01</USHORT>
       </PL_OPTION_LENGTH>
       <PL_OPTION_TOKEN>
          <BYTE>02 </BYTE>
       </PL_OPTION_TOKEN>
       <PL_OFFSET>
          <USHORT>00 21</USHORT>
       </PL_OFFSET>
       <PL_OPTION_LENGTH>
          <USHORT>00 01</USHORT>
       </PL_OPTION_LENGTH>
       <PL_OPTION_TOKEN>
          <BYTE>03 </BYTE>
       </PL_OPTION_TOKEN>
       <PL_OFFSET>
          <USHORT>00 22</USHORT>
       </PL_OFFSET>
       <PL_OPTION_LENGTH>
          <USHORT>00 04</USHORT>
       </PL_OPTION_LENGTH>
       <PL_OPTION_TOKEN>
          <BYTE>04 </BYTE>
       </PL_OPTION_TOKEN>
       <PL_OFFSET>
          <USHORT>00 26</USHORT>
       </PL_OFFSET>
       <PL_OPTION_LENGTH>
          <USHORT>00 01</USHORT>
       </PL_OPTION_LENGTH>
       <PL_OPTION_TOKEN>
          <BYTE>FF </BYTE>
       </PL_OPTION_TOKEN>
       <PL_OPTION_DATA>
          <BYTES>09 00 00 00 00 00 01 00 B8 0D 00 00 01</BYTES>
       </PL_OPTION_DATA>
     </PRELOGIN>
   </PacketData>
       </PL_OFFSET>
       <PL_OPTION_LENGTH>
          <USHORT>00 06</USHORT>
       </PL_OPTION_LENGTH>
       <PL_OPTION_TOKEN>
          <BYTE>01 </BYTE>
       </PL_OPTION_TOKEN>
       <PL_OFFSET>
          <USHORT>00 20</USHORT>
       </PL_OFFSET>
       <PL_OPTION_LENGTH>
          <USHORT>00 01</USHORT>
       </PL_OPTION_LENGTH>
       <PL_OPTION_TOKEN>
          <BYTE>02 </BYTE>
       </PL_OPTION_TOKEN>
       <PL_OFFSET>
          <USHORT>00 21</USHORT>
       </PL_OFFSET>
       <PL_OPTION_LENGTH>
          <USHORT>00 01</USHORT>
       </PL_OPTION_LENGTH>
       <PL_OPTION_TOKEN>
          <BYTE>03 </BYTE>
       </PL_OPTION_TOKEN>
       <PL_OFFSET>
          <USHORT>00 22</USHORT>
       </PL_OFFSET>
       <PL_OPTION_LENGTH>
          <USHORT>00 04</USHORT>
       </PL_OPTION_LENGTH>
       <PL_OPTION_TOKEN>
          <BYTE>04 </BYTE>
       </PL_OPTION_TOKEN>
       <PL_OFFSET>
          <USHORT>00 26</USHORT>
       </PL_OFFSET>
       <PL_OPTION_LENGTH>
          <USHORT>00 01</USHORT>
       </PL_OPTION_LENGTH>
       <PL_OPTION_TOKEN>
          <BYTE>FF </BYTE>
       </PL_OPTION_TOKEN>
       <PL_OPTION_DATA>
          <BYTES>09 00 00 00 00 00 01 00 B8 0D 00 00 01</BYTES>
       </PL_OPTION_DATA>
     </PRELOGIN>
   </PacketData>
   ```
