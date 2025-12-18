# **[Sticky Session](https://www.imperva.com/learn/availability/sticky-session-persistence-and-cookies/#:~:text=With%20sticky%20sessions%2C%20a%20load,the%20duration%20of%20the%20session.)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## What is a sticky session

Session stickiness, a.k.a., session persistence, is a process in which a load balancer creates an affinity between a client and a specific network server for the duration of a session, (i.e., the time a specific IP spends on a website). Using sticky sessions can help improve user experience and optimize network resource usage.

With sticky sessions, a load balancer assigns an identifying attribute to a user, typically by issuing a cookie or by tracking their IP details. Then, according to the tracking ID, a load balancer can start routing all of the requests of this user to a specific server for the duration of the session.
