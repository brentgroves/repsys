# Marposs visit

Hi Team,
This is a summary of yesterday's meeting.  Thanks for attending.

Thanks,
Brent, 260.564.4868

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

## Summary

**[PpK](https://www.6sigma.us/process-improvement/ppk-process-performance-index/)** provides an indicator of how close the current process is to operating within its limits over the long term. Understanding the factors that impact centering and variation is key.

### Are we ready for a visit? No

We need to finish the below items:

- At least one network cable at JT Fronts cell that is setup to access JT Fronts VLAN from an edge switch POE enabled untagged port. (IT)
- 1 straight-through serial cable with DB9 F/F ends. (Brent)

### Should we modify the program to include some additional parameters?

To ensure traceability we should add CNC and tool change parameters to the program.

**Ensure Traceability:** Make sure all measurements are traceable back to Man (Operator), Machine (Operation), Method, Material, Measurement System, and Environmental Conditions (5Ms, 1E) to enable process improvement. Record Unit Number or Serial Number for each part. I don't think we have serial numbers for each part but we can identify the CNC and tool changes.

## Questions/Answers

1. Are we recording the dimensions of left and right hand parts separately?
No. We are recording dimensions for two of the same part. The parts are identified as station 1 and 2 and from the same CNC.
2. Does Merlin support selecting parameters from a predefined list for the case of CNC#?
3. Does Merlin support selecting multiple items from a predefined set for the case of tool changes?
4. Can these parameters be exported along with dimensional values to the serial port and CSV file.
5. Who would modify the program? I believe Brian Segro or Bill Gstalder could help us to add CNC and tool change parameters. For advanced modifications Larry Becker from quality solutions could help us.

## Notes

## Requirements

1. Capture the data and and put it in a run chart and histogram.
2. Produce 30 day CPK and 90 day PPK.

    - **Cp** measures whether the process spread is narrower than the specification width

    - **Cpk** measures both the centering of the process as well as the spread of the process relative to the specification width

    - The Process Performance Index is known as **PpK**. It is a statistical metric that assesses how closely a process is operating within its long-term specification bounds.

![i](https://www.1factory.com/assets/img/visual-cp-cpk-1factory.png)

## Options for CPK/PPK

- Minitab
- Python Notebook published to Structures Microsoft Fabric workspace.

"Microsoft Fabric is an all-in-one, end-to-end analytics platform that unifies data movement, data lakes, data engineering, data science, and business intelligence into a single, integrated experience. It streamlines data management by providing a unified environment for data professionals to collaborate on projects, offering a comprehensive set of AI-powered tools for the entire data lifecycle, from ingestion to visualization." from Google AI overview.

## references

- **[What is Microsoft Fabric?](https://learn.microsoft.com/en-us/fabric/fundamentals/microsoft-fabric-overview)**

- **[Improve Process Capability and Performance with PpK](https://www.6sigma.us/process-improvement/ppk-process-performance-index/)**
- **[Python Process Capability Analysis (Cp & Cpk) | Normal Data](https://www.youtube.com/watch?v=YLn3YaMs4CQ)**

- **[Python programs in process capability Cp, Cpk, PPM, sigma level](https://www.youtube.com/watch?v=-HFs7Sd73o4)**

- **[A guide to process capability](https://www.1factory.com/quality-academy/guide-process-capability.html#:~:text=Cpk%20measures%20both%20the%20centering,Spec%20Width%20=%20USL%20%E2%80%94%20LSL)**

## Quality Team

- Ron James, Quality Manager
- April Sumner, Quality Engineer
- Nickolas Dekoninck, Quality Engineer
- Chelsea Prill, Quality Engineer
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Sam Jackson, Information Systems Developer, Southfield
- Carl Stangland, Desktop and System Support Technician, Indiana
- Brian Segro, Marposs Sales Engineer,+1 216 702-3887, <brian.segro@us.marposs.com>
Bill Gstalder, Pride Gage Associates, Programmer, <bgstalder@pridegage.com>
MARPOSS CORPORATION
3300 Cross Creek Parkway
Auburn Hills MI 48326
phone: +1 248 370-0404
