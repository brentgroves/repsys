# Device to Enterprise applications

This is a markdown file if it looks a little strange. You could use visual studio code or an online viewer such as <https://dillinger.io/>

## references

<https://www.itemis.com/en/products/itemis-create/documentation/user-guide/overview_what_are_state_machines>

<https://www.tridium.com/us/en/Products/niagara>

<https://www3.technologyevaluation.com/research/article/plex-manufacturing-cloud-smart-factory.html>

<https://www.facebook.com/watch/?v=429019737979745>

## Why discuss this

To look at some of the features that make Mach2 a good choice for companies using Plex.

## topics

- Manufacturing Execution System
- What is Niagara
- What is Mach2
- Linamar Manufacturing Monitoring System (LMMS)

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

## Linamar Manufacturing Monitoring System (LMMS)

<https://www.facebook.com/watch/?v=429019737979745>

One #innovative concept that industry 4.0 has developed is that machines are now not only producing products but also collecting statistical data to create smart algorithms. This data is used to not only detect but also predict product failures and deviations in a product line. By doing this we can improve quality, part availability, overall efficiency.
At #Linamar one of the ways we use and collect #BigData is through our Linamar Manufacturing Monitoring System (LMMS), where a barcode is scanned at every step of the manufacturing process. This feature provides us with constant anti-error checks and simply by scanning the barcode we can see a complete and detailed history of every step of the parts creation! This use of Big Data and Advanced Analytics is very important in the future of manufacturing and is just another way Linamar is working to help create the #FactoryofTheFuture
