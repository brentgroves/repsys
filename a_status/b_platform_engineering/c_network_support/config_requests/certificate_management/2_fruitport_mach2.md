
# Fruitport Mach2 server certificate management testing

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Request: Please update the Avilla Structures "Kubernetes to untrust" policy.

Project: Mach2 Servers and Avilla Structures Kubernetes Cluster

Affected Application: Fruitport Mach2 server, Kubernetes Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Fruitport Mach2 server is used to insert database transactions into the Plex ERP. The Avilla Structures Kubernetes Cluster will be used run Structures Information software such as the Automated Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Policy Change

1. Please give the Structures certificate management PKI system, 10.188.220.[230], temporary access to the Fruitport Mach2 server for certificate testing.
Reason: To test that the Mach2 JBoss server is passing the new certificate chain as expected.

Key points about the firewall rule:

- Protocol: TCP
- Port: 80/443
- Action: Allow
- source: 10.188.220.230
- Destination: 10.184.220.?

## Testing

```bash
# Alpine Linux package manager CDN
curl -vv telnet://frt-mach2.linamar.com:443
curl -vv telnet://frt-mach2:443

sudo tcpdump -i any -nn dst host frt-mach2.linamar.com
sudo tcpdump -i any -nn dst host frt-mach2
```

John Biel
