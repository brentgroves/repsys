# Accurate OEE System

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research Summary](./research_summary.md)**\
**[Back Main](../../README.md)**

![np](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de6a24f3bc7cfdb5711e46_ethernet2.jpeg)

It is difficult to calculate precise OEE without using a MES system, such as Mach2.

## **[What is a MES system](https://en.wikipedia.org/wiki/Manufacturing_execution_system)**

A manufacturing execution system, or MES, is a comprehensive, dynamic software system that monitors, tracks, documents, and controls the process of manufacturing goods from raw materials to finished products.

## Alternatives

- Find out if Mach2 can calculate OEE in Albion for Jake Kunkel and Mike Percell
    Mach2 calculates OEE for each Cell and retains the data for a short period of time. Jake and Mike are looking for an OEE report over time for Multiple CNC so an Intelliplex or Power BI report seems a better fit for the requirement.

- Create a Power BI report from our advanced reporting system.

    This report may not be any better than the OEE VP Plex report we are currently using. We can add some checks that would check for cases such as the operator updating Plex slightly after their shift. This report depends on our Reporting System which is scheduled to be completed in the Feb/March timeframe.

    Estimated Time to complete: 1 month after our advanced reporting system is completed.
- Predator
- Create an Accurate OEE System.

    This MES system is made to collect the start and end times of tool operations, tool changes, and pallet changes for specific CNC and jobs. This software was developed 2 years ago for RDX and Knuckles but was not finished.

  - CNC Module or Serial Port Data Logger.
  - GCode changes amounting to 1 command before any tool operation and 1 command after the tool operation.
  - Network connection to each CNC to monitor.
  - MES software to collect data
  - Power BI reports for OEE, tool operation, tool change, and pallet change times.
  - Sustaining software engineer

    Estimate Time to Complete: 1 year
