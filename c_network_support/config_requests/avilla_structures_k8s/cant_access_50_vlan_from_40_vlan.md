# Avilla Structures Kubernetes Cluster


## ticket: RITM0189810
 
Hi Justin. I hope you are feeling better today!

Disclaimer: This is for our automated report system and tool tracking MES running on the Avilla Structures Kubernetes Cluster. On 3 Dell PowerEdge R620 servers, I have configured 2 Network Interfaces on each machine.  1 network interface has an IP address of 10.188.220.(200-202) and we are using it to connect to UDP serial device servers on the 10.188.220.0 OT vlan.  The other network interface is a part of the server vlan and has an IP address of 10.188.50.(200-202). It allows report users access to the microservices deployed on the Avilla Structures Kubernetes Cluster. It has come to my attention that having more than 1 network interface in a machine may go against Linamar network policies. If so, I apologize and will remove the 2nd network interface.

## Configuration Request Details

Issue: Avilla Structures cannot ping or ssh to 10.188.50.(200-202) from the 10.188.40.x vlan.
Request: Jared Davis suggested I ask if you can see if the firewall has been blocking traffic to these 3 servers. 
Details: We setup up 3 servers with 10.188.50.(200-202) IP addresses. Can ping and ssh to these servers from computers on the 10.188.50.x vlan. Cannot ping or ssh to these 3 servers from computers on the 10.188.40.x vlan, but can ping/scan all other servers on the 10.188.50.x vlan from computers on the 10.188.40.x vlan.  

I would appreciate any help you can give us.  

Thank you for your time!
Brent Groves
260-564-4868

## Root Cause Guess

Hi Jared.  Good luck today and happy Friday!  

10.188.40.230 to 10.188.50.200 issue: Fortigate is not expecting the response from my laptop's request to 10.188.50.200 to have a source of 10.188.220.254 which is the default route I configured on the R620. I could either add routes for all possible source vlan requests to the r620's local routing table, ie, 10.188.40.x through 10.188.50.254, or give up having multiple network interfaces on the r620 and put in network config requests to allow kubernetes users to access the microservices running on the private network behind 10.188.220.200.

which have a destination of 10.188.50.200 are being sent from 10.188.40.230 machine to come through the 10.188.50.254 gateway.  Since I did not configure a local route to the 10.188.40.0/24 vlan through the 10.188.50.254 gateway the responses which have a source of 10.188.50.200 and a destination of 10.188.40.230 are not accepted by the default route, 10.188.220.254, that I configured.  The end result is that 10.188.220.254 does not accept packets with source 10.188.50.200 and the response is lost.