# Accurate OEE System

Hi Christian,

I had a meeting with Mike Percell and Jake Kunkel to discuss alternatives to get accurate OEE data for CNC. Then I had a meeting with Kevin Young to get his direction on how to proceed.  The direction was to first work with Kevin to help Mike understand how Plex is calculating OEE, and then to work on an Accurate OEE System. If this is OK with you I would like to discuss adding this project to my task list.

- Thank you
Brent
260-564-4868

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/>.

## Issue

- Mike Parcell is required to give an OEE summary to Jake Kunkel. 
- Wants to understand how Plex calculates OEE.  
- Gets different numbers when he makes the OEE calculation himself.

It is difficult to calculate precise OEE without using an MES system because of consistency issues of when and how CNC operators enter part counts into Plex.

## Question

Can Mach2 calculate OEE in Albion for Jake Kunkel and Mike Percell?

    Mach2 calculates OEE for each cell and retains the data for a short period. Jake and Mike are looking for an OEE summary report over time for Multiple CNC so other alternatives should be explored.

## Short Term Solution

Kevin has already proven the data on the Plex OEE report is correct.  So, work with Brent to summarize this and make it understandable to Mike.

## Long Term Solution

### Create an Accurate OEE System

This MES system is made to collect the start and end times of tool operations, tool changes, and pallet changes for specific CNC and jobs. This software was developed 2 years ago and is proven to work on CNC running RDX and Knuckles jobs. This software needs changes and improvements to be more secure, **[observable](https://www.ibm.com/topics/observability)**, to add a **[notification system](https://novu.co/)**, and to run in the Kubernetes platform we created for our Advanced Reporting System.

Tasks/Resources:
- Purchase CNC Network Module or Serial Port Data Logger.
- Network connection to each CNC to monitor.
- Grant Kubernetes development and production clusters access to CNC.
- Modernize the current MES software
  - to include an alert **[notification system](https://novu.co/)** 
  - to be **[observable](https://www.ibm.com/topics/observability)** 
  - and to run in our Kubernetes platform. 
- Create Power BI reports and dashboards for OEE, tool operation, tool change, pallet change times, etc.
- Locate a sustaining software team to be a backup for OEE system.