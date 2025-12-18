# CNC Tool Life Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

The following is in markdown format, which can be viewed better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Automatically collect CNC, job, and start/end tool operation times for problematic tooling.

Users: Albion Engineering and MRP

## CNC and vending machine requirements

Here are two suggestions that pertain to our custom **[Tool Management](https://en.wikipedia.org/wiki/Tool_management)**, and Tool-Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)** developed by the Structures Information System team.  Thank you.

1. Database access to vending machines.

    When purchasing tool vending machines, please think about asking for programmatic access to the SQL database.

    Reason: We can compare the tooling in our vending machines with our tool management database. This will help us identify tooling that is not in our vending machines and tooling no longer needed.

    Details: When we owned our vending machines, we were able to sync the vending machines with the Busche reporter by running nightly scripts. The process was as follows:

    - The engineers entered detailed information about job tooling.  
    - The engineering managers approved job tooling changes.
    - The MPR personnel, Nancy Swank, was notified of the changes.
    - The tool changes were propagated to our vending machines.

2. Consider including the cost of adding network data collection support to CNC when quoting jobs.

    Reason:  We will be able to report on tool operation times by job, CNC, and date/time.  Our tool tracking software will not have all the features of expensive software such as **[Predator DNC software](https://www.predator-software.com/predator_dnc_software.htm)**, but it will be good enough to identify tooling issues.

    Details: Okuma CNCs have a serial port, which is perfect for collecting data by adding a small change to GCode at the start and end of each tool operation. The only additional cost incurred is an inexpensive **[serial device server](https://www.moxa.com/en/products/industrial-edge-connectivity/serial-device-servers)** and running a network cable to each CNC.

    For Fanuc-based CNC, a more expensive network module must be purchased to achieve the same result. We have successfully tested a preliminary version of our tool tracking software on Knuckles and RDX jobs running on Okuma CNC. We started testing our custom tool tracking software on a couple of Avilla's Fanuc-based CNC, which worked by monitoring tool counter changes and some additional parameters.

Team:

- Pat Baxter, General Manager
- Christian. Trujillo, IT Structures Manager
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Michael Percell, Manufacturing Engineering Manager
- Jami Pyle, MP&L Manager
- Nancy Swank, Material Planner
- Hayley Rymer, IT Supervisor
