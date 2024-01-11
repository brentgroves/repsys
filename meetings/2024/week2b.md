# Father's directions

The world's love is performance based, but my love is unconditional. The world's system promotes fear to be better than your neighbor.  I say help your neighbor and especially help the ones that are struggling.

## Grafana Dashboard

![Grafana dashboard](https://grafana.com/api/dashboards/1860/images/7994/image)

**Last meeting summary**,

Sam talked about KepServerEx and Mach2, Brenden talked about Microsoft deployment service, and Robert Decker joined our meeting.

About Friday's meeting,

Hi guys.  I'm hoping we can have some fun in this meeting!  If there is any tech or thoughts about current trends you could share I'm sure it would be appreciated by the group, but no pressure if you would rather not :-)

- Kevin what software and hardware is needed to virtualize graphics intense software.
- Brad how what software does Fruitport machines use?
- Sam something about Mach2 or Kep ServerEx if you want :-)
- Brendan something about IT Administration or anything you want :-)
- Brent G. Plex and Report System Federated with Microsoft Entra ID

## **[Manufacturing Execution System](https://www.plex.com/products/manufacturing-execution-system)**

- people still manually enter much of their data.
- For every action on the plant floor, there is a transaction in Plex.

## **[State machine](https://www.itemis.com/en/products/itemis-create/documentation/user-guide/overview_what_are_state_machines)**

A state machine is a behavior model. It consists of a finite number of states and is therefore also called finite-state machine (FSM). Based on the current state and a given input the machine performs state transitions and produces outputs. There are basic types like Mealy and Moore machines and more complex types like Harel and UML statecharts.

![](https://www.itemis.com/hubfs/solutions/itemis-create/documentation/images/overview_simple_moore.jpg)

<https://sparxsystems.com/resources/tutorials/uml2/state-diagram.html>

![](https://sparxsystems.com/images/screenshots/uml2_tutorial/sm01.GIF)

## **[Niagara](https://www.tridium.com/us/en/Products/niagara)** Framework

Niagara provides the critical, cyber-secure device connectivity and data normalization capabilities needed to acquire and unlock operational data from device-level and equipment-level silos. The control engine at the core of Niagara enables users to not just monitor data flows, but to create logic sequences that effect controls programming based on data observation. Systems integrators use the data management and user presentation applications built into Niagara to manage histories, schedules and alarms. They can create custom user interfaces for end users with the tools built into Niagara, or purchase graphical UI templates and components from the many Niagara partners that specialize in graphics and dashboarding.

![](https://honeywell.scene7.com/is/image/honeywell/Niagara_stack_picture1)

- When you look at Niagara programs they look like UML statecharts
- Graphical oriented programming, similar to **[Node-Red](https://en.wikipedia.org/wiki/Node-RED)**

![](https://hvac-talk.com/vbb/attachment.php?attachmentid=836267&d=1657552210)
![](https://www.niagara-solution-provider.store/fileadmin/bilder/products/niagara4/Niagara_4_dashboard.jpg)

![](https://www.niagara-solution-provider.store/fileadmin/bilder/products/niagara4/1-1-10_Development.jpg)
![](https://honeywell.scene7.com/is/image/honeywell/2022-05-12-WebWiresheet-2.0-Pictures?wid=1000&hei=636&dpr=off)

## Mach2 Kors Engineering Framework

<https://www3.technologyevaluation.com/research/article/plex-manufacturing-cloud-smart-factory.html>

Plex Systems, Inc. is a leading provider of cloud-delivered smart manufacturing solutions. The vendor recently announced the acquisition of Kors Engineering, a privately held, Michigan-based provider of plant floor connectivity and manufacturing process automation software. Kors Engineering has been a Plex partner for 20 years, and they have many shared customers from multiple manufacturing verticals.  

- Device-to-ERP system using Niagara
- Kors engineering spent 20 years developing components for Plex
- Mach2 has complete knowledge of Plex web services
- Not meant to collect big data but it can easily do this
- Calls ERP web services to update Plex silently or graphically
- Good Plex screen support including clickable sections of part graphics

![](https://cdn1.technologyevaluation.com/getattachment/a6f2315c-483b-58ef-ac94-541e6eb55098/Plex-Mach2-at-Thai-Summit-America-(1).png?source=tw2&ext=.png&width=834)

![](https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3Due9rdMl_MoU&psig=AOvVaw39PUqrAFYR6oO0VkZPeS7J&ust=1703357944804000&source=images&cd=vfe&ved=0CBIQjRxqFwoTCKjZ0v3co4MDFQAAAAAdAAAAABAE)

<https://www.youtube.com/watch?v=otHzWAQqYb4>


## What is **[IAM](https://www.techtarget.com/searchsecurity/definition/identity-access-management-IAM-system)**, Identity and Access management? 

Identity and access management (IAM) is a framework of business processes, policies and technologies that facilitates the management of electronic or digital identities. With an IAM framework in place, information technology (IT) managers can control user access to critical information within their organizations. Systems used for IAM include single sign-on systems, two-factor authentication, multifactor authentication and privileged access management. These technologies also provide the ability to securely store identity and profile data as well as data governance functions to ensure that only data that is necessary and relevant is shared.

IAM systems can be deployed on premises, provided by a third-party vendor through a cloud-based subscription model or deployed in a hybrid model.

On a fundamental level, IAM encompasses the following components:

- how individuals are identified in a system (understand the difference between identity management and authentication);
- how roles are identified in a system and how they are assigned to individuals;
adding, removing and updating individuals and their roles in a system;
- assigning levels of access to individuals or groups of individuals; and
- protecting the sensitive data within the system and securing the system itself.

## **[API Gateways](https://callistaenterprise.se/blogg/teknik/2023/04/20/kong-api-gateway-part1/)**

An API Gateway is an architectural pattern which introduces a transparent placeholder between API clients and the APIs, where Cross Cutting Concerns such as Access Control, Monitoring, Logging, Caching and Rate Limiting can be implemented.

Whenever a customer accesses any Repsys software it will be routed through **[Microsoft EntraID identity](https://www.microsoft.com/en-us/security/business/identity-access/microsoft-entra-id)** (formerly Azure Active Directory).

## Repsys **[IAM](https://en.wikipedia.org/wiki/Identity_management)**, Identity and Access Management

- Secure Web App, REST API, and report notification webhook using the **[Kong API gateway](https://konghq.com/products/kong-gateway)**.
- Use **[Keycloak](https://www.keycloak.org/)** for IAM.  
- Use Microsoft EntraID as an Identity Provider to Keycloak IAM platform.
- Register in Microsoft EntraID with an **[OpenID Connect, OIDC](https://www.microsoft.com/en-us/security/business/security-101/what-is-openid-connect-oidc#:~:text=OpenID%20Connect%20(OIDC)%20is%20an,who%20they%20say%20they%20are.)** scope.
