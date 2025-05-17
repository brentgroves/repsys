# Tool Management System Team

## Notes

- Nancy filling out a job sheet making sure to add the Plex supply item number into the database.
- tool changes were entered into database
- great UI
- Mills River Tool Management: react.js/.net/sql
- Rianto Koisaba, Mills River Controls Engineer - Backend .net/sql developer
- Willie Brown, Mills River Engineering Supervisor - Worked with Hayley to make system.
- Stephen Strzalkowski, Tooling Engineer Supervisor, Ben's counter-part wants to be included going forward.

Hi Team,

Hayley Rymer suggested having a meeting to tell us about the tool management software her team has developed.

Thank you.

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

## Agenda

- Why update our tool management system: Brent Groves
- Features in existing Tool Management System: Hayley, Rymer
- Questions

## Team

- Hayley Rymer, IT Supervisor
- Pat Baxter, General Manager
- Michael Percell, Manufacturing Engineering Manager
- Jami Pyle, MP&L Manager
- Nancy Swank, Material Planner
- Christian. Trujillo, IT Structures Manager
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Rianto Koisaba, Mills River Controls Engineer
- Willie Brown, Mills River Engineering Supervisor
- Stephen Strzalkowski, Tooling Engineer Supervisor

## Why update our Tool Management System

- The Structures Tool Management System is tailored to our business.
- It is easy to use and even after it was dropped several years ago we still need it.
- It combines the data collected in ERP, Vending Machines, and Tool Lists for easy reporting.
- It provides a way to communicate tooling requirements to each other.

## Tool Management System Feature List

- CNC engineers use it to manage job tooling.
- Engineering managers use it to approve job tooling.
- MRO personnel are notified by it of new tooling to stock.
- ERP and Vending Machines integration with our automated **[ETL](https://www.getdbt.com/blog/extract-transform-load)** reporting system.
- Since it is integrated with our vending machines and **[Plex ERP system](https://www.plex.com/products/enterprise-resource-planning)** we can report which tooling is needed to fulfill job orders.
- Since it stores all data in a centralized data warehouse we can link it with data collected by our tool-focused **[MES](http://ibm.com/think/topics/mes-system#:~:text=The%20primary%20purpose%20of%20an,the%20status%20of%20production%20activities.)** system to track tooling issues in real-time.
- It leverages platform services provided by the Structures Avilla Kubernetes Cluster such as **[Authentication and Authorization](https://auth0.com/blog/why-auth0-by-okta/)** and **[Email service](https://mailtrap.io/email-sending/)**.

## Background

- Albion is transitioning to a new vending machine and currently has older tool lists in a legacy database and newer tool lists in Excel.
- The Structures Information Systems team is scheduled to update the Busche Reporter legacy tool management system. If an existing system is available we could use it and possibly add some additional features listed below.
- We were planning to run it on the Structures Avilla Kubernetes Cluster so that we can use **[Kubernetes Observability features](https://www.cloudbolt.io/blog/kubernetes-observability#:~:text=Kubernetes%20observability%20is%20essential%20for,pinpoint%20issues%20when%20they%20arise.)**  and make available the following Platform services.

## Kubernetes Platform Services

- **[Authentication and Authorization](https://auth0.com/blog/why-auth0-by-okta/)**
- **[Zero-Trust Service Mesh Gateway](https://istio.io/latest/about/service-mesh/)**
- **[Job Queue](https://www.ibm.com/think/topics/redis#:~:text=Redis%20(REmote%20DIctionary%20Server)%20is,speed%2C%20reliability%2C%20and%20performance.)**
- **[Email service](https://mailtrap.io/email-sending/)**
- **[SMS Notification Service](https://novu.co/)**
- **Structures Report Automation System**
