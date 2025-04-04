# Busche Tool List and Reporter

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research Summary](./research_summary.md)**\
**[Back Main](../../README.md)**

![np](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de6a24f3bc7cfdb5711e46_ethernet2.jpeg)

The following is in markdown format it can be viewed better by copying the contents into the <https://markdownlivepreview.com/> website.

## What is being requested?

Options:

1. Normal Way - The laptops and desktops connected to the Linamar network to have access to a Crystal Report Viewer, Busche Reporter, and the Busche Tool List database.
2. Remote into VM Way - Employees needing access to the Crystal Report Viewer, Busche Reporter, should be able to remote into a VM with access to this SQL database and Report Viewer.

## Reason for request

- All Job Tooling data from 2004 until the time Mobex Global bought Busche was entered in the Busche Tool List SQL database.
- Several Crystal reports access this database to identify tooling associated with each job.
- We need to get rid of tooling no longer needed.

## History

- The Busche Tool List was made around 2004 in a popular programming language called Visual Basic 6 by a CNC engineer named Aaron Schoon. Over the years software teams and I updated it as needed since Aaron was no longer working here.

## What is the Busche Tool List?

It is a database tool management system, such as **[WinTool](https://www.wintool.com/en)**, or **[CribWise](https://cribwise.com/key-considerations-for-effective-cnc-tooling-management/)**, but being custom software used and developed by a Busche CNC engineer with input from people such as Nancy Swank, and I believe Ben Manus, it did exactly what we wanted no more and no less. For instance, it communicated with **[Cribmaster](https://www.linkedin.com/company/cribmaster/)** which was our inventory and asset management system, **[Made2Manage](https://www.aptean.com/en-US/solutions/erp/products/aptean-industrial-manufacturing-multi-site-erp)** which was our ERP system before Plex, and our Busche owned ToolBoss vending machines.  

It was a way to communicate tooling requirements between MRO and Engineering. It was a process-driven way of managing our tooling that involved:

- CNC engineers adding job tooling as part of their job setup process.
- MRO personnel receiving requests to stock new tooling.
- Engineering managers for tooling approvals.
- Not part of the Busche Tool List, but using it Nancy and other MRO personnel were able to purchase only the tooling we needed based upon her understanding of the jobs running at the time and current stock in our Vending machines.
- Our tool grinder, Ben Maynus, used it to know what jobs tooling is used for. He could also prioritize tooling to sharpen based on his knowledge of which jobs were currently running.

## What is the Busche Reporter?

The Busche Reporter is the **[Crystal Report Viewer](https://www.sap.com/products/technology-platform/crystal-reports.html)**. Crystal Reports was the most popular reporting software of the period starting around 1994 and continued its dominance until around 2011 when Microsoft released Power BI.

## What are the Tool List and Where Used reports?

- They are Crystal Reports that are accessed by the Crystal Report Viewer.
- The Tool List shows tooling by job operation.
- The Where Used report shows every job tooling was used.
