# https://stackoverflow.com/questions/34981859/openssl-fetching-sql-server-public-certificate
# https://github.com/python/cpython/commit/8e836bb21ce73f0794fd769db5883c29680dfe47#diff-d526ded1c360bed6b222de46f4ca92b834f978ebed992fb3189bf9a94a198578
# you can find the security level by looking at the context variable:
# sslctx.security_level
import sys
import pprint
import struct
import socket
import ssl
from time import sleep 

# Standard "HELLO" message for TDS :smile🔥
prelogin_msg = bytearray([      0x12, 0x01, 0x00, 0x2f, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x1a, 0x00, 0x06, 0x01, 0x00, 0x20,
                                0x00, 0x01, 0x02, 0x00, 0x21, 0x00, 0x01, 0x03, 0x00, 0x22, 0x00, 0x04, 0x04, 0x00, 0x26, 0x00,
                                0x01, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ])

# Prep Header function
def prep_header(data):
        data_len = len(data)
        prelogin_head = bytearray([ 0x12, 0x01 ])
        header_len = 8
        total_len = header_len + data_len
        data_head = prelogin_head + total_len.to_bytes(2, 'big')
        data_head += bytearray([ 0x00, 0x00, 0x01, 0x00])
        return data_head + data
        
def read_header(data):
    if len(data) != 8:
        raise ValueError("prelogin header is > 8-bytes", data)
    
    format = ">bbhhbb"
    sct = struct.Struct(format)
    unpacked = sct.unpack(data)
    return {    "type": unpacked[0], 
                "status": unpacked[1],
                "length": unpacked[2],
                "channel": unpacked[3],
                "packet": unpacked[4],
                "window": unpacked[5]
    }
    
tdspbuf = bytearray()
def recv_tdspacket(sock):
    global tdspbuf
    tdspacket = tdspbuf
    header = {}
    
    for i in range(0,5):
        tdspacket += sock.recv(4096)
        print("\n# get_tdspacket: {}, tdspacket len: {} ".format(i, len(tdspacket)))
        if len(tdspacket) >= 8:
            header = read_header(tdspacket[:8])
            print("# Header: ", header)
            if len(tdspacket) >= header['length']:
                tdspbuf = tdspacket[header['length']:]
                print("# Remaining tdspbuf length: {}\n".format(len(tdspbuf)))
                return header, tdspacket[8:header['length']]
                
        sleep(0.05)

# Ensure we have a commandline
# microk8s-vm,31433
# busche-sql,1433
if len(sys.argv) != 3:
        print("Usage: {} <hostname> <port>".format(sys.argv[0]))
        sys.exit(1)

hostname = sys.argv[1]
port = int(sys.argv[2])

# https://stackoverflow.com/questions/72479812/how-to-change-tweak-python-3-10-default-ssl-settings-for-requests-sslv3-alert
# Setup SSL
if hasattr(ssl, 'PROTOCOL_TLS'):
    sslProto = ssl.PROTOCOL_TLS
else:
    sslProto = ssl.PROTOCOL_SSLv23
    
sslctx = ssl.SSLContext(sslProto)
# sslctx.security_level = 2
sslctx.check_hostname = False

# context = ssl.SSLContext()
# ciphers = ":".join([
#     "@SECLEVEL=1", #python 3.10 default is SECLEVEL=2 which rejects less secure ciphers
#     "ALL",
# ])
# context.set_ciphers(ciphers)


tls_in_buf = ssl.MemoryBIO()
tls_out_buf = ssl.MemoryBIO()

# Create the SSLObj connected to the tls_in_buf and tls_out_buf
tlssock = sslctx.wrap_bio(tls_in_buf, tls_out_buf)

# create an INET, STREAMing socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setblocking(0)
s.settimeout(1)

# Connect to the SQL Server
s.connect(( hostname, port ))

# Send the first TDS PRELOGIN message
s.send(prelogin_msg)

# Get the response and ignore. We will try to negotiate encryption anyway. 
header, data = recv_tdspacket(s)
while header['status']==0:
    header, ext_data = recv_tdspacket(s)
    data += ext_data
    

print("# Starting TLS handshake loop..")
# Craft the packet
for i in range(0,5):
    try:
        tlssock.do_handshake()
        print("# Handshake completed, dumping certificates")
        peercert = ssl.DER_cert_to_PEM_cert(tlssock.getpeercert(True))
        print(peercert)
        sys.exit(0)
    except ssl.SSLWantReadError as err:
        # TLS wants to keep shaking hands, but because we're controlling the R/W buffers it throws an exception
        print("# Shaking ({}/5)".format(i))
    
    tls_data = tls_out_buf.read()
    s.sendall(prep_header(tls_data))
    # TDS Packets can be split over two frames, each with their own headers.
    # We have to concat these for TLS to handle nego properly
    header, data = recv_tdspacket(s)
    while header['status']==0:
        header, ext_data = recv_tdspacket(s)
        data += ext_data
    
    tls_in_buf.write(data)
    
print("# Handshake did not complete / exiting")